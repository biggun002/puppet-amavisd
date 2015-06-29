class spamassassin{
	package{'m-spamassassin':
		ensure => 'present',	
	}
	file{'/usr/local/etc/mail/spamassassin/local.cf':
		source => 'puppet:///modules/spamassassin/local.cf',
		ensure => 'file',
		require => Package['m-spamassassin'],	
	}
}
