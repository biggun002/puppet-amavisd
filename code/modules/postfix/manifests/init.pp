class postfix{
	service{'sendmail' : 
		ensure => 'stopped',
	}
	
	package{'postfix' :
		ensure => 'present',
	}
	
	service{'postfix' :
		ensure => 'running',
		subscribe => [file[/usr/local/etc/postfix/main.cf], file[/usr/local/etc/postfix/master.cf]],
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

	file{'/usr/local/etc/ssl/postfix' :
		ensure => 'directory',
		require => Package['postfix'],
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

	exec{'postmap /usr/local/etc/postfix/transport'
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
