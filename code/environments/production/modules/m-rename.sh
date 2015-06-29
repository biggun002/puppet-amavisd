#!/bin/sh

sed -i ".bak" "s/localhost/puppetmaster:3680/g" amavisd/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" apache/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" clamav/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" dovecot/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" pear/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" postfix/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" postfixadmin/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" spamassassin/manifests/init.pp
sed -i ".bak" "/freebsd/d" pear/manifests/init.pp
sed -i ".bak" "/freebsd/d" postfix/manifests/init.pp
sed -i ".bak" "/freebsd/d" postfixadmin/manifests/init.pp
sed -i ".bak" "/freebsd/d" spamassassin/manifests/init.pp
sed -i ".bak" "/freebsd/d" amavisd/manifests/init.pp
sed -i ".bak" "/freebsd/d" apache/manifests/init.pp
sed -i ".bak" "/freebsd/d" clamav/manifests/init.pp
sed -i ".bak" "/freebsd/d" dovecot/manifests/init.pp
sed -i ".bak" "/freebsd/d" mysqlcon/manifests/init.pp
sed -i ".bak" "/freebsd/d" php/manifests/init.pp
sed -i ".bak" "/puppetmaster:3680/d" amavisd/manifests/init.pp
sed -i ".bak" "/puppetmaster:3680/d" apache/manifests/init.pp
sed -i ".bak" "/puppetmaster:3680/d" clamav/manifests/init.pp
sed -i ".bak" "/puppetmaster:3680/d" dovecot/manifests/init.pp
sed -i ".bak" "/puppetmaster:3680/d" pear/manifests/init.pp
sed -i ".bak" "/puppetmaster:3680/d" postfix/manifests/init.pp
sed -i ".bak" "/puppetmaster:3680/d" postfixadmin/manifests/init.pp
sed -i ".bak" "/puppetmaster:3680/d" spamassassin/manifests/init.pp


