#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
export CONNECTION="$1"
echo "Copy ssh id to remote machine"
ssh-copy-id $CONNECTION
