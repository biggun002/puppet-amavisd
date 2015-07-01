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
                  path => '/var/db/mysql/localhost_nodata.sql',
                  source => 'puppet:///modules/mysqlcon/localhost_nodata.sql',
          }
 
          file{'importdump2':
                  ensure => 'file',
                  path => '/var/db/mysql/localhost_mysql.sql',
                  source => 'puppet:///modules/mysqlcon/localhost_mysql.sql',
          }
 
          exec{'dumpDB':
		  path	   => '/usr/local/bin',
                  command  =>  'mysql -u root < /var/db/mysql/localhost_nodata.sql',
                  require  => File['importdump'],
          }
 
           exec{'dumpDB2':
		  path	   => '/usr/local/bin',
                  command  =>  'mysql -u root < /var/db/mysql/localhost_mysql.sql',
                  require  => File['importdump2'],
          }

	user {'mysql' :
		ensure => present,
	}

	package{'mysql56-server' :
		ensure => 'present',
	}
	
#	service{'mysql-server':
#		ensure => 'running',
#		subscribe => File['/var/db/mysql/my.cnf'],
#	}
	
	#mysql::db{'maia':
	#	user => 'vscan',
	#	password => '',
	#	host => 'localhost',
	#	ensure => 'present',
	#	sql => 'puppet:///modules/mysqlcon/maia-mysql.sql',
	#	grant => 'ALL',
	#}
	
}	
