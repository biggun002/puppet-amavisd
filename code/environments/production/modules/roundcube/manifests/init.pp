class roundcube{
	package{'roundcube':
		ensure => 'present',
	}
	file{'/usr/local/www/roundcube/config/config.inc.php':
		ensure => 'file',
		source => 'puppet:///modules/roundcube/config.inc.php',
		require => Package['roundcube'],
	}
}
