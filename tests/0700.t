--no-stat --no-summary
======================

setup
*****

::

  $ . $TESTDIR/tools.sh
  $ cd checkout


test
****

::

  $ git mime --stat --summary --no-stat --no-summary 8184848 | filter
  From 818484819cb2c2f81d2223ad22aaaba4b889ff05 Mon Sep 17 00:00:00 2001
  From: Roman Neuhauser <rneuhauser@suse.cz>
  Date: Wed, 18 Jul 2012 20:07:16 +0200
  Subject: [PATCH] realistic output of numbers from xml responses
  MIME-Version: 1.0
  Content-Transfer-Encoding: quoted-printable
  
  real xml parser will not cast numeric strings to numbers,
  so don't do it in the preliminary mock.
  
  diff --git a/lib/admin.coffee b/lib/admin.coffee
