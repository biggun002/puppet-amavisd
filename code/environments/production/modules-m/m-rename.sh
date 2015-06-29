#!/bin/sh

#edit repository name
#add prefix m-

sed -i ".bak" "s/ge{'amavisd-new'/ge{'m-amavisd-new'/g" amavisd/manifests/init.pp
sed -i ".bak" "s/\['amavisd-new'\]/\['m-amavisd-new'\]/g" amavisd/manifests/init.pp
sed -i ".bak" "s/ge{'apache'/ge{'m-apache'/g" apache/manifests/init.pp
sed -i ".bak" "s/\['apache'\]/\['m-apache'\]/g" apache/manifests/init.pp
sed -i ".bak" "s/ge{'clamav'/ge{'m-clamav'/g" clamav/manifests/init.pp
sed -i ".bak" "s/\['clamav'\]/\['m-clamav'\]/g" clamav/manifests/init.pp
sed -i ".bak" "s/ge{'dovecot2'/ge{'m-dovecot2'/g" dovecot/manifests/init.pp
sed -i ".bak" "s/\['dovecot2'\]/\['m-dovecot2'\]/g" dovecot/manifests/init.pp
sed -i ".bak" "s/ge{'pear'/ge{'m-pear'/g" pear/manifests/init.pp
sed -i ".bak" "s/\['pear'\]/\['m-pear'\]/g" pear/manifests/init.pp
sed -i ".bak" "s/ge{'pear-Auth'/ge{'m-pear-Auth'/g" pear/manifests/init.pp
sed -i ".bak" "s/ge{'pear-Log'/ge{'m-pear-Log'/g" pear/manifests/init.pp
sed -i ".bak" "s/ge{'pear-Net_SMTP'/ge{'m-pear-Net_SMTP'/g" pear/manifests/init.pp
sed -i ".bak" "s/ge{'postfix'/ge{'m-postfix'/g" postfix/manifests/init.pp
sed -i ".bak" "s/\['postfix'\]/\['m-postfix'\]/g" postfix/manifests/init.pp
sed -i ".bak" "s/ge{'postfixadmin'/ge{'m-postfixadmin'/g" postfixadmin/manifests/init.pp
sed -i ".bak" "s/\['postfixadmin'\]/\['m-postfixadmin'\]/g" postfixadmin/manifests/init.pp
sed -i ".bak" "s/ge{'spamassassin'/ge{'m-spamassassin'/g" spamassassin/manifests/init.pp
sed -i ".bak" "s/\['spamassassin'\]/\['m-spamassassin'\]/g" spamassassin/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" amavisd/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" apache/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" clamav/manifests/init.pp
sed -i ".bak" "s/localhost/puppetmaster:3680/g" dovecot/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" pear/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" postfix/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" postfixadmin/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" spamassassin/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" amavisd/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" apache/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" clamav/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" dovecot/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" pear/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" postfix/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" postfixadmin/manifests/init.pp
sed -i ".bak" "/puppetmaster/d" spamassassin/manifests/init.pp
sed -i ".bak" "/freebsd/d" pear/manifests/init.pp
sed -i ".bak" "/freebsd/d" postfix/manifests/init.pp
sed -i ".bak" "/freebsd/d" postfixadmin/manifests/init.pp
sed -i ".bak" "/freebsd/d" spamassassin/manifests/init.pp
sed -i ".bak" "/freebsd/d" amavisd/manifests/init.pp
sed -i ".bak" "/freebsd/d" apache/manifests/init.pp
sed -i ".bak" "/freebsd/d" clamav/manifests/init.pp
sed -i ".bak" "/freebsd/d" dovecot/manifests/init.pp
