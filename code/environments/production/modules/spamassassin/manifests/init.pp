class spamassassin{
	package{'spamassassin':
		ensure => 'present',	
	}

	package{'p5-DBD-mysql':
		ensure => 'present',
	}
	
	package{'p5-DBI':
		ensure => 'present',
	}	

	file{'/usr/local/etc/mail/spamassassin/local.cf':
		source => 'puppet:///modules/spamassassin/local.cf',
		ensure => 'file',
		require => Package['spamassassin'],	
	}
	$str="local0.info                                     /var/log/local0"
	exec{'syslogd-local0':
		command =>'echo  ${str}>> /etc/syslog.conf',
		path => ['/bin','/usr/bin/'],
		unless => "grep ${str} /etc/syslog.conf",
		require => File['/usr/local/etc/mail/spamassassin/local.cf'],
	}
}
