class histograph::elasticsearch() inherits histograph::params {

  create_resources(elasticsearch::instance, hiera('elasticsearch::instance', { }))
  user {
    $elasticsearch::params::elasticsearch_user:
      ensure     => present,
      managehome => true,
  }
}