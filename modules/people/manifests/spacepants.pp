class people::spacepants {

  include python

  $nodejs_version  = "8.1.0"
  $python_version  = "2.7.8"
  $ruby_version    = "2.3.1"

  $home            = "/Users/${::boxen_user}"
  $code            = "${home}/code"
  $my              = "${code}/my"
  $dotfiles        = "${my}/dotfiles"
  $gitfriendly     = "${code}/git-friendly"
  $python_packages = '/Library/Python/2.7/site-packages'
  $pygments_style  = "${code}/solarized-dark-pygments"
  $styles_dir      = "${python_packages}/Pygments-2.0.2-py2.7.egg/pygments/styles"
  $z               = "${code}/z"
  $zsh             = "${z}/z.sh"

  file { "$home/.hushlogin":
    ensure => file,
    mode => '0644',
  }

  file { $my:
    ensure  => directory,
  }
  repository { $dotfiles:
    source  => 'spacepants/dotfiles',
    require => File[$my]
  } ->
  file { '/usr/local/bin':
    ensure  => directory,
  } ->
  repository { $gitfriendly:
    source  => 'jamiew/git-friendly',
  }
  file { '/usr/local/bin/branch':
    ensure  => link,
    target  => "${gitfriendly}/branch",
    require => Repository[$gitfriendly]
  }
  file { '/usr/local/bin/merge':
    ensure  => link,
    target  => "${gitfriendly}/merge",
    require => Repository[$gitfriendly]
  }
  file { '/usr/local/bin/pull':
    ensure  => link,
    target  => "${gitfriendly}/pull",
    require => Repository[$gitfriendly]
  }
  file { '/usr/local/bin/push':
    ensure  => link,
    target  => "${gitfriendly}/push",
    require => Repository[$gitfriendly]
  }
  file { '/usr/local/bin/restart-bt':
    ensure  => link,
    target  => "${dotfiles}/restart-bt.sh",
    require => File['/usr/local/bin']
  }

  exec { 'dumb workaround until boxen fixes pip':
    command => 'sudo easy_install Pygments',
    creates => '/usr/local/bin/pygmentize'
  } ->
  repository { $pygments_style:
    source  => 'gthank/solarized-dark-pygments',
  }
  file { "${styles_dir}/solarized.py":
    ensure  => link,
    target  => "${pygments_style}/solarized.py",
    require => Repository[$pygments_style]
  }
  file { "${styles_dir}/solarized256.py":
    ensure  => link,
    target  => "${pygments_style}/solarized256.py",
    require => Repository[$pygments_style]
  }

  repository { $z:
    source  => 'rupa/z',
  } ->
  file { $zsh:
    ensure => present,
    mode   => '0755',
  }

  # more useful packages
  package { 'ffmpeg':
    install_options => [ '--with-libvpx' ]
  }

  homebrew::tap { 'homebrew/binary': }

  include mysql

  npm_module { "bower for ${nodejs_version}":
    module       => 'bower',
    version      => '~> 1.8.0',
    node_version => $nodejs_version,
  }

  npm_module { "foundation-cli for ${nodejs_version}":
    module       => 'foundation-cli',
    version      => '~> 2.1.0',
    node_version => $nodejs_version,
  }

  npm_module { "grunt-cli for ${nodejs_version}":
    module       => 'grunt-cli',
    version      => '~> 1.2.0',
    node_version => $nodejs_version,
  }

  npm_module { "gulp for ${nodejs_version}":
    module       => 'gulp',
    version      => '~> 3.9.1',
    node_version => $nodejs_version,
  }

  npm_module { "phonegap for ${nodejs_version}":
    module       => 'phonegap',
    version      => '~> 6.3.0',
    node_version => $nodejs_version,
  }

  npm_module { "yeoman for ${nodejs_version}":
    module       => 'yo',
    version      => '~> 1.8.4',
    node_version => $nodejs_version,
  }

  include php::composer

  python::version { $python_version: }

  python::package { "pygments for $python_version":
    package => 'pygments',
    python  => $python_version,
    version => '>=2.0',
  }

  class { 'python::global': version => $python_version }

  nodejs::version { $nodejs_version: }

  sudoers { 'installer':
    users    => $::boxen_user,
    hosts    => 'ALL',
    commands => [
      '(ALL) SETENV:NOPASSWD: /usr/sbin/installer',
    ],
    type     => 'user_spec',
  }

  include projects::all
}
