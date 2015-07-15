class adminer{
	package{'adminer':
		ensure => 'present',
	}
	file{'/usr/local/etc/apache24/Includes/adminer.conf':
		source => 'puppet:///modules/adminer/adminer.conf',
		ensure => 'file',
		require => Package['adminer'],
	}
}
