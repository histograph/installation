define histograph::nodejs::pm2 (
  $app = $name, # e.g. core
  $user = 'histograph',
) {

  $instance = "${user}-${app}"
  $indexfile = "/opt/${user}/node_modules/${instance}/index.js"
  $os = downcase($::operatingsystem)

  exec {
    "run app ${instance}":
      command     => "pm2 start ${indexfile} --name ${instance} && pm2 save ",
      environment => "HOME=/home/${user}", # Because puppet does not set it.
      unless      => "pm2 show ${instance}",
      user        => $user,
      path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
      timeout     => 600; # ten minutes build time.
    "install service ${instance}":
      require => Exec["run app ${instance}"],
      command => "env PATH=\$PATH:/usr/bin pm2 startup ${os} -u $user --hp /home/$user",
      unless  => 'test -f /etc/init.d/pm2-init.sh',
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games';
  }

}