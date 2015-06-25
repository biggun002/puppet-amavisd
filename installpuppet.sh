#!/bin/sh

# Require files from local host
# ** Do it with scp or whatever you want to copy it to remote host
# cp /etc/rc.d/puppet ~ 
# cp /etc/rc.d/puppetserver ~
# cp /etc/puppetlabs/puppet/puppet.conf ~
# cp /etc/hosts ~

pkg install -qy ruby
pkg install -qy ruby21-gems
gem install puppet
pkg install -qy ca_root_nss
mkdir -p /etc/puppetlabs/code/environments/production/modules
mkdir -p /etc/puppetlabs/code/manifests
mkdir -p /etc/puppetlabs/puppet

cp pkgng.rb /usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb

cp puppet /etc/rc.d/
cp puppetserver /etc/rc.d/
cp puppet.conf /etc/puppetlabs/puppet
cp hosts /etc/hosts

echo 'puppet_enable="YES"' >> /etc/rc.conf
echo 'puppetserver_enable="YES"' >> /etc/rc.conf

echo 'puppet::::::::::' | adduser -w no -f
