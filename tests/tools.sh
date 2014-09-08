export GIT_PAGER=cat
export GIT_EDITOR=false
export GIT_SSH=false
export GIT_ASKPASS=false
export GIT_CONFIG_NOSYSTEM=1
export HOME="$PWD"
export XDG_CONFIG_HOME="$PWD"
export PATH="${TESTDIR%/*}:$PATH"

(

  set -eu

  git config --global user.email "git-mime-tests@example.org"
  git config --global user.name  "git-mime test suite"

  if [ x${GITEXPORT_REBUILD_FIXTURE+set} = xset ]; then
    git init -q checkout
    cd checkout
    git am -q --whitespace=nowarn --committer-date-is-author-date $TESTDIR/seed.patch
    git bundle create $TESTDIR/seed.bundle master
  fi

  git init -q checkout
  cd checkout
  git fetch -q -u $TESTDIR/seed.bundle master:master
) || {
  printf "$0 setup failed, aborting." >&2
  exit 11
}

function filter
{
  sed -n '0,/^diff --git /p'
}

