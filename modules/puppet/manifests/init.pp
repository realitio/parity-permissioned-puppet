class puppet {

  # We use puppet, but only using puppet apply, so no server
  service { 'puppet':
     enable => false,
  }

}
