class adduser{
	user{'testuser' :
		ensure => 'present',
	}
}

class adminer{
	package{'adminer':
		ensure => 'present',
	}
}
class amavisd{
	package{'amavisd-new':
		ensure => 'present',
	}
	package{'maia':
		ensure => 'absent',
	}
	package{'p5-DBD-mysql':
		ensure => 'present',
	}
	file{'/usr/local/etc/amavisd.conf':
		ensure => 'file',
		source => 'puppet:///modules/amavisd/amavisd.conf',
		require => Package['amavisd-new'],
	}
	file{'/var/log/local0':
		ensure => 'present',
	}
}
class apache{
	package{'apache24':
		ensure => 'present',
	}
	file{'/usr/local/etc/apache24/httpd.conf':
		source => 'puppet:///modules/apache/httpd.conf',
		ensure => 'file',
		require => Package['apache24'],
	}
	file{'/usr/local/etc/apache24/extra/httpd-ssl.conf':
		source => 'puppet:///modules/apache/httpd-ssl.conf',
		ensure => 'file',
		require => Package['apache24'],
	}
	file{'/usr/local/etc/apache24/extra/httpd-default.conf':
		source => 'puppet:///modules/apache/httpd-default.conf',
		ensure => 'file',
		require => Package['apache24'],
	}
	service{'apache24':
		ensure => 'running',
		subscribe => File['/usr/local/etc/apache24/httpd.conf'],
	}	
	file{'/usr/local/etc/ssl/apache' :
		ensure => 'directory',
		require => Package['apache24'],
	}
	exec{'opensslgenrsa' :
		path => '/usr/bin',
		command => 'openssl genrsa -des3 -out server.key -passout pass:pass 1024',
		cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
	}

	exec{'opensslreq' :
                path => '/usr/bin',
		command => 'openssl req -new -key server.key -out server.csr -passin pass:pass -subj "/CN=www.example.com/O=Example/C=TH/ST=Bangkok/L=Bangkok"', 
                cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
        }
	exec{'opensslx509' :
                path => '/usr/bin',
		command => 'openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt -passin pass:pass',
                cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
        }
	exec{'backupserverkey':
		path => '/bin',
		cwd => '/usr/local/etc/ssl/apache',
		command => 'cp server.key server.key.orig',
		require => [Exec['opensslgenrsa'],Exec['opensslreq'],Exec['opensslx509']],
	}
	exec{'removesslpass':
		path => '/usr/bin/',
		cwd => '/usr/local/etc/ssl/apache',
		command => 'openssl rsa -in server.key.orig -out server.key -passin pass:pass',
		require => Exec['backupserverkey'],
	}
}	
class clamav{
	package{'clamav':
		ensure	=> 'present',
	}
	user{'vscan':
		ensure => 'present',
	}
	file{'/usr/local/etc/freshclam.conf':
		source => 'puppet:///modules/clamav/freshclam.conf',
		ensure => 'file',
		require => Package['clamav'],
	}
	file{'/usr/local/etc/clamd.conf':
		source => 'puppet:///modules/clamav/clamd.conf',
		ensure => 'file',
		require => Package['clamav'],
	}
	file{'/var/log/clamav':
		ensure => 'directory',
		mode => '0777',
		recurse => 'true',
		require => [Package['clamav'],User['vscan']],
		owner => 'clamav',
	}
	file{'/var/run/clamav':
		ensure => 'directory',
		require => [Package['clamav'],User['vscan']],
		owner => 'clamav',
		ignore => 'clamd.sock',
	}
	file{'/var/db/clamav':
		ensure => 'directory',
		mode => '0777',
		recurse => 'true',
		require => [Package['clamav'],User['vscan']],
		owner => 'clamav',
	}
	service{'clamav-freshclam':
		ensure => 'running',
		subscribe => File['/usr/local/etc/freshclam.conf'],
	}
	exec{'freshclam':
		path => '/usr/local/bin',
		require => Service['clamav-freshclam'],
	}
	service{'clamav-clamd':
		ensure 	=> 'running',
		subscribe => [File['/usr/local/etc/clamd.conf'],Service['clamav-freshclam'],Exec['freshclam']],
	}
}
class dovecot{
	package{'dovecot-pigeonhole' :
		ensure => 'present',
	}

	package{'dovecot2' :
		ensure => 'present',
	}

	file{'/usr/local/etc/dovecot' :
		source => 'puppet:///modules/dovecot/dovecot',
		recurse => 'true',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}
	
