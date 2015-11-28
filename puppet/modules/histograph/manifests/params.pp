class histograph::params {
  $data_import = '/opt/histograph/data_import'
  $data_store = '/opt/histograph/data_store'
  $home_dir  = '/opt/histograph'
  $instance_conf = { }
  $endpoint_elasticsearch = $::hostname
  $endpoint_neo4j = $::hostname
  $endpoint_redis = $::hostname
  $neo4j_histograph_plugin_repository = 'https://github.com/histograph/neo4j-plugin/raw/master/dist/histograph-plugin-0.5.0-SNAPSHOT.jar'
  $neo4j_home_dir = '/opt/neo4j/neo4j-community-2.2.6'
  $user = 'histograph'
}