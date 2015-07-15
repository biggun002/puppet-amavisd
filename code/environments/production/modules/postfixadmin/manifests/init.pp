class postfixadmin{
	package{'postfixadmin':
		ensure => 'present',
	}
	file{'/usr/local/www/postfixadmin':
		ensure => 'present',
		mode => '0777',
		recurse => true,
		require => Package['postfixadmin'],
	}
	file{'/usr/local/www/postfixadmin/config.inc.php':
		source => 'puppet:///modules/postfixadmin/config.inc.php',
		ensure => 'file',
		require => Package['postfixadmin'],
	}	
	file{'/usr/local/etc/apache24/Includes/postfixadmin.conf':
		source => 'puppet:///modules/postfixadmin/postfixadmin.conf',
		ensure => 'file',
		require => Package['postfixadmin'],	
	}
	file{'/usr/local/bin/postfixadmin-domain-postdeletion.sh':
		source => 'puppet:///modules/postfixadmin/postfixadmin-domain-postdeletion.sh',
		ensure => 'file',
		require => Package['postfixadmin'],
	}
	file{'/usr/local/bin/postfixadmin-mailbox-postdeletion.sh':
		source => 'puppet:///modules/postfixadmin/postfixadmin-mailbox-postdeletion.sh',
		ensure => 'file',
		require => Package['postfixadmin'],
	}
}
