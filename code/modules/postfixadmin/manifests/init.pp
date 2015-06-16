class postfixadmin{
	package{'postfixadmin':
		ensure => 'present',
	}
	file{'/usr/local/www/postfixadmin':
		ensure => 'present',
		mode => '0750',
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
	file{'/usr/local/www/postfixadmin':
		ensure => 'directory',
		owner => 'www',
		recurse => true,
	}
	service{'apache24':
		ensure => 'running',
	}
	service{'dovecot':
		ensure => 'running',
	}
	service{'dovecot':
		ensure => 'running',
	}
}