	file{'/usr/local/virtual/home' :
		ensure => 'directory',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}

	file{'/usr/local/virtual/home/default.sieve' :
		ensure => 'file',
		source => 'puppet:///modules/dovecot/default.sieve',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}

	exec{'sievec /usr/local/virtual/home/default.sieve' :
		path => '/usr/local/bin',
		subscribe => File['/usr/local/virtual/home/default.sieve'],
	}

	file{'/usr/local/virtual' :
		ensure => 'directory',
		owner => 'vscan',
		group => 'vscan',
		mode => '0777',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
		recurse => 'true',
	}

	exec{'pw usermod dovecot -G vscan' :
		path => '/usr/sbin',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}
	
	file{'/usr/local/etc/ssl/dovecot' :
		ensure => 'directory',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}

	exec{'openssl req -passin pass:pass -new -x509 -nodes -out cert.pem -keyout key.pem -days 3650 -subj "/CN=www.example.com/O=Example/C=TH/ST=Bangkok/L=Bangkok"' :
		path => '/usr/bin',
		cwd => '/usr/local/etc/ssl/dovecot',
		require => File['/usr/local/etc/ssl/dovecot'],
	}

	file{'/usr/local/libexec/dovecot/dovecot-lda':
		ensure => 'present',
		group => 'vscan',
		mode => '04750',
	}
	file{'/usr/local/libexec/dovecot/deliver':
		ensure => 'present',
		group => 'vscan',
		mode => '04750',
	}
}	
class fixpkg{
   file { '/usr/local/etc/pkg/':
	ensure => directory,
   }
   file { '/usr/local/etc/pkg/repos':
	ensure => directory,
	require => File['/usr/local/etc/pkg/'],
   }
   file { '/etc/pkg/':
	ensure => directory,
   }
   file {'/usr/local/etc/pkg/repos/FreeBSD.conf':
    	source => 'puppet:///modules/fixpkg/FreeBSD.conf', 	
	ensure => present,
	require => File['/usr/local/etc/pkg/repos/'],
   }
   file {'/etc/pkg/FreeBSD.conf':
    	source => 'puppet:///modules/fixpkg/FreeBSD.conf', 	
	ensure => present,
	require => File['/etc/pkg/'],
   }
   file{'/etc/rc.conf':
     	source => 'puppet:///modules/fixpkg/rc.conf',
	ensure => file,
   }
   exec{'pkgupdate':
	command => 'pkg update',
	path => '/usr/sbin',
	subscribe => [File['/usr/local/etc/pkg/repos/FreeBSD.conf'],File['/etc/pkg/FreeBSD.conf']],
   }
}
class mysqlcon{
	file{'/var/db/mysql/my.cnf' :
		source => 'puppet:///modules/mysqlcon/my.cnf',
		ensure => file,
		group => 'mysql',
		owner =>  'mysql',
	#	require => [User['mysql'],Package['mysql56-server']],
	}
         file{'importdump':
                  ensure => 'file',
                  path => '/var/db/mysql/localhost_nodata.sql',
                  source => 'puppet:///modules/mysqlcon/localhost_nodata.sql',
          }
 
          file{'importdump2':
                  ensure => 'file',
                  path => '/var/db/mysql/localhost_mysql.sql',
                  source => 'puppet:///modules/mysqlcon/localhost_mysql.sql',
          }
 
          exec{'dumpDB':
		  path	   => '/usr/local/bin',
                  command  =>  'mysql -u root < /var/db/mysql/localhost_nodata.sql',
                  require  => [File['importdump'],Exec['dumpDB2']],
		  creates  => '/var/db/mysql/maia',
          }
 
           exec{'dumpDB2':
		  path	   => '/usr/local/bin',
                  command  =>  'mysql -u root < /var/db/mysql/localhost_mysql.sql',
                  require  => File['importdump2'],
		  creates  => '/var/db/mysql/test2',
          }

	user {'mysql' :
		ensure => present,
	}

	package{'mysql56-server' :
		ensure => 'present',
	}
	
#	service{'mysql-server':
#		ensure => 'running',
#		subscribe => File['/var/db/mysql/my.cnf'],
#	}
	
