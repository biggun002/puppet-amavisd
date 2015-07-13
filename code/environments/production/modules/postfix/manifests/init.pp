class postfix{
	service{'sendmail' : 
		ensure => 'stopped',
	}
	
	package{'postfix' :
		ensure => 'present',
	}
        $pkg='postfix'   
        $str="${pkg}_enable=\"YES\""
        exec {'rcconf-postfix':
                command => "echo ${str}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str} /etc/rc.conf",
                require => Package["${pkg}"],
        }
	# DISABLE SENDMAIL
        $pkg2='sendmail'   
        $str2="${pkg2}_enable=\"NO\""
        exec {'rcconf-sendmail2':
                command => "echo ${str2}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str2} /etc/rc.conf",
                require => Package["${pkg}"],
        }
        $str3="${pkg2}_submit_enable=\"NO\""
        exec {'rcconf-sendmail3':
                command => "echo ${str3}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str3} /etc/rc.conf",
                require => Package["${pkg}"],
        }
        $str4="${pkg2}_outbound_enable=\"NO\""
        exec {'rcconf-sendmail4':
                command => "echo ${str4}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str4} /etc/rc.conf",
                require => Package["${pkg}"],
        }
        $str5="${pkg2}_msp_queue_enable=\"NO\""
        exec {'rcconf-sendmail5':
                command => "echo ${str5}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str5} /etc/rc.conf",
                require => Package["${pkg}"],
        }
	
	file{'/etc/periodic.conf' :
		ensure => 'file',
		source => 'puppet:///modules/postfix/periodic.conf',
		require => Package['postfix'],
	} 
	
	file{'/usr/local/etc/postfix' :
		source => 'puppet:///modules/postfix/postfix',
		recurse => 'true',
		require => Package['postfix'],
	}
	
	file{'/usr/local/etc/ssl/postfix' :
		ensure => 'directory',
		require => Package['postfix'],
	}

	service{'postfix' :
		ensure => 'running',
		subscribe => File['/usr/local/etc/postfix/'],
	}
	
	exec{'execopenssl' :
		path => '/usr/bin',
		command => 'openssl req -passin pass:pass -new -x509 -nodes -out smtpd.pem -keyout smtpd.pem -days 3650 -subj "/CN=www.example.com/O=Example/C=TH/ST=Bangkok/L=Bangkok"',
		cwd => '/usr/local/etc/ssl/postfix',
		require => Package['postfix'],
	}

	file{'/usr/local/etc/postfix/transport' :
		ensure => 'file',
		require => Package['postfix'],
	}

	exec{'postmap /usr/local/etc/postfix/transport':
		path => '/usr/local/sbin',
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
	
	exec{'copyaliases':
		path => '/bin',
		cwd => '/etc/mail',
		command => 'cp aliases.db ..',
		require => Exec['newaliases'],
	}
}	
