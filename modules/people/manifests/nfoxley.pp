class people::nfoxley {

  include projects::www

  $home = "/Users/${::boxen_user}"

  file { "${home}/dev":
    ensure => directory,
  }
}
