#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "003 - INSTALL POSTGRESQL"
export CONNECTION="$1"
ssh $CONNECTION 'firewall-cmd --permanent --add-port=5432/tcp'
ssh $CONNECTION 'firewall-cmd --reload'
ssh $CONNECTION 'dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm'
ssh $CONNECTION 'dnf -qy module disable postgresql'
ssh $CONNECTION 'dnf install -y postgresql11-server'
ssh $CONNECTION '/usr/pgsql-11/bin/postgresql-11-setup initdb'
./skeleton.py -t pg_hba.conf.template > pg_hba.conf
scp pg_hba.conf $CONNECTION:/var/lib/pgsql/11/data
scp postgresql.conf $CONNECTION:/var/lib/pgsql/11/data
ssh $CONNECTION 'systemctl enable postgresql-11'
ssh $CONNECTION 'systemctl start postgresql-11'
echo "Create password for user postgres"
ssh $CONNECTION 'passwd postgres'
