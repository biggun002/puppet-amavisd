class apache{
	package{'apache24':
		ensure => 'present',
	}
        $pkg='apache24'   
        $str="${pkg}_enable=\"YES\""
        exec {'rcconf-apache':
                command => "echo ${str}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str} /etc/rc.conf",
                require => Package["${pkg}"],
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
	exec{'opensslgenrsa' :
		path => '/usr/bin',
		command => 'openssl genrsa -des3 -out server.key -passout pass:pass 1024',
		cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
	}

	exec{'opensslreq' :
                path => '/usr/bin',
		command => 'openssl req -new -key server.key -out server.csr -passin pass:pass -subj "/CN=www.example.com/O=Example/C=TH/ST=Bangkok/L=Bangkok"', 
                cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
        }
	exec{'opensslx509' :
                path => '/usr/bin',
		command => 'openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt -passin pass:pass',
                cwd => '/usr/local/etc/ssl/apache',
		require => File['/usr/local/etc/ssl/apache'],
        }
	exec{'backupserverkey':
		path => '/bin',
		cwd => '/usr/local/etc/ssl/apache',
		command => 'cp server.key server.key.orig',
		require => [Exec['opensslgenrsa'],Exec['opensslreq'],Exec['opensslx509']],
	}
	exec{'removesslpass':
		path => '/usr/bin/',
		cwd => '/usr/local/etc/ssl/apache',
		command => 'openssl rsa -in server.key.orig -out server.key -passin pass:pass',
		require => Exec['backupserverkey'],
	}
}	
