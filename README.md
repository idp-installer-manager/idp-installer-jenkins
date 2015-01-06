Jenkins for IdP Installer Cookbook
==================================
This cookbook installs and configures Jenkins for use with the IdP installer. It also installs and configures Apache2 as a reverse proxy to access Jenkins.

Requirements
------------
### Platforms
- `Ubuntu 12.04+`
- `CentOS 6+`

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
    <td><tt>[:idp-installer-jenkins][:ldap_test_user]</tt></td>
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
#### Install chef and knife-solo
    gem install chef
    gem install knife-solo

#### idp-installer-jenkins::default
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
