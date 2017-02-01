class projects::cas {

  require mysql

  mysql::db { 'cas_development': }
  mysql::db { 'cas_test': }
}
