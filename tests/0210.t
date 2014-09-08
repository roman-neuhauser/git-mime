--no-summary
============

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout

test
****

::

  $ git mime --summary --no-summary 033370c
  From 033370ce84cf9ec3b7ef3adb058a479b10d8e582 Mon Sep 17 00:00:00 2001
  From: Roman Neuhauser <rneuhauser@suse.cz>
  Date: Wed, 18 Jul 2012 12:22:18 +0200
  Subject: [PATCH] basic .gitignore
  
  ---
   .gitignore | 3 +++
   1 file changed, 3 insertions(+)
  
  diff --git a/.gitignore b/.gitignore
  new file mode 100644
  index 0000000..18448a0
  --- /dev/null
  +++ b/.gitignore
  @@ -0,0 +1,3 @@
  +.*.sw?
  +.sw?
  +README.html
