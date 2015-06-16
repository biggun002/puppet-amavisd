class php{
	package{'mod_php56':
		ensure => 'present',
	}
	file{'/usr/local/etc/php.ini':
		source => 'puppet:///modules/php/php.ini',
		ensure => 'file',
		require => Package['mod_php56'],
	}
	service{'apache24':
		ensure => 'running',
	}
}
