class projects::upost {

  include php::composer

  $php_version = hiera(drupal6::php_version)

  php::project { 'upost':
    source        => 'git@bitbucket.org:stedwards/upost.git',
    mysql         => true,
    nginx         => 'projects/shared/nginx-php.conf.erb',
    php           => $php_version,
  }
}
