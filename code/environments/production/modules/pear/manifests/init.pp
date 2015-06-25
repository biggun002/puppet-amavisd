class pear{
	package{ 'pear':
		ensure	=> 'present',
                provider => 'freebsd',
                source => 'http://localhost/pkg',
	}
	package{ 'pear-Auth':
		ensure => 'present',
                provider => 'freebsd',
                source => 'http://localhost/pkg',
	}
	package{ 'pear-Log':
		ensure => 'present',
                provider => 'freebsd',
                source => 'http://localhost/pkg',
	}
	package{ 'pear-Net_SMTP':
		ensure => 'present',
                provider => 'freebsd',
                source => 'http://localhost/pkg',
	}
}
