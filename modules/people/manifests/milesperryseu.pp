class people::milesperryseu {

  $home = "/Users/${::boxen_user}"

  homebrew::tap { 'homebrew/binary': }

  include projects::seui
  include projects::photolookup

  $nodejs_version = '8.1.0'
  nodejs::version { $nodejs_version: }

  file { "${home}/dev":
    ensure => directory,
  } ->
  file { "${home}/dev/apps":
    ensure => directory,
    before => File["${home}/dev/apps/projects"]
  }
}
