exec {'apt-update':
	command => '/usr/bin/apt-get update'
}

package {'apache2':
	require => Exec['apt-update'],
	ensure => installed,	
}

service {'apache2':
	require => Package['apache2'],
	ensure => running,
}


package {'mysql-server':
	require => Exec['apt-update'],
	ensure => installed,
}

service {'mysql':
	require => Package['mysql-server'],	
	ensure => running,
}

package {'php7.0':
	require => Exec['apt-update'],
	ensure => installed,
}
file {'/var/www/html/info.php':
	ensure => file,
	content => '<?php phpinfo(); ?>',
	require => Package['apache2'],
}