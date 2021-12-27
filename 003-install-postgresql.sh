#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "003 - INSTALL POSTGRESQL"
export CONNECTION="$1"
ssh $CONNECTION 'sudo firewall-cmd --permanent --add-port=5432/tcp'
ssh $CONNECTION 'sudo firewall-cmd --reload'
ssh $CONNECTION 'sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm'
ssh $CONNECTION 'sudo dnf -qy module disable postgresql'
ssh $CONNECTION 'sudo dnf install -y postgresql11-server'
ssh $CONNECTION 'sudo /usr/pgsql-11/bin/postgresql-11-setup initdb'
./skeleton.py -t pg_hba.conf.template > pg_hba.conf
scp pg_hba.conf $CONNECTION:/home/postgres/11/data
scp postgresql.conf $CONNECTION:/home/postgres/11/data
ssh $CONNECTION 'sudo systemctl enable postgresql-11'
ssh $CONNECTION 'sudo systemctl start postgresql-11'
echo "Create password for user postgres"
ssh $CONNECTION 'sudo passwd postgres'
