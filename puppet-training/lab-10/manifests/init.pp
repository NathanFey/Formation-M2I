class nginx (String $app = "nginx", String $version = "latest") {
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
      content => epp('nginx/content.epp', {'version' => $version, 'app' => $app}),
      notify  => Service["Start $app"],
    }
  }
}
