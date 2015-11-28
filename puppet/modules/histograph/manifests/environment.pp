class histograph::environment(
  $file = '/etc/environment',
  $variables = [],
) {

  file {
    $file:
      ensure => file,
      source => template('histograph/environment.sh'),
  }

}