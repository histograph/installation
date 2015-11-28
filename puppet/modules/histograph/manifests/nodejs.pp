class histograph::nodejs() inherits histograph::params {


# We want gcc-4.8
  case $::osfamily {
    'Debian': {
      apt::source { 'ubuntu-toolchain-r-test-precise':
        include    => {
          'src' => true,
        },
        key        => 'BA9EF27F',
        key_server => 'hkp://keyserver.ubuntu.com:80',
        location   => "http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu",
        release    => $::lsbdistcodename,
        repos      => 'main',
      }
    }
  }

  package {
    ['python-software-properties', 'gcc-4.8', 'git']:
      ensure => present,
  }

# run npm commands
  create_resources(nodejs::npm, hiera('nodejs::npm', { }))

}