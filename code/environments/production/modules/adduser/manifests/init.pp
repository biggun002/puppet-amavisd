class adduser{
	user{'vscan' :
		ensure => 'present',
	}
	file{'/usr/local/etc/apache24/Includes/pkg.conf':
		source => 'puppet:///modules/adduser/pkg.conf',
		ensure => 'file',
	}
}

