--output $file
==============

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout


test
****

happy path, `--output` optarg contains a writable pathname in
a writable directory.

::

  $ git mime --output outfile 033370c
  $ cat outfile
  From 033370ce84cf9ec3b7ef3adb058a479b10d8e582 Mon Sep 17 00:00:00 2001
  From: Roman Neuhauser <rneuhauser@suse.cz>
  Date: Wed, 18 Jul 2012 12:22:18 +0200
  Subject: [PATCH] basic .gitignore
  MIME-Version: 1.0
  
  ---
   .gitignore | 3 +++
   1 file changed, 3 insertions(+)
   create mode 100644 .gitignore
  
  diff --git a/.gitignore b/.gitignore
  new file mode 100644
  index 0000000..18448a0
  --- /dev/null
  +++ b/.gitignore
  @@ -0,0 +1,3 @@
  +.*.sw?
  +.sw?
  +README.html

