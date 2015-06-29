#!/bin/sh

tar Jxvf packagesite.txz
sed -i ".bak" "s/pear/m-pear/g" packagesite.yaml 
sed -i ".bak" "s/amavisd/m-amavisd/g" packagesite.yaml 
sed -i ".bak" "s/apache/m-apache/g" packagesite.yaml 
sed -i ".bak" "s/clamav/m-clamav/g" packagesite.yaml 
sed -i ".bak" "s/dovecot/m-dovecot/g" packagesite.yaml 
sed -i ".bak" "s/postfix/m-postfix/g" packagesite.yaml 
sed -i ".bak" "s/postfixadmin/m-postfixadmin/g" packagesite.yaml 
sed -i ".bak" "s/spamassassin/m-spamassassin/g" packagesite.yaml 
sed -i ".bak" "s/m-m-/m-/g" packagesite.yaml 
tar Jcvf packagesite.txz packagesite.yaml
