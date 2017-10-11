package { 'nginx':
  ensure => present
}

package { 'php7.0':
  ensure  => present,
  require => Package['nginx']
}

package { 'php7.0-mysql':
  ensure  => present,
  require => Package['php7.0']
}

package { 'apache2.2-common':
  ensure => absent
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx']
}

file { '/etc/nginx/sites-enabled/default':
  source => 'puppet:///modules/nginx/site.conf',
  notify => Service['nginx']
}

file { '/var/www/html/index.html':
  source  => 'puppet:///modules/nginx/index.html',
  require => File['/etc/nginx/sites-enabled/default']
}

file { '/var/www/html/index.php':
  source  => 'puppet:///modules/nginx/index.php',
  require => File['/etc/nginx/sites-enabled/default']
}

file { '/var/www/html/mysql.php':
  source  => 'puppet:///modules/nginx/mysql.php',
  require => File['/etc/nginx/sites-enabled/default']
}

package { 'mysql-server':
  ensure => present
}

service { 'mysql':
  ensure  => true,
  enable  => true,
  require => Package['mysql-server'],
}

$mysql_password = 'tajne_haslo'

exec { "set-mysql-password":
  unless => "mysqladmin -uroot -p$mysql_password status",
  path => ["/bin", "/usr/bin"],
  command => "mysqladmin -uroot password $mysql_password",
  require => Service["mysql"],
}

$dbname = 'test'
$dbuser = 'test'
$dbpassword = 'test123'

exec { "create-db":
  unless => "/usr/bin/mysql -u${dbuser} -p${dbpassword} ${dbname}",
  command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${dbname}; grant all on ${dbname}.* to ${dbuser}@localhost identified by '$dbpassword';\"",
  require => Service["mysql"],
}