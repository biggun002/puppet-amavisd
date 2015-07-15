#!/bin/sh

# Require files from local host
# ** Do it with scp or whatever you want to copy it to remote host
# cp /etc/rc.d/puppet ~ 
# cp /etc/rc.d/puppetmaster ~
# cp /etc/puppetlabs/puppet/puppet.conf ~
# cp /usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb ~

mkdir -p /usr/local/etc/pkg/repos
echo "FreeBSD: { enabled: no }" > /usr/local/etc/pkg/repos/FreeBSD.conf
echo "Self: { url: 'pkg+http://localhost/pkg', mirror_type: 'srv', enabled: yes }" > /usr/local/etc/pkg/repos/FreeBSD.conf
cd ~
pkg update
pkg install -y ruby
pkg install -y ruby21-gems
gem install puppet
pkg install -y ca_root_nss
pkg install -y vim-lite
#mkdir -p /etc/puppetlabs/code/environments/production/modules
#mkdir -p /etc/puppetlabs/code/manifests
#mkdir -p /etc/puppetlabs/puppet

pkg install -y git
mkdir /etc/puppetlabs
cd /etc/puppetlabs
git clone https://github.com/biggun002/puppet-amavisd.git .

cd ~
cp pkgng.rb /usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb

#cp puppet /etc/rc.d/
cp puppetmaster /etc/rc.d/
#cp puppet.conf /etc/puppetlabs/puppet

#echo 'puppet_enable="YES"' >> /etc/rc.conf
echo 'puppetmaster_enable="YES"' >> /etc/rc.conf

echo 'puppet::::::::::' | adduser -w no -f

### for peference
echo "alias pup       cd /etc/puppetlabs" >> ~/.cshrc
echo "alias mod       cd /etc/puppetlabs/code/environments/production/modules" >> ~/.cshrc
source ~/.cshrc

echo "set nu" > ~/.vimrc
echo "set tabstop=4" >> ~/.vimrc
echo "set colorscheme elflord" >> ~/.vimrc
