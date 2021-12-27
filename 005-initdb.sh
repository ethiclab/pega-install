#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "005 - INITDB"
export CONNECTION="$1"
ssh $CONNECTION 'psql' < init.sql
ssh $CONNECTION 'psql pegadb' < init2.sql