	#mysql::db{'maia':
	#	user => 'vscan',
	#	password => '',
	#	host => 'localhost',
	#	ensure => 'present',
	#	sql => 'puppet:///modules/mysqlcon/maia-mysql.sql',
	#	grant => 'ALL',
	#}
	
}	
class pear{
	package{ 'pear':
		ensure	=> 'present',
	}
	package{ 'pear-Auth':
		ensure => 'present',
	}
	package{ 'pear-Log':
		ensure => 'present',
	}
	package{ 'pear-Net_SMTP':
		ensure => 'present',
	}
}
class php{
	package{'php56':
		ensure => 'present',
	}
	package{'php56-mysql':
		ensure => 'present',
	}
	package{'php56-imap':
		ensure => 'present',
		require => [Package['php56'],Package['cclient']],
	}
	package{'cclient':
		ensure => 'present',
	}
	package{'mod_php56':
		ensure => 'present',
	}
	file{'/usr/local/etc/php.ini':
		source => 'puppet:///modules/php/php.ini',
		ensure => 'file',
		require => [Package['mod_php56'],Package['php56'],Package['php56-mysql']],
	}
}
class postfix{
	service{'sendmail' : 
		ensure => 'stopped',
	}
	
	package{'postfix' :
		ensure => 'present',
	}
	
	file{'/etc/periodic.conf' :
		ensure => 'file',
		source => 'puppet:///modules/postfix/periodic.conf',
		require => Package['postfix'],
	} 
	
	file{'/usr/local/etc/postfix' :
		source => 'puppet:///modules/postfix/postfix',
		recurse => 'true',
		require => Package['postfix'],
	}
	
	file{'/usr/local/etc/ssl/postfix' :
		ensure => 'directory',
		require => Package['postfix'],
	}

	service{'postfix' :
		ensure => 'running',
		subscribe => File['/usr/local/etc/postfix/'],
	}
	
	exec{'execopenssl' :
		path => '/usr/bin',
		command => 'openssl req -passin pass:pass -new -x509 -nodes -out smtpd.pem -keyout smtpd.pem -days 3650 -subj "/CN=www.example.com/O=Example/C=TH/ST=Bangkok/L=Bangkok"',
		cwd => '/usr/local/etc/ssl/postfix',
		require => Package['postfix'],
	}

	file{'/usr/local/etc/postfix/transport' :
		ensure => 'file',
		require => Package['postfix'],
	}

	exec{'postmap /usr/local/etc/postfix/transport':
		path => '/usr/local/sbin',
		require => Package['postfix'],
	}

	file{'/etc/aliases' :
		ensure => 'file',
		source => 'puppet:///modules/postfix/aliases',
		require => Package['postfix'],
	}
	
	exec{'newaliases' :
		path => '/usr/bin',
		subscribe => File['/etc/aliases'],
	}
	
	exec{'copyaliases':
		path => '/bin',
		cwd => '/etc/mail',
		command => 'cp aliases.db ..',
		require => Exec['newaliases'],
	}
}	
class postfixadmin{
	package{'postfixadmin':
		ensure => 'present',
	}
	file{'/usr/local/www/postfixadmin':
		ensure => 'present',
		mode => '0777',
		recurse => true,
		require => Package['postfixadmin'],
	}
	file{'/usr/local/www/postfixadmin/config.inc.php':
		source => 'puppet:///modules/postfixadmin/config.inc.php',
		ensure => 'file',
		require => Package['postfixadmin'],
	}	
	file{'/usr/local/etc/apache24/Includes/postfixadmin.conf':
		source => 'puppet:///modules/postfixadmin/postfixadmin.conf',
		ensure => 'file',
		require => Package['postfixadmin'],	
	}
}
class postfix{
	service{'sendmail' : 
		ensure => 'stopped',
	}
	
	package{'postfix' :
		ensure => 'present',
                provider => 'freebsd',
                source => 'http://localhost/pkg',
	}
	
	file{'/etc/periodic.conf' :
		ensure => 'file',
		source => 'puppet:///modules/postfix/periodic.conf',
		require => Package['postfix'],
	} 
	
	file{'/usr/local/etc/postfix' :
		source => 'puppet:///modules/postfix/postfix',
		recurse => 'true',
		require => Package['postfix'],
	}
	
	file{'/usr/local/etc/ssl/postfix' :
		ensure => 'directory',
		require => Package['postfix'],
	}

	service{'postfix' :
		ensure => 'running',
		subscribe => File['/usr/local/etc/postfix/'],
	}
	
