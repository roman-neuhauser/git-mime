--add-header, conflict with commit headers
==========================================

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout


test
****

::

  $ git mime \
  > --add-header="From: impostor <phony-fake@sigpipe.cz>" \
  > 033370c | filter
  From 033370ce84cf9ec3b7ef3adb058a479b10d8e582 Mon Sep 17 00:00:00 2001
  From: impostor <phony-fake@sigpipe.cz>
  From: Roman Neuhauser <rneuhauser@suse.cz>
  Date: Wed, 18 Jul 2012 12:22:18 +0200
  Subject: [PATCH] basic .gitignore
  MIME-Version: 1.0
  
  ---
   .gitignore | 3 +++
   1 file changed, 3 insertions(+)
   create mode 100644 .gitignore
  
  diff --git a/.gitignore b/.gitignore
