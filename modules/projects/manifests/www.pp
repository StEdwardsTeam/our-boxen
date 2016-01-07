class projects::www {

  require projects::drupal_7

  $php_version = hiera(drupal7::php_version)

  php::project { 'www':
    source        => 'StEdwardsTeam/www',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  }
}
