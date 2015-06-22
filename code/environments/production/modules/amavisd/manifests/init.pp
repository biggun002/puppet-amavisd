class amavisd{
	package{'amavisd-new':
		ensure => 'present',
	}
	file{'/usr/local/etc/amavisd.conf':
		ensure => 'file',
		source => 'puppet:///modules/amavisd/amavisd.conf',
		require => Package['amavisd'],
	}
}
