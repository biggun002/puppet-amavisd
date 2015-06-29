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
}
