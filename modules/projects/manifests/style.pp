class projects::style {

  include php::composer

  boxen::project { 'style':
    source => 'StEdwardsTeam/style-guide',
    nginx  => true,
  }
}
