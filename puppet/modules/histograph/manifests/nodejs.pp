class histograph::nodejs inherits histograph::params {

  anchor {
    'histograph::nodejs::begin':
  }->class {
    'histograph::nodejs::repo':
  }->class {
    'histograph::nodejs::packages':
  }->class {
    'histograph::nodejs::install':
  }->anchor {
    'histograph::nodejs::end':
  }

}