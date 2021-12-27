#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
export CONNECTION="$1"
ssh pegadb cp .bashrc .pgsql_profile

ssh root@pega1 chown -R pegauser:pegauser /home/Software
ssh pega1
curl -O -L https://jdbc.postgresql.org/download/postgresql-42.3.1.jar
scp postgresql-42.3.1.jar pega1:~
ln -s .bashrc .bash_profile
. ~/bash_profile
cd /home/Software/116967_Pega8.53/scripts
# modify setupDatabase.properties
chmod +x *.sh
chmod +x bin/*
./install.sh
./skeleton.py -t config.properties
