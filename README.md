Jenkins for IdP Installer Cookbook
==================================
This cookbook installs and configures Jenkins for use with the IdP installer. The `default` recipe will install and configure the Jenkins master while the `slave` recipe will configure a slave for testing. It's also assumed that Jenkins will be using OpenStack for provisioning slaves. If that's not the case, uninstall the JClouds plugin from Jenkins and configure another provisioning method or just change the provider if using a different cloud type.

__WARNING: Security is NOT configured for the Jenkins master. Access should be restricted using another method (eg. OpenStack security groups) until security is manually configured.__

Requirements
------------
### idp-installer-jenkins::default
#### platforms
- `Ubuntu 14.04`
- `CentOS 7.x`

### idp-installer-jenkins::slave
#### platforms
- `CentOS 6.6/7.x`

### Environment
- `Chef 11+`
- `Ruby 1.9.3+`

Attributes
----------
#### idp-installer-jenkins::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:github_url]</tt></td>
    <td>String</td>
    <td>URL to GitHub repository</td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:openstack_endpoint]</tt></td>
    <td>String</td>
    <td>URL to OpenStack Keystone endpoint</td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:openstack_identity]</tt></td>
    <td>String</td>
    <td>OpenStack identity in the form <tt>tenant:user</tt></td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:openstack_credential]</tt></td>
    <td>String</td>
    <td>OpenStack password</td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:centos6_image]</tt></td>
    <td>String</td>
    <td>OpenStack CentOS 6 image in the form <tt>region/uuid</tt></td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:centos7_image]</tt></td>
    <td>String</td>
    <td>OpenStack CentOS 7 image in the form <tt>region/uuid</tt></td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:ubuntu1404_image]</tt></td>
    <td>String</td>
    <td>OpenStack Ubuntu 14.04 image in the form <tt>region/uuid</tt></td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:ldap_test_user]</tt></td>
    <td>String</td>
    <td>LDAP user for testing authentication</td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:ldap_test_password]</tt></td>
    <td>String</td>
    <td>Password for LDAP user</td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:cas_url]</tt></td>
    <td>String</td>
    <td>CAS URL from config</td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:cas_login_url]</tt></td>
    <td>String</td>
    <td>CAS login URL from config</td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:recipients]</tt></td>
    <td>String</td>
    <td>Space-delimited list of emails to receive build alerts</td>
  </tr>
</table>

#### idp-installer-jenkins::slave
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:hosts]</tt></td>
    <td>Hash</td>
    <td>Additional entries for <tt>/etc/hosts</tt> if required</td>
  </tr>
</table>

Usage
-----
#### Install dependencies

    gem install chef knife-solo berkshelf
    cd path/to/idp-installer-jenkins
    berks install

The `berks install` step downloads all cookbook dependencies found in `Berksfile`.

#### Prepare the target
Use the following command to install Chef on the target host. It also accepts the `-i` option if you need to specify a private key.

    knife solo prepare <user>@<host>

This will also create `nodes/<host>.json` on your local machine which you will have to edit in the next step.

#### Configure attributes
See the `Attributes` section above for details on what each setting does. They can either be modified directly through the appropriate files in `attributes/` or overriden through the JSON file created in the previous step. Eg.

```json
{
  "default_attributes": {
    "idp_installer_jenkins": {
      "github_url": "https://github.com/cybera"
    }
  }
}
```

#### Run Chef
Include `idp-installer-jenkins::default` in your node's `run_list` to configure a Jenkins master:

```json
{
  "run_list": [
    "recipe[idp-installer-jenkins::default]"
  ]
}
```

Or include `idp-installer-jenkins::slave` to configure a Jenkins slave:

```json
{
  "run_list": [
    "recipe[idp-installer-jenkins::slave]"
  ]
}
```

Now run the cookbook:

    knife solo cook <user>@<host>

The target host should now be configured. If it's a Jenkins master, continue with the post-install configuration below, otherwise you're done and a snapshot of the instance should be created in OpenStack.

### Post-install configuration
Configure security:

1. Click "Manage Jenkins"
2. Click "Configure Global Security"
3. Configure your preferred authentication and authorization methods.

Configure OpenStack keypair:

1. Generate an SSH key pair through the OpenStack dashboard (Access & Security -> Key Pairs)
2. Put the private and public keys in their respective fields in Jenkins (Manage Jenkins -> Configure System, under Cloud)

Add your IdP installer configs to Jenkins:

1. Click "Manage Jenkins"
2. Click "Managed files"
3. Add your CAS and LDAP configs to their corresponding entries under "Custom file"

Add Jenkins webhook to your GitHub repository:

1. Go to your GitHub repository
2. Click "Settings"
3. Click "Webhooks & Services"
4. Click "Add Services"
  1. Select "Jenkins (GitHub plugin)" from the list
5. Enter `http://<your_jenkins_url>/github-webhook/` in the "Jenkins hook url" field

(Optional) Configure SMTP:

1. Click "Manage Jenkins"
2. Click "Configure System"
3. Scroll down to the "E-mail Notification" section
  1. Fill in the details for your SMTP server, click "Advanced..." for authentication details

CONTRIBUTING
------------
This cookbook uses Test Kitchen (http://kitchen.ci/) and Serverspec (http://serverspec.org/) for testing. Test Kitchen offers various commands to deploy virtual machines and run recipes and tests. The default configuration in `.kitchen.yml` uses Vagrant (https://www.vagrantup.com/) for provisioning. This can be overridden by creating `.kitchen.local.yml` and overriding the driver. See the Test Kitchen documentation for more details.

Other than Vagrant, all dependencies for development can be installed by running the following commands:

    gem install chef bundler
    cd path/to/idp-installer-jenkins
    bundle install
    berks install

The `bundle` (http://bundler.io/) and `berks` (http://berkshelf.com/) commands download all dependencies found in `Gemfile` and `Berksfile` respectively. If dependencies change, these files must be modified accordingly. Cookbook dependency changes must also be reflected in `metadata.rb`.

Once all dependencies are installed, you can start using Test Kitchen. Here's a sample of the available commands:

    kitchen           # See all available commands
    kitchen converge  # Run recipes
    kitchen create    # Create instance(s) but don't run anything
    kitchen destroy   # Destroy instance(s)
    kitchen login     # SSH into instance
    kitchen setup     # Create instance(s) and run recipes
    kitchen test      # Create instance(s), run recipes, run tests and destroy
    kitchen verify    # Run tests
    
In Test Kitchen parlance an instance corresponds to a virtual machine. Most commands will default to running all suites on all platforms from `.kitchen.yml` unless passed an argument. To run a specific suite on all platforms use either `default` or `slave`. To run a specific suite on a specific platform use `<suite>-<platform>`, for example `default-ubuntu-1404`.

License and Authors
-------------------
Authors: Cameron Mann <cameron.mann@cybera.ca>
