class clamav{
	package{'m-clamav':
		ensure	=> 'present',
	}
	user{'vscan':
		ensure => 'present',
	}
	file{'/usr/local/etc/freshclam.conf':
		source => 'puppet:///modules/clamav/freshclam.conf',
		ensure => 'file',
		require => Package['m-clamav'],
	}
	file{'/usr/local/etc/clamd.conf':
		source => 'puppet:///modules/clamav/clamd.conf',
		ensure => 'file',
		require => Package['m-clamav'],
	}
	file{'/var/log/clamav':
		ensure => 'directory',
		mode => '0777',
		recurse => 'true',
		require => [Package['m-clamav'],User['vscan']],
		owner => 'clamav',
	}
	file{'/var/run/clamav':
		ensure => 'directory',
		mode => '0777',
		recurse => 'true',
		require => [Package['m-clamav'],User['vscan']],
		owner => 'clamav',
	}
	file{'/var/db/clamav':
		ensure => 'directory',
		mode => '0777',
		recurse => 'true',
		require => [Package['m-clamav'],User['vscan']],
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
		subscribe => [File['/usr/local/etc/clamd.conf'],Exec['freshclam']],
	}
}
