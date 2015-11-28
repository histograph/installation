class histograph::environment(
  $file = '/etc/environment',
  $variables = {},
) {

  file {
    $file:
      ensure => file,
      content => template('histograph/environment.sh'),
  }

}