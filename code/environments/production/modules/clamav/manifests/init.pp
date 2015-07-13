class clamav{
	package{'clamav':
		ensure	=> 'present',
	}
        $pkg='clamav'   
        $str="${pkg}_freshclam_enable=\"YES\""
        $str2="${pkg}_clamd_enable=\"YES\""
        exec {'rcconf-clamav':
                command => "echo ${str}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str} /etc/rc.conf",
                require => Package["${pkg}"],
        }
        exec {'rcconf-clamav2':
                command => "echo ${str2}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str2} /etc/rc.conf",
                require => Package["${pkg}"],
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
		require => [Package['clamav'],User['vscan']],
		owner => 'clamav',
		ignore => 'clamd.sock',
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
	exec{'freshclam':
		path => '/usr/local/bin',
		require => Service['clamav-freshclam'],
	}
	service{'clamav-clamd':
		ensure 	=> 'running',
		subscribe => [File['/usr/local/etc/clamd.conf'],Service['clamav-freshclam'],Exec['freshclam']],
	}
}
