class histograph::neo4j::properties {

# Make a more familiar fs:
  file {
    '/var/lib/neo4j':
      ensure => link,
      group  => 'neo4j',
      owner  => 'neo4j',
      target => "${histograph::neo4j::home_dir}";
    '/etc/init.d/neo4j-service':
      ensure => link,
      target => "${histograph::neo4j::home_dir}/bin/neo4j" ;
    '/var/log/neo4j':
      ensure => link,
      target => "${histograph::neo4j::home_dir}/data/log"
  }

  $properties_file = "${histograph::neo4j::home_dir}/conf/neo4j-server.properties"
  create_resources(file_line, hiera('neo4j::properties', { }), { path  => $properties_file })

  file {
    ["${histograph::neo4j::home_dir}", "${histograph::neo4j::home_dir}/plugins"]:
      ensure => directory,
      group  => 'neo4j',
      owner  => 'neo4j',
  }->wget::fetch { $histograph::neo4j::histograph_plugin_repository:
    cache_dir           => '/opt',
    destination         => "${histograph::neo4j::home_dir}/plugins/histograph-plugin-0.5.0-SNAPSHOT.jar",
    nocheckcertificate  => true,
  }

}