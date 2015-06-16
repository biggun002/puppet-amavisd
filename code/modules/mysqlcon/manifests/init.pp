class mysqlcon{
	file{'/var/db/mysql/my.cnf' :
		source => 'puppet:///modules/mysqlcon/my.cnf',
		ensure => file,
		group => 'mysql',
		ower =>  'mysql',
		require => User['mysql'],
		require => Package['mysql56-server'],
	}

	user {'mysql' :
		ensure => present,
	}

	service{'mysql-server' :
		ensure => 'running',
		subscribe => File['/var/db/mysql/my.cnf'],
	}
	
	package{'mysql56-server' :
		ensure => 'present',
	}
	
	mysql_user{'' :
		ensure => 'absent',
		require => Service['mysql-server'],
	}
	
	mysql_database{'maia':
		ensure => 'present',
		grant => 'vscan@localhost',
		sql => 'puppet:///modules/mysqlcon/maia-mysql',
		require => Service['mysql-server'],
	}

}	
