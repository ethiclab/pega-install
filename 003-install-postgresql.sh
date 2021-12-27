#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
export CONNECTION="$1"
ssh $CONNECTION 'firewall-cmd --permanent --add-port=5432/tcp'
ssh $CONNECTION 'firewall-cmd --reload'
ssh $CONNECTION 'sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm'
ssh $CONNECTION 'sudo dnf -qy module disable postgresql'
ssh $CONNECTION 'sudo dnf install -y postgresql11-server'
ssh $CONNECTION 'sudo /usr/pgsql-11/bin/postgresql-11-setup initdb'
ssh $CONNECTION 'sudo systemctl enable postgresql-11'
ssh $CONNECTION 'sudo systemctl start postgresql-11'
ssh $CONNECTION 'sudo passwd postgres'
