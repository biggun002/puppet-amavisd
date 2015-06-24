class mysqlcon{
	file{'/var/db/mysql/my.cnf' :
		source => 'puppet:///modules/mysqlcon/my.cnf',
		ensure => file,
		group => 'mysql',
		owner =>  'mysql',
	#	require => [User['mysql'],Package['mysql56-server']],
	}
	file{'importdump':
		ensure => 'file',
		path => '/var/db/mysql/localhost.sql',
		source => 'puppet:///modules/mysqlcon/localhost.sql',
	}
	mysql::db {'dumpDB':
   		user     => 'root',
      		password => '',
      		host     => 'localhost',
      		grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP'],
      		sql      =>  '/var/db/mysql/localhost.sql',
      		require  => File['importdump'],
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
