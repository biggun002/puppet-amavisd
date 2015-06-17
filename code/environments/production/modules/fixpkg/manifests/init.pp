class fixpkg{

   file { '/usr/local/etc/pkg/':
	ensure => directory,
   }
   file { '/usr/local/etc/pkg/repos':
	ensure => directory,
	require => File['/usr/local/etc/pkg/'],
   }
   file { '/etc/pkg/':
	ensure => directory,
   }
   file {'/usr/local/etc/pkg/repos/FreeBSD.conf':
    	source => 'puppet:///modules/fixpkg/FreeBSD.conf', 	
	ensure => present,
	require => File['/usr/local/etc/pkg/repos/'],
   }
   file {'/etc/pkg/FreeBSD.conf':
    	source => 'puppet:///modules/fixpkg/FreeBSD.conf', 	
	ensure => present,
	require => File['/etc/pkg/'],
   }
   file{'/etc/rc.conf':
     	source => 'puppet:///modules/fixpkg/rc.conf',
	ensure => file,
   }
}
