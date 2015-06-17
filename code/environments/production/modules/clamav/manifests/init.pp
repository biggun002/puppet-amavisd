class clamav{
	package{'clamav':
		ensure	=> 'present',
	}
	user{'vscan':
		ensure => 'present',
	}
	file{'/usr/local/etc/freshclam.conf':
		source => 'puppet:///modules/clamav/freshclam.conf',
		ensure => 'file',
		require => Package['clamav'],
	}
	file{'/usr/local/etc/clamd.conf':
		source => 'puppet:///modules/clamav/clamd.conf',
		ensure => 'file',
		require => Package['clamav'],
	}
	file{'/var/log/clamav':
		ensure => 'directory',
		require => [Package['clamav'],User['vscan']],
		owner => User['vscan'],
		mode => '0775',
		recurse => 'true',
	}
	file{'/var/run/clamav':
		ensure => 'directory',
		require => [Package['clamav'],User['vscan']],
		owner => User['vscan'],
		mode => '0775',
		recurse => 'true',
	}
	file{'/var/db/clamav':
		ensure => 'directory',
		require => [Package['clamav'],User['vscan']],
		owner => User['vscan'],
		mode => '0775',
		recurse => 'true',
	}
	service{'clamav-freshclam':
		ensure => 'running',
		subscribe => File['/usr/local/etc/freshclam.conf'],
	}
	service{'clamav-clamd':
		ensure 	=> 'running',
		subscribe => [File['/usr/local/etc/clamd.conf'],Service['clamav-freshclam']],
	}
}
