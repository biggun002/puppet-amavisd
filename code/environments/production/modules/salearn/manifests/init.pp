class salearn{
	file{'/tmp/crontemp.sh':
		ensure => 'file',
		source => 'puppet:///modules/salearn/crontemp.sh',
		owner => 'vscan',
		mode => '0755',
	}
	exec{'runcron':
		path => '/usr/bin/',
		cwd => '/tmp/',
		command => 'crontab -u vscan crontemp.sh',
		require => File['/tmp/crontemp.sh'],
	}
}
