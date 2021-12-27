#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "006 - INSTALL PEGA"
export CONNECTION="$1"
ssh $CONNECTION 'cp .bashrc .pgsql_profile'

scp postgresql-42.3.1.jar $CONNECTION:/tmp

./skeleton.py -t setupDatabase.properties.template > setupDatabase.properties

scp setupDatabase.properties $CONNECTION:/tmp/116967_Pega8.53/scripts 

ssh $CONNECTION 'nohup /tmp/116967_Pega8.53/scripts/install.sh &'
