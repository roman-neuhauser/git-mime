--shortstat --no-stat
=====================

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout


for comparison
**************

::

  $ git format-patch --stdout --no-stat --shortstat -1 fa3e723 | filter
  From fa3e72308541183d3155a0b5c3350c96e3b5bd39 Mon Sep 17 00:00:00 2001
  From: Roman Neuhauser <rneuhauser@suse.cz>
  Date: Wed, 18 Jul 2012 12:26:00 +0200
  Subject: [PATCH] scaffolding: rudimentary package.json for npm, GNUmakefile
  
  
   2 files changed, 30 insertions(+)
  
  diff --git a/GNUmakefile b/GNUmakefile


test --no-stat
**************

::

  $ git mime --shortstat --no-stat fa3e723 | filter
  From fa3e72308541183d3155a0b5c3350c96e3b5bd39 Mon Sep 17 00:00:00 2001
  From: Roman Neuhauser <rneuhauser@suse.cz>
  Date: Wed, 18 Jul 2012 12:26:00 +0200
  Subject: [PATCH] scaffolding: rudimentary package.json for npm, GNUmakefile
  MIME-Version: 1.0
  
  ---
   create mode 100644 GNUmakefile
   create mode 100644 package.json
  
  diff --git a/GNUmakefile b/GNUmakefile
