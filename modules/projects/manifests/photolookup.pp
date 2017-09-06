class projects::photolookup {

  include sdkman

  ::sdkman::groovy { '2.4.12': }
  ::sdkman::grails { '3.3.0': }
  ::sdkman::gradle { '4.0.2': }
}
