Jenkins for IdP Installer Cookbook
==================================
This cookbook installs and configures Jenkins for use with the IdP installer. The `default` recipe will install and configure the Jenkins master while the `slave` recipe will configure a slave for testing.

Requirements
------------
### idp-installer-jenkins::default
#### platforms
- `Ubuntu 14.04`
- `CentOS 7.x`

### idp-installer-jenkins::slave
#### platforms
- `Ubuntu 14.04`
- `CentOS 6.x/7.x`

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
    <td><tt>[:idp_installer_jenkins][:centos6_image]</tt></td>
    <td>String</td>
    <td>UUID of configured CentOS 6 image in OpenStack</td>
  </tr>
  <tr>
    <td><tt>[:idp_installer_jenkins][:centos7_image]</tt></td>
    <td>String</td>
    <td>UUID of configured CentOS 7 image in OpenStack</td>
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

Usage
-----
#### Install dependencies
    gem install chef knife-solo bundler
    cd idp-installer-jenkins
    bundle install
    berks install

#### idp-installer-jenkins::default
First, configure the attributes specified above in `attributes/default.rb`.

Include `idp-installer-jenkins` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[idp-installer-jenkins]"
  ]
}
```

### Post-install configuration
Configure jclouds:

1. Click "Manage Jenkins"
2. Click "Configure System"
3. Scroll down to the "Clouds" section and fill in the following fields:
  1. Identity (OpenStack user in the form `<tenant>:<user>`)
  2. Credential (OpenStack password)

Add your IdP installer configs to Jenkins:

1. Click "Manage Jenkins"
2. Click "Managed files"
3. Add your CAS and LDAP configs to their corresponding entries under "Custom file"

Add Jenkins webhook to your GitHub repository:

1. Go to your GitHub repository
2. Click "Settings"
3. Click "Webhooks & Services"
4. Click "Add Services"
  1. Select "Jenkins (Git plugin)" from the list
5. Enter `http://<your_jenkins_url>/github-webhook/` in the "Jenkins hook url" field

License and Authors
-------------------
Authors: Cameron Mann <cameron.mann@cybera.ca>
