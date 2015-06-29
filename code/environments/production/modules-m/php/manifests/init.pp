class php{
	package{'php56':
		ensure => 'present',
	}
	package{'php56-mysql':
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
