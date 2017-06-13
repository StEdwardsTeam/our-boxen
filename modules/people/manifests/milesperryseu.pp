class people::milesperryseu {

  $home = "/Users/${::boxen_user}"

  homebrew::tap { 'homebrew/binary': }

  file { "${home}/dev":
    ensure => directory,
  } ->
  file { "${home}/dev/apps":
    ensure => directory,
    before => File["${home}/dev/apps/projects"]
  }
}
