#!/usr/bin/env zsh
# vim: ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

set -o extended_glob
set -o no_unset

function complain # {{{
{
  print ${@[2,-1]} >&2
  exit $1
} # }}}

function query-git # {{{
{
  git show --no-patch --format=$1 "${@[2,-1]}"
} # }}}

declare -r dashless=${${0##*/}/(#s)git-/git }
declare output=
declare -a gdtopts; gdtopts=(--stat=72 --summary)
declare -a o_headers
declare -i want_stat=1 want_summary=1

while [[ $# -gt 0 && $1 == -* ]]; do # options {{{
  case $1 in
  --add-header=*)
                o_headers+=(${1#--add-header=})
  ;;
  --add-header) shift; o_headers+=($1)
  ;;
  --output=*)   output=${1#--output=}
  ;;
  --output)     shift; output=$1
  ;;
  --numstat)    want_stat=1
                gdtopts=(${gdtopts##--dirstat*(#e)})
                gdtopts=(${gdtopts##--stat*(#e)})
                gdtopts=(${gdtopts##--shortstat(#e)})
                gdtopts+=($1)
  ;;
  --dirstat=*)  want_stat=1
                gdtopts=(${gdtopts##--stat*(#e)})
                gdtopts=(${gdtopts##--numstat(#e)})
                gdtopts=(${gdtopts##--shortstat(#e)})
                gdtopts+=($1)
  ;;
  --dirstat)    want_stat=1
                gdtopts=(${gdtopts##--stat*(#e)})
                gdtopts=(${gdtopts##--numstat(#e)})
                gdtopts=(${gdtopts##--shortstat(#e)})
                gdtopts+=($1)
  ;;
  --shortstat)  want_stat=1
                gdtopts=(${gdtopts##--stat*(#e)})
                gdtopts=(${gdtopts##--dirstat*(#e)})
                gdtopts=(${gdtopts##--numstat(#e)})
                gdtopts+=($1)
  ;;
  --stat=*)     want_stat=1
                gdtopts=(${gdtopts##--dirstat*(#e)})
                gdtopts=(${gdtopts##--numstat(#e)})
                gdtopts=(${gdtopts##--shortstat(#e)})
                gdtopts+=($1)
  ;;
  --stat)       want_stat=1
                gdtopts=(${gdtopts##--dirstat*(#e)})
                gdtopts=(${gdtopts##--numstat(#e)})
                gdtopts=(${gdtopts##--shortstat(#e)})
                gdtopts+=($1)
  ;;
  --no-stat)    want_stat=0
                gdtopts=(${gdtopts##--stat*(#e)})
                gdtopts=(${gdtopts##--dirstat*(#e)})
                gdtopts=(${gdtopts##--numstat(#e)})
                gdtopts=(${gdtopts##--shortstat(#e)})
  ;;
  --summary)    want_summary=1
                gdtopts+=($1)
  ;;
  --no-summary) want_summary=0
                gdtopts=(${gdtopts##--summary(#e)})
  ;;
  --?*)         complain 1 "fatal: unknown option $1"
  ;;
  --)           shift; break
  ;;
  esac
  shift
done # }}}

if (( $# != 1 )); then
  complain 1 "usage: $dashless [options] [--] <revision>"
fi

declare -r rhash="$(git rev-list -1 "$1" --)"

if [[ -z $rhash ]]; then
  exit 1
fi

if [[ -n $output ]]; then
  declare -r realout=${output:A}
  if [[ -e $realout ]]; then
    if ! [[ -f $realout && -w $realout && -w "$(dirname $realout)" ]]; then
      complain 1 "fatal: --output optarg is not a writable file"
    fi
  fi
  declare tmpout="$(mktemp "$realout.XXXXX.tmp")"
  trap '() { rm -f $1 }'" $tmpout" ZERR
  trap '() { mv $1 $2 }'" $tmpout $output" EXIT
  exec > $tmpout
fi

declare subjlabel='[PATCH]'
declare -i hassubjlabel=$(( 0 < ${#subjlabel} ))
declare -r hdrsfmt="\
From %H Mon Sep 17 00:00:00 2001
From: %an <%ae>
Date: %aD
Subject: %s
"

declare -a headers fromline
for hdr in "${(@)o_headers}"; do
  headers+=(--header "$hdr")
done
while read hdr val; do
  [[ -z $val ]] && continue
  case $hdr in
  From)
    fromline=(--header "From $val")
    continue
  ;;
  Subject:)
    val="${subjlabel:+$subjlabel }$val"
  ;;
  esac
  headers+=(--header "$hdr $val")
done < <(query-git "$hdrsfmt" $rhash)

declare body="$(query-git '%b' $rhash)"

(
  [[ -n $body ]] && print -f '%s\n' -- $body
  if (( want_stat || want_summary )); then
    print -- ---
  else
    print
  fi
  git diff-tree --root --no-commit-id "${(@)gdtopts}" --patch "$rhash"
) \
| mime-construct --output \
    "${(@)fromline}" \
    "${(@)headers}" \
    --file - \
| sed -e '
    # this needs to be `mime-construct --no-banner` or similar
    /^\(MIME-Version: 1.0\) (mime-construct.*/ {
      s//\1/
      p
      d
      :rest
        p
        n
        b rest
    }
  '
