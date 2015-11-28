class histograph (
  $home_dir = $histograph::params::home_dir,
  $user = $histograph::params::user,
) inherits histograph::params {


# Elastic search
  if defined(Package['elasticsearch']) {
    include histograph::elasticsearch
  }

# neo4j
  if defined(Package['neo4j']) {
    include histograph::neo4j
  }

# nodejs
  if defined(Package['nodejs']) {
    include histograph::nodejs
  }

  package {
    [
      'python-software-properties',
    ]:
      ensure => present,
  }


  group {
    $user:
      ensure => present ;
  }
  user {
    $user:
      groups     => $user,
      managehome => true ;
  }


  file {
    $home_dir:
      ensure => directory,
      group  => $user,
      owner  => $user ;
  }

}
