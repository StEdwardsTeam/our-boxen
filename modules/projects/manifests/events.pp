class projects::events {

  include php::composer
  require projects::drupal_6

  $php_version = hiera(drupal6::php_version)

  php::project { 'events':
    source        => 'git@bitbucket.org:stedwards/events.git',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  }
}
