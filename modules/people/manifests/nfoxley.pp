class people::nfoxley {

  $home = "/Users/${::boxen_user}"
  $nodejs_version = '8.1.0'
  nodejs::version { $nodejs_version: }

  homebrew::tap { 'homebrew/binary': }

}
