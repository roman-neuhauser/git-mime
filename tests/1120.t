--add-header, various
=====================

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout


test
****

::

  $ git mime \
  > --add-header="To: alice" \
  > --add-header="Cc: bob" \
  > --add-header="To: chris" \
  > 033370c | filter
  From 033370ce84cf9ec3b7ef3adb058a479b10d8e582 Mon Sep 17 00:00:00 2001
  To: alice
  Cc: bob
  To: chris
  From: Roman Neuhauser <rneuhauser@suse.cz>
  Date: Wed, 18 Jul 2012 12:22:18 +0200
  Subject: [PATCH] basic .gitignore
  
  ---
   .gitignore | 3 +++
   1 file changed, 3 insertions(+)
   create mode 100644 .gitignore
  
  diff --git a/.gitignore b/.gitignore
