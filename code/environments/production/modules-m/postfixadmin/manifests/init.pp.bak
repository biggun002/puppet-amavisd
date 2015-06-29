class postfixadmin{
	package{'m-postfixadmin':
		ensure => 'present',
	}
	file{'/usr/local/www/postfixadmin':
		ensure => 'present',
		mode => '0777',
		recurse => true,
		require => Package['m-postfixadmin'],
	}
	file{'/usr/local/www/postfixadmin/config.inc.php':
		source => 'puppet:///modules/postfixadmin/config.inc.php',
		ensure => 'file',
		require => Package['m-postfixadmin'],
	}	
	file{'/usr/local/etc/apache24/Includes/postfixadmin.conf':
		source => 'puppet:///modules/postfixadmin/postfixadmin.conf',
		ensure => 'file',
		require => Package['m-postfixadmin'],	
	}
}
