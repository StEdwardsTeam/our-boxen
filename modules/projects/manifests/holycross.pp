class projects::holycross {

  include projects::drupal_7

  $php_version = '5.6.15'

  php::project { 'holycross':
    source        => 'StEdwardsTeam/holycrossinstitute',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  }
}
