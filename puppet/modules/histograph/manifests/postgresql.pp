class histograph::postgresql {

  class {
    'postgresql::globals':
  }->class {
    [
      'postgresql::server',
      'postgresql::server::postgis'
    ]:
  }

  create_resources(postgresql::server::db, hiera('postgresql::server::db', { }))
  create_resources(postgresql::server::pg_hba_rule, hiera('postgresql::server::pg_hba_rule', { }))

}