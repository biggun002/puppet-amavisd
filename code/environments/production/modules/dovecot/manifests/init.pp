class dovecot{
	package{'dovecot2-pigeonhole' :
		ensure => 'present',
	}

	package{'dovecot2' :
		ensure => 'present',
	}

	file{'/usr/local/etc/dovecot' :
		ensure => 'directory',
		source => 'puppet:///modules/dovecot/dovecot',
		require => [Package['dovecot2-pigeonhole'],Package['dovecot2']],
	}
	
	file{'/usr/local/virtual/home' :
		ensure => 'directory',
		require => [Package['dovecot2-pigeonhole'],Package['dovecot2']],
	}

	file{'/usr/local/virtual/home/default.sieve' :
		ensure => 'file',
		source => 'puppet:///modules/dovecot/default.sieve',
		require => [Package['dovecot2-pigeonhole'],Package['dovecot2']],
	}

	exec{'sievec /usr/local/virtual/home/default.sieve' :
		path => '/usr/sbin',
		subscribe => File['/usr/local/virtual/home/default.sieve'],
	}

	file{'/usr/local/virtual' :
		ensure => 'directory',
		owner => 'vscan',
		group => 'vscan',
		mode => '0740',
		require => [Package['dovecot2-pigeonhole'],Package['dovecot2']],
		recurse => 'true',
	}

	exec{'pw usermod dovecot -G vscan' :
		path => '/usr/sbin',
		require => [Package['dovecot2-pigeonhole'],Package['dovecot2']],
	}
	
	file{'/usr/local/etc/ssl/dovecot' :
		ensure => 'directory',
		require => [Package['dovecot2-pigeonhole'],Package['dovecot2']],
	}

	exec{'openssl req -new -x509 -nodes -out cert.pem -keyout key.pem -days 3650' :
		path => '/usr/sbin',
		cwd => '/usr/local/etc/ssl/dovecot',
		require => File['/usr/local/etc/ssl/dovecot'],
	}
}	
