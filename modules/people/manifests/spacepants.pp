class people::spacepants {

  include python

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

  file { $my:
    ensure  => directory,
  }
  repository { $dotfiles:
    source  => 'spacepants/dotfiles',
    require => File[$my]
  }

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

#  exec { 'dumb workaround until boxen fixes pip':
#    command => 'sudo easy_install Pygments',
#    creates => '/usr/local/bin/pygmentize'
#  } ->
#  repository { $pygments_style:
#    source  => 'gthank/solarized-dark-pygments',
#  }
#  file { "${styles_dir}/solarized.py":
#    ensure  => link,
#    target  => "${pygments_style}/solarized.py",
#    require => Repository[$pygments_style]
#  }
#  file { "${styles_dir}/solarized256.py":
#    ensure  => link,
#    target  => "${pygments_style}/solarized256.py",
#    require => Repository[$pygments_style]
#  }

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
  package { 'wget':
    install_options => [ '--with-iri' ]
  }

  # old ass ruby for legacy puppet support
  ruby::version { '1.8.7': }

  homebrew::tap { 'homebrew/binary': }

  python::version { '2.7': }

  python::package { "pygments for 2.7.8":
    package => 'pygments',
    python  => '2.7.8',
    version => '>=2.0',
  }

  boxen::project { 'br-frontend-testing-demo':
    nginx  => true,
    source => 'sparkbox/br-frontend-testing-demo'
  }

}
