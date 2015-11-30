class histograph::neo4j::index {

  exec {
    'Create a unique constraint and index': # How do we know this worked ? We sleep because the neo4j service may yet completed.
      command => "/bin/sleep 10 ; ${histograph::neo4j::home_dir}/bin/neo4j-shell -c 'CREATE CONSTRAINT ON (n:_) ASSERT n.id IS UNIQUE;'",
  }

}