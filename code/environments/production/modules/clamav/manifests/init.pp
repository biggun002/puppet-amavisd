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
		mode => '0777',
		recurse => 'true',
		require => [Package['clamav'],User['vscan']],
		owner => 'clamav',
	}
	file{'/var/run/clamav':
		ensure => 'directory',
		mode => '0777',
		recurse => 'true',
		require => [Package['clamav'],User['vscan']],
		owner => 'clamav',
	}
	file{'/var/db/clamav':
		ensure => 'directory',
		mode => '0777',
		recurse => 'true',
		require => [Package['clamav'],User['vscan']],
		owner => 'clamav',
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
