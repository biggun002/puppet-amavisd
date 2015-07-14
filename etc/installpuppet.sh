#!/bin/sh

# Require files from local host
# ** Do it with scp or whatever you want to copy it to remote host
# cp /etc/rc.d/puppet ~ 
# cp /etc/rc.d/puppetmaster ~
# cp /etc/puppetlabs/puppet/puppet.conf ~
# cp /usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb ~

pkg update
pkg install -y ruby
pkg install -y ruby21-gems
gem install puppet
pkg install -y ca_root_nss
mkdir -p /etc/puppetlabs/code/environments/production/modules
mkdir -p /etc/puppetlabs/code/manifests
mkdir -p /etc/puppetlabs/puppet

cp pkgng.rb /usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb

cp puppet /etc/rc.d/
cp puppetmaster /etc/rc.d/
cp puppet.conf /etc/puppetlabs/puppet

echo 'puppet_enable="YES"' >> /etc/rc.conf
echo 'puppet_master_enable="YES"' >> /etc/rc.conf

echo 'puppet::::::::::' | adduser -w no -f
