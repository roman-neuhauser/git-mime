misuse: unknown option
======================

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout


test
****

::

  $ git mime --fubar HEAD
  fatal: unknown option --fubar
  [1]
