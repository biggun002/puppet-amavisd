# puppet-maia
# Install puppet
``` puppet
gem install puppet
pkg install ca_root_nss
mkdir -p /etc/puppetlabs/code/environments/production
mkdir -p /etc/puppetlabs/code/manifests

puppet module install zleslie-pkgng
puppet module install puppetlabs-mysql

```
### copy puppet configuration
#### /etc/puppetlabs/puppet/puppet.conf


### Make it run at startup
#### /etc/rc.d/puppet
#### /etc/rc.d/puppetmaster
**don't forget to change permission to them**


**pkgng** edit here to solve the problem
```
/usr/local/lib/ruby/gems/2.1/gems/puppet-4.1.0/lib/puppet/provider/package/pkgng.rb
```

Rename all directory
``` perl
perl -e 'rename $_, "PRE_$_" for <*>'
```


---

# Module
---
ดู path ที่เก็บ module ทั้งหมด
```
puppet agent --configprint modulepath
```
Default path

* module เฉพาะในเครื่อง


`/etc/puppetlabs/puppet/environments/production/modules`

* module ทุกเครื่องใน environments

`/etc/puppetlabs/puppet/modules`

* แปลไม่ออก 55 ไม่น่าจะได้ใช้  ,, เขาบอกไม่ควรใช้ 55

`/opt/puppet/share/puppet/modules`

ดู module ทั้งหมดในเครื่อง

```
puppet module list
```

ดูเฉพาะ path ละเอียดกว่า list
```
tree -L 2 -d /etc/puppetlabs/puppet/environments/production/modules/ | less
```

#NTP

ไฟล์ที่จะถูกดูเป็นไฟล์แรกตอนใช้ puppet agent --test
```
/etc/puppetlabs/puppet/environments/production/manifests/site.pp
```

#MySql

#Variable
```
class classname ( $parameter = 'default' ) {
  ...
}
```
```
class {'classname': 
  parameter => 'value',
}
```
#Condition
list fact
```
facter -p 
```
เอา fact ไปใช้
```
$::factname
```
 * if statements
 * unless statements
 * case statements
 * selectors.






