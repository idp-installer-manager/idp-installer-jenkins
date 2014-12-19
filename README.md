Jenkins for IdP Installer Cookbook
==================================
This cookbook installs and configures Jenkins for use with the IdP installer. It also installs and configures Apache2 as a reverse proxy to access Jenkins.

Requirements
------------
### platforms
- `Ubuntu 12.04+`
- `CentOS 6+`

### environment
- `Chef 11+`
- `Ruby 1.9.3+`

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### idp-installer-jenkins::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['idp-installer-jenkins']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### idp-installer-jenkins::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `idp-installer-jenkins` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[idp-installer-jenkins]"
  ]
}
```

License and Authors
-------------------
Authors: Cameron Mann <cameron.mann@cybera.ca>
