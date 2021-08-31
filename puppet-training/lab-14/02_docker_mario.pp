docker::run { 'mario':
  image   => 'pengbai/docker-supermario',
  ports   => '80:8080',
}
