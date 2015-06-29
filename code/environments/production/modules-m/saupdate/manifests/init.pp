class saupdate{
	package{'wget':
		ensure => present,
	}
	file{'/var/db/spamassassin':
		ensure => present,
	}
	file{'/var/db/spamassassin/3.004001':
		ensure => directory,
		require => File['/var/db/spamassassin'],
	}
	exec{'wgetupdate':
		path => '/usr/local/bin',
		cwd => '/var/db/spamassassin/3.004001',
		command => 'wget apache.claz.org//spamassassin/source/Mail-SpamAssassin-rules-3.4.1.r1675274.tgz',
		require => [File['/var/db/spamassassin/3.004001'],Package['wget']],
	}
	exec{'tarupdate':
		path => '/usr/bin',
		cwd => '/var/db/spamassassin/3.004001',
		command => 'tar -xvf Mail-SpamAssassin-rules-3.4.1.r1675274.tgz',
		require => Exec['wgetupdate'],
	}
}
