# puppet-amavisd
## Install puppet

copy necessary files to the directory where installpuppet.sh will be running

- rc.d/puppet
- rc.d/puppetmaster
- puppet/puppet.conf
- etc/pkgng.rb

use [`installpuppet.sh`](https://github.com/biggun002/puppet-amavisd/blob/master/etc/installpuppet.sh) script to install required packages and gems, create directory structure and patch the copied necessary files to their proper locations.


Notes: 
**pkgng** was also edited here to optimize runtime
```
/usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb
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



puppet module list
```

ดูเฉพาะ path ละเอียดกว่า list
```
tree -L 2 -d /etc/puppetlabs/puppet/environments/production/modules/ | less
```








