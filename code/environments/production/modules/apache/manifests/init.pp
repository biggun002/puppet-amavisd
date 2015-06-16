class apache{
	package{'apache24':
		ensure => 'present',
	}
	file{'/usr/local/etc/apache24/httpd.conf':
		source => 'puppet:///modules/apache/httpd.conf',
		ensure => 'file',
		require => Package['apache24'],
	}
	file{'/usr/local/etc/apache24/extra/httpd-ssl.conf':
		source => 'puppet:///modules/apache/httpd-ssl.conf',
		ensure => 'file',
		require => Package['apache24'],
	}
	file{'/usr/local/etc/apache24/extra/httpd-default.conf':
		source => 'puppet:///modules/apache/httpd-default.conf',
		ensure => 'file',
		require => Package['apache24'],
	}
	service{'apache24':
		ensure => 'running',
		subscribe => File['/usr/local/etc/apache24/httpd.conf'],
	}	
	file{'/usr/local/etc/ssl/apache' :
		ensure => 'directory',
		require => Package['apache24'],
	}
	exec{'openssl genrsa -des3 -out server.key 1024' :
		path => '/usr/sbin',
		cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
	}

	exec{'openssl req -new -key server.key -out server.csr' :
                path => '/usr/sbin',
                cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
        }
	exec{'openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt' :
                path => '/usr/sbin',
                cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
        }
}	
