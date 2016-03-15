class projects::holycross {

  require projects::drupal_7

  $php_version = hiera(drupal7::php_version)

  php::project { 'holycross':
    source        => 'stedwards/holycrossinstitute',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  }
}
