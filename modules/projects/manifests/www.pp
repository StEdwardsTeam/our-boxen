class projects::www {

  require projects::drupal_7

  $project_name = 'www'
  $php_version = hiera(drupal7::php_version)

  php::project { 'www':
    source        => 'stedwards/www',
    mysql         => true,
    nginx         => 'projects/shared/drupal.nginx.conf.erb',
    php           => $php_version,
  } ->
  file { "${::boxen::config::srcdir}/${project_name}/src/sites/default/settings-local.php":
    ensure  => file,
    mode    => '0644',
    replace => false,
    content => template('projects/shared/drupal.settings-local.php.erb'),
    owner   => $::boxen_user,
    group   => $::boxen_group,
  }
}
