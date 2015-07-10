class amavisd{
	package{'amavisd-new':
		ensure => 'present',
	}
        $pkg='amavisd'   
        $str="${pkg}_enable=\"YES\""
        exec {'rcconf-amavisd':
                command => "echo ${str}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str} /etc/rc.conf",
                require => Package["${pkg}-new"],
        }
	package{'maia':
		ensure => 'absent',
	}
	file{'/usr/local/etc/amavisd.conf':
		ensure => 'file',
		source => 'puppet:///modules/amavisd/amavisd.conf',
		require => Package['amavisd-new'],
	}
	file{'/var/log/local0':
		ensure => 'present',
	}
	service{'amavisd':
		ensure => 'running',
		subscribe => File['/usr/local/etc/amavisd.conf'],
	}
}
