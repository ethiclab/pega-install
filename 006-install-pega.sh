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
./skeleton.py -t pg_hba.conf.template > pg_hba.conf

scp setupDatabase.properties $CONNECTION:/tmp/116967_Pega8.53/scripts 
scp pg_hba.conf $CONNECTION:/home/postgres/11/data
scp postgresql.conf $CONNECTION:/home/postgres/11/data

ssh $CONNECTION 'nohup /tmp/116967_Pega8.53/scripts/install.sh &'
