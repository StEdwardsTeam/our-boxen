class projects::www {

  include php::composer

  $php_version = '5.6.15'

  php::project { 'www':
    source        => 'StEdwardsTeam/www',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  } ->
  php::extension::imagick { "imagick for ${php_version}":
    php     => $php_version,
    version => '3.1.2'
  } ->
  php::extension::xdebug { 'xdebug for ${php_version}':
    php     => $php_version,
    version => '2.3.3'
  }
}
