class histograph::nodejs::repo {

# We want gcc-4.8
  include ::apt
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
    'RedHat': {
    # Do nothing.
    }
    default: {
    # Do nothing.
    }
  }

}