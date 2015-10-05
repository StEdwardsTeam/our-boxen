class projects::www {

  include php::composer

  php::project { 'www':
    source        => 'StEdwardsTeam/www',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => '5.4.41',
  }

  php::extension::imagick { 'imagick for 5.4.41':
    php     => '5.4.41',
    version => '3.1.2'
  }
}
