class { 'docker':
  docker_users => ['vagrant'],
}

class {'docker::compose':
  ensure => present,
}
