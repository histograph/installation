class histograph::nodejs::packages {

  package {
    [
      'g++',
      'gcc-4.8',
      'git',
      'make',
    ]:
      ensure => present,
  }->exec { 'update-gcc-alternatives':
    command => 'update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50',
    path    => '/usr/bin:/usr/sbin',
    unless  => "test /etc/alternatives/gcc -ef '/usr/bin/gcc-4.8'",
  }

}