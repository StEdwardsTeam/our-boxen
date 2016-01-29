class projects::forms {

  require projects::drupal_7

  $php_version = hiera(drupal7::php_version)

  php::project { 'forms':
    source        => 'StEdwardsTeam/forms',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  }
}
