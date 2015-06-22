class mysqlcon{
	file{'/var/db/mysql/my.cnf' :
		source => 'puppet:///modules/mysqlcon/my.cnf',
		ensure => file,
		group => 'mysql',
		owner =>  'mysql',
	#	require => [User['mysql'],Package['mysql56-server']],
	}

	user {'mysql' :
		ensure => present,
	}

	package{'mysql56-server' :
		ensure => 'present',
	}
	
	mysql::db{'maia':
		user => 'vscan',
		password => '',
		host => 'localhost',
		ensure => 'present',
		sql => 'puppet:///modules/mysqlcon/maia-mysql.sql',
		grant => 'ALL',
	}
	
}	
