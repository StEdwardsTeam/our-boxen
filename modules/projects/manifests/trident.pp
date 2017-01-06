class projects::trident {

  require mysql

  mysql::db { 'trident_development': }
  mysql::db { 'trident_test': }
}
