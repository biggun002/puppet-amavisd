class salearn{
	user{'vscan':
		ensure => 'present',
	}
	package{'spamassassin':
		ensure => 'present',
	}
	file{'/tmp/crontemp.sh'
		ensure => 'file',
		source => 'puppet:///modules/salearn/crontemp.sh',
		owner => 'vscan',
		mode => '0755',
		require => [User['vscan'],Package['spamassassin']],
	}
	exec{'runcron':
		path => '/usr/bin/',
		cwd => '/tmp/',
		command => 'crontab -u vscan crontemp.sh'
		require => File['/tmp/crontemp.sh'],
	}
}
