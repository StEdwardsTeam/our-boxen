class projects::www {

  require projects::drupal_7

  $php_version = '5.6.15'

  php::project { 'www':
    source        => 'StEdwardsTeam/www',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  }
}
