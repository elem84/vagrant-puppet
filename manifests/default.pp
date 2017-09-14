package { 'nginx':
  ensure => installed
}

package { 'php7.0':
  ensure => installed,
  require => Package['nginx']
}

package { 'apache2.2-common':
  ensure => absent
}

service { 'nginx':
  ensure => running,
  require => Package['nginx']
}

file { '/etc/nginx/sites-enabled/default':
  source => 'puppet:///modules/nginx/site.conf',
  notify => Service['nginx']
}

file { '/var/www/html/index.html':
  source => 'puppet:///modules/nginx/index.html',
  require => File['/etc/nginx/sites-enabled/default']
}

file { '/var/www/html/index.php':
  source => 'puppet:///modules/nginx/index.php',
  require => File['/etc/nginx/sites-enabled/default']
}
