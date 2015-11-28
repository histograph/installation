class histograph::nodejs() inherits histograph::params {


# nodejs
  if defined(Package['nodejs']) {
    create_resources(nodejs::npm, hiera('nodejs::npm', { }))
  }


}