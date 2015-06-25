# pkgng::repo { 'pkg.freebsd.org': }
  #	Package {
  #  		provider => pkgng
 #i

node default{
 	include fixpkg
        include apache
        include clamav
        include dovecot
        include amavisd
        include mysqlcon
        include pear
        include php
        include postfix
        include postfixadmin
	include adduser
	include saupdate
	include spamassassin
	include adminer
	include roundcube
}


class { '::mysql::server': 
	 override_options => { 'mysqld' => { 'max_connections' => '1024' } },
 }
