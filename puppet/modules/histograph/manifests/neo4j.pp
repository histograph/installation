class histograph::neo4j(
  $home_dir = $histograph::params::neo4j_home_dir,
  $histograph_plugin_repository = $histograph::params::neo4j_histograph_plugin_repository,
) inherits histograph::params {


  anchor {
    'histograph::neo4::begin':
  }->class {
    'histograph::neo4j::properties':
  }->class {
    'histograph::neo4j::index':
  }->anchor {
    'histograph::neo4::end':
  }

}