$app= "nginx"
$version= "v4"
$content= "Welcome to nginx-$version.pp By Nathan on puppet server"
$dist = $facts['os']['family']

package { "Install $app":
  name   => "$app",
  ensure => 'present',
}

service { "Start $app":
  name      => "$app",
  ensure    => running,
  enable    => true,
  subscribe => [ 
    Package["Install $app"], 
    File["Edit /usr/share/nginx/html/index.html"],
  ],
}

if $facts['os']['family'] == 'RedHat' {
  file { "Edit /usr/share/nginx/html/index.html":
    name    => "/usr/share/nginx/html/index.html",
    content => "$content\n$dist\n",
    notify  => Service["Start $app"],
  }
}

