class histograph::neo4j(
  $home_dir = $histograph::params::neo4j_home_dir,
  $histograph_plugin_repository = $histograph::params::neo4j_histograph_plugin_repository,
) inherits histograph::params {


  # Make a more familiar fs:
  file {
    '/var/lib/neo4j':
      ensure => link,
      group  => 'neo4j',
      owner  => 'neo4j',
      target => "${home_dir}";
    '/etc/init.d/neo4j-service':
      ensure => link,
      target => "${home_dir}/bin/neo4j" ;
    '/var/log/neo4j':
      ensure => link,
      target => "${home_dir}/data/log"
  }

  $properties_file = "${home_dir}/conf/neo4j-server.properties"
  create_resources(file_line, hiera('neo4j::properties', { }), {path  => $properties_file})

  wget::fetch { $histograph_plugin_repository:
    cache_dir           => '/opt',
    destination         => "${home_dir}/plugins/histograph-plugin-0.5.0-SNAPSHOT.jar",
    nocheckcertificate  => true,
  }

  exec {
    'Create a unique constraint and index':
      command => "${home_dir}/bin/neo4j-shell -host ${histograph::endpoint_neo4j} -c 'CREATE CONSTRAINT ON (n:_) ASSERT n.id IS UNIQUE;'",
  }

}