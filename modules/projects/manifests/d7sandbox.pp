class projects::d7sandbox {

  require projects::drupal_7

  $php_version = hiera(drupal7::php_version)

  php::project { 'd7sandbox':
    source        => 'stedwards/d7sandbox',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  }
}
