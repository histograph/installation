class histograph (
  $data_import            = $histograph::params::data_import,
  $data_store             = $histograph::params::data_store,
  $elasticsearch_endpoint = $histograph::params::elasticsearch_endpoint,
  $home_dir               = $histograph::params::home_dir,
  $instance_conf          = $histograph::params::instance_conf ,
  $endpoint_elasticsearch = $histograph::params::endpoint_elasticsearch,
  $endpoint_neo4j         = $histograph::params::endpoint_neo4j,
  $endpoint_redis         = $histograph::params::endpoint_redis,
  $user                   = $histograph::params::user,
) inherits histograph::params {

  include histograph::environment

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
    [$home_dir, $data_import, $data_store]:
      ensure => directory,
      group  => $user,
      owner  => $user ;
    "${home_dir}/config.yml":
      ensure  => file,
      content => template('histograph/config.yml.erb') ;
  }

# neo4j
  if defined('neo4j') {
    class {
      'histograph::neo4j':
        require => File["${home_dir}/config.yml"],
    }
  }

# nodejs
  if defined('nodejs') {
    class {
      'histograph::nodejs':
        require => File["${home_dir}/config.yml"],
    }
  }

#postgresql
#if defined('postgresql::globals') {
   class {
    'histograph::postgresql':
 }
#}

}
