class projects::drupal_7 {

  require php::composer
  require mysql

  $php_version = hiera(drupal7::php_version)

  php::extension::imagick { "imagick for ${php_version}":
    php     => $php_version,
    version => '3.1.2'
  }

  php::extension::xdebug { 'xdebug for ${php_version}':
    php     => $php_version,
    version => '2.3.3'
  }

  php::extension::xhprof { 'xhprof for ${php_version}':
    php     => $php_version,
    version => '0.9.4'
  }
}
