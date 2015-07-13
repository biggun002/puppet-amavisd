# pkgng::repo { 'pkg.freebsd.org': }
  #	Package {
  #  		provider => pkgng
 #i

node default{
        #include mysqlcon
        #include php
        #include apache
        include clamav
        include amavisd
        #include pear
        include postfix
	#include adduser
	include saupdate
	include spamassassin
	#include roundcube
}
