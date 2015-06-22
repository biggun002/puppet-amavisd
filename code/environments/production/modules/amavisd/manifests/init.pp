class amavisd{
	package{'amavisd':
		ensure => 'present',
	}
	file{'/usr/local/etc/amavisd.conf':
		ensure => 'file',
		source => 'puppet:///modules/amavisd/amavisd.conf',
		require => 'Package['amavisd'],
	}
}
