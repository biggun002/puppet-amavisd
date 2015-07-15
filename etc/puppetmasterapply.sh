cd /etc/puppetlabs/code/environments/production/modules
puppet apply --debug apache/tests/init.pp
puppet apply --debug mysqlcon/tests/init.pp
puppet apply --debug pear/tests/init.pp
puppet apply --debug php/tests/init.pp
puppet apply --debug dovecot/tests/init.pp
puppet apply --debug spamassassin/tests/init.pp
puppet apply --debug saupdate/tests/init.pp
puppet apply --debug postfixadmin/tests/init.pp
puppet apply --debug adminer/tests/init.pp
puppet apply --debug roundcube/tests/init.pp
puppet apply --debug salearn/tests/init.pp
echo '---------------------------'
echo '-- ALL PACKAGE INSTALLED --'
