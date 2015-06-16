class fixpkg{
   file { '/usr/local/etc/pkg/repos':
	ensure => directory,
   }
   file { '/etc/pkg/':
	ensure => directory,
   }
   file {'/usr/local/etc/pkg/repos/FreeBSD.conf':
    	source => 'puppet:///modules/fixpkg/FreeBSD.conf', 	
	ensure => present,
   }
   file {'/etc/pkg/FreeBSD.conf':
    	source => 'puppet:///modules/fixpkg/FreeBSD.conf', 	
	ensure => present,
   }
   file{'/etc/rc.conf':
     	source => 'puppet:///modules/fixpkg/rc.conf',
	ensure => file,
   }
}
