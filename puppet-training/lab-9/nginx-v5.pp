$app= "nginx"
$version= "v5"
$content= "Welcome to $app-$version.pp By Nathan on puppet server"
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

# epp(<FILE REFERENCE>, [<PARAMETER HASH>])
if $facts['os']['family'] == 'RedHat' {
  file { "Edit /usr/share/nginx/html/index.html":
    name    => "/usr/share/nginx/html/index.html",
    content => epp('/root/puppet-training/lab-9/content.epp'),
    notify  => Service["Start $app"],
  }
}

