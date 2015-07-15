# puppet-amavisd
---
# Installation
First, copy necessary files to the directory where installpuppet.sh will be running

- rc.d/puppet
- rc.d/puppetmaster
- puppet/puppet.conf
- etc/pkgng.rb

use [`etc/installpuppet.sh`](https://github.com/biggun002/puppet-amavisd/blob/master/etc/installpuppet.sh) script to install required packages and gems, create directory structure and patch the copied necessary files to their proper locations.


Notes: 
**pkgng** was also edited here to optimize runtime
```
/usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb
```

---

# Module
In order to use package compiled from port, Puppet only lookup package in **pkg**. So, we have to host own package repository. First, list the package you want to create in `packagelist` file and run this script in `/usr/local/www/pkg` 
[`etc/finddependeccies.sh`](https://github.com/biggun002/puppet-amavisd/blob/master/etc/finddependencies.sh).

#### To use localhost's package repository:

* Disable default repository

```bash
mkdir -p /usr/local/etc/pkg/repos
echo "FreeBSD: { enabled: no }" > /usr/local/etc/pkg/repos/FreeBSD.conf
```
* Add these lines to `/etc/pkg/FreeBSD.conf`

```bash
echo "Self: { url: 'pkg+http://localhost/pkg', mirror_type: 'srv', enabled: yes }" > /usr/local/etc/pkg/repos/FreeBSD.conf
```
When you want to restore everything back to normal state, simply remove `/usr/local/etc/pkg/repos/FreeBSD.conf` file.

---

#Puppet client
In puppet client run 
`puppet agent -t`

---
#Puppetmaster
In newer version, puppetserver was renamed to **puppetmaster**.

We used puppetmaster machine as MySQL server for storing mails and configurations in database, LDA (Dovecot) and Spamassassin for learning bayes per user.

required puppet modules for puppetmaster machine:
- 
```bash
cd /etc/puppetlabs/code/environments/production/modules
puppet apply 
```
