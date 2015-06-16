class postfix{
	service{'sendmail' : 
		ensure => 'stopped',
	}
	
	package{'postfix' :
		ensure => 'present',
	}
	
	file{'/etc/periodic.conf' :
		ensure => 'file',
		source => 'puppet:///modules/postfix/periodic.conf',
		require => Package['postfix'],
	} 
	
	file{'/usr/local/etc/postfix' :
		ensure => 'directory',
		source => 'puppet:///modules/postfix/postfix',
		require => Package['postfix'],
	}
	
	file{'/usr/local/etc/postfix/main.cf' :
		ensure => 'file',
		source => 'puppet://modules/postfix/postfix/main.cf',
		require => Package['postfix'],
	}

	file{'/usr/local/etc/postfix/master.cf' :
		ensure => 'file',
		source => 'puppet://modules/postfix/postfix/master.cf',
		require => Package['postfix'],
	}

	file{'/usr/local/etc/ssl/postfix' :
		ensure => 'directory',
		require => Package['postfix'],
	}

	service{'postfix' :
		ensure => 'running',
		subscribe => [File['/usr/local/etc/postfix/main.cf'], File['/usr/local/etc/postfix/master.cf']],
	}
	
	exec{'openssl req -new -x509 -nodes -out smtpd.pem -keyout smtpd.pem -days 3650' :
		path => '/usr/sbin',
		cwd => '/usr/local/etc/ssl/postfix',
		require => Package['postfix'],
	}

	file{'/usr/local/etc/postfix/transport' :
		ensure => 'file',
		require => Package['postfix'],
	}

	exec{'postmap /usr/local/etc/postfix/transport':
		path => '/usr/sbin',
		require => Package['postfix'],
	}

	file{'/etc/aliases' :
		ensure => 'file',
		source => 'puppet:///modules/postfix/aliases',
		require => Package['postfix'],
	}
	
	exec{'newaliases' :
		path => '/usr/bin',
		subscribe => File['/etc/aliases'],
	}
}	
