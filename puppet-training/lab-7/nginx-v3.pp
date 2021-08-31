$app= "nginx"
$version= "v3"
$content= "Welcome to nginx-$version.pp By Nathan on puppet server"

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

file { "Edit /usr/share/nginx/html/index.html":
  name    => "/usr/share/nginx/html/index.html",
  content => "$content\n",
  notify  => Service["Start $app"],
}

