no options: revision not found
==============================

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout

test
****

::

  $ git mime not-found
  fatal: bad revision 'not-found'
  [1]
