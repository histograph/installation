class histograph::nodejs::install {


# run npm commands
  create_resources(nodejs::npm, hiera('nodejs::npm', { user => $histograph::user }))

  histograph::nodejs::pm2 {
    'api':
      require => [Nodejs::Npm['api'], Nodejs::Npm['pm2']],
      user    => $histograph::user;
    'core':
      require => [Nodejs::Npm['core'], Nodejs::Npm['pm2']],
      user    => $histograph::user;
  }

}