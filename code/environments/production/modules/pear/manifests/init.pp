class pear{
	package{ 'pear':
		ensure	=> 'present'
	}
	service{'apache24':
		ensure => 'running',
	}
}
