class people::milesperryseu {

  include projects::forms

  $home = "/Users/${::boxen_user}"

  file { "${home}/dev":
    ensure => directory,
  } ->
  file { "${home}/dev/apps":
    ensure => directory,
    before => File["${home}/dev/apps/projects"]
  }
}
