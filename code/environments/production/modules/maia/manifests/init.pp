class maia{
	package{'maia' :
		ensure => 'present',
	}

	service{'maiad' : 
		ensure => 'running',
		subscribe => [File['/usr/local/etc/maia/maia.conf'], File['/usr/local/etc/maia/maiad.conf']],
	}

	file{'/usr/local/etc/maia/maia.conf' :
		ensure => 'file',
		source => 'puppet:///modules/maia/maia.conf',
		require => Package['maia'],
	}

	file{'/usr/local/etc/maia/mail':
		ensure => 'directory',
		require => Package['maia'],
	}
	
	file{'/usr/local/etc/maia/mail/spamassassin':
		ensure => 'directory',
		require => [File['/usr/local/etc/maia/mail'],Package['maia']],
	}

	exec{'configtest' :
		path => '/usr/local/bin/',
		command => 'perl /usr/local/share/maia/scripts/configtest.pl',
		require => Package['maia'],
	}

	exec{'sa-update' :
		path => '/usr/local/bin',
		require => Package['spamassassin'],
	}
	
	exec{'load-sa-rules' :
		  path => '/usr/local/bin/',
                  command => 'perl /usr/local/share/maia/scripts/load-sa-rules.pl',
                  require => [Package['maia'], Package['spamassassin']],
		  user => 'vscan', 
        }

	file{'/usr/local/www/maia':
		ensure => 'present',
		require => Package['maia'],
		mode => '0777',
		recurse => true,
	}	

	file{'/usr/local/www/maia/config.php' :
		ensure => 'file',
		source => 'puppet:///modules/maia/config.php',
		require => Package['maia'],
	}

	exec{'graceful' :
		path => '/usr/local/sbin',
		command => 'apachectl graceful',
		require => [Package['apache24'],File['/usr/local/www/maia/config.php']],
	}
	
	file{'/usr/local/etc/maia/maiad.conf' :
                ensure => 'file',
                source => 'puppet:///modules/maia/maiad.conf',
                require => Package['maia'],
        }
	
	cron{'load-sa-rules':
	command => 'perl /usr/local/share/maia/scripts/load-sa-rules.pl > /dev/null',
	user => vscan,
	minute => 0,
}

cron{'process-quarantine':
	command => 'perl /usr/local/share/maia/scripts/process-quarantine.pl > /dev/null',
	user => vscan,
	minute => 10,
}

cron{'stats-snapshot':
	command => 'perl /usr/local/share/maia/scripts/stats-snapshot.pl > /dev/null',
	user => vscan,
	minute => 20,
}

cron{'expire-quarantine-cache':
	command => 'perl /usl/local/share/maia/scripts/expire-quarantine-cache.pl > /dev/null',
	user => vscan,
	minute => 30,
}

cron{'send-quarantine-reminders':
	command => 'perl /usr/local/share/maia/scripts/send-quarantine-reminders.pl > /dev/null',
	user => vscan,
	minute => 40,
}

cron{'send-quarantine-digests':
	command => 'perl /usr/local/share/maia/scripts/send-quarantine-digests.pl > /dev/null',
	user => vscan,
	minute => 50,
}

cron{'sa-learn':
	command => 'perl /usr/local/bin/sa-learn --sync --force-expire > /dev/null',
	user => vscan,
	minute => 45,
}
	
}