	exec{'execopenssl' :
		path => '/usr/bin',
		command => 'openssl req -passin pass:pass -new -x509 -nodes -out smtpd.pem -keyout smtpd.pem -days 3650 -subj "/CN=www.example.com/O=Example/C=TH/ST=Bangkok/L=Bangkok"',
		cwd => '/usr/local/etc/ssl/postfix',
		require => Package['postfix'],
	}

	file{'/usr/local/etc/postfix/transport' :
		ensure => 'file',
		require => Package['postfix'],
	}

	exec{'postmap /usr/local/etc/postfix/transport':
		path => '/usr/local/sbin',
		require => Package['postfix'],
	}

	file{'/etc/aliases' :
		ensure => 'file',
		source => 'puppet:///modules/postfix/aliases',
		require => Package['postfix'],
	}
	
	exec{'newaliases' :
		path => '/usr/bin',
		subscribe => File['/etc/aliases'],
	}
}	
class roundcube{
	package{'roundcube':
		ensure => 'present',
	}
	package{'php56-fileinfo':
		ensure => 'present',
	}
	file{'/usr/local/www/roundcube/config/config.inc.php':
		ensure => 'file',
		mode => '0755',
		source => 'puppet:///modules/roundcube/config.inc.php',
		require => Package['roundcube'],
	}
	file{'/usr/local/www/roundcube/plugins/managesieve/config.inc.php':
		ensure => 'file',
		mode => '0755',
		source => 'puppet:///modules/roundcube/plugins-managesieve-config.inc.php',
		require => Package['roundcube'],
	}
	file{'/usr/local/www/roundcube/plugins/password/config.inc.php':
		ensure => 'file',
		mode => '0755',
		source => 'puppet:///modules/roundcube/plugins-password-config.inc.php',
		require => Package['roundcube'],
	}
	exec{'importsql':
		path => '/usr/local/bin',
		cwd => '/usr/local/www/roundcube/SQL',	
		command => 'mysql -uroundcube roundcube < mysql.initial.sql',
		require => Package['roundcube'],
	}
}
class saupdate{
	package{'wget':
		ensure => present,
	}
	file{'/var/db/spamassassin':
		ensure => directory,
	}
	file{'/var/db/spamassassin/3.004001':
		ensure => directory,
		require => File['/var/db/spamassassin'],
	}
	exec{'wgetupdate':
		path => '/usr/local/bin',
		cwd => '/var/db/spamassassin/3.004001',
		command => 'wget apache.claz.org//spamassassin/source/Mail-SpamAssassin-rules-3.4.1.r1675274.tgz',
		require => [File['/var/db/spamassassin/3.004001'],Package['wget']],
	}
	exec{'tarupdate':
		path => '/usr/bin',
		cwd => '/var/db/spamassassin/3.004001',
		command => 'tar -xvf Mail-SpamAssassin-rules-3.4.1.r1675274.tgz',
		require => Exec['wgetupdate'],
	}
}
class spamassassin{
	package{'spamassassin':
		ensure => 'present',	
	}
	file{'/usr/local/etc/mail/spamassassin/local.cf':
		source => 'puppet:///modules/spamassassin/local.cf',
		ensure => 'file',
		require => Package['spamassassin'],	
	}
}
#   This module manages staging and extraction of files from various sources.
#
# #### Actions:
#
#   Creates the root staging directory. By default files will be created in a subdirectory matching the caller_module_name.
#
#      /opt/staging/
#                 |-- puppet
#                 |   `-- puppet.enterprise.2.0.tar.gz
#                 `-- tomcat
#                     `-- tomcat.5.0.tar.gz
#
class staging (
  $path      = $staging::params::path,     #: staging directory filepath
  $owner     = $staging::params::owner,    #: staging directory owner
  $group     = $staging::params::group,    #: staging directory group
  $mode      = $staging::params::mode,     #: staging directory permission
  $exec_path = $staging::params::exec_path #: executable default path
) inherits staging::params {

  # Resolve conflict with pe_staging
  if !defined(File[$path]) {
    file { $path:
      ensure => directory,
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }
  }

}
# Class: stdlib
#
# This module manages stdlib. Most of stdlib's features are automatically
# loaded by Puppet, but this class should be declared in order to use the
# standardized run stages.
#
# Parameters: none
#
# Actions:
#
#   Declares all other classes in the stdlib module. Currently, this consists
#   of stdlib::stages.
#
# Requires: nothing
#
class stdlib {

  class { 'stdlib::stages': }

}
