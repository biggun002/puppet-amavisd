# pkgng::repo { 'pkg.freebsd.org': }
  #	Package {
  #  		provider => pkgng
 #i

node default{
 	include fixpkg
        include mysqlcon
        include php
        include apache
        include clamav
        include dovecot
        include amavisd
        include pear
        include postfix
        include postfixadmin
	include adduser
	include saupdate
	include spamassassin
	include adminer
	include roundcube
}
