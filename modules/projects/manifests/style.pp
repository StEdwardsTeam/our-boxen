class projects::style {

  include php::composer

  boxen::project { 'style':
    source => 'stedwards/style-guide',
    nginx  => true,
  }
}
