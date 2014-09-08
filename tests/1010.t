--output $dir
=============

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout


test
****

::

  $ mkdir omg
  $ git mime --output omg 033370c
  fatal: --output optarg is not a writable file
  [1]

