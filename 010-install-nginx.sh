#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "010 - INSTALL NGINX"
export CONNECTION="$1"
./skeleton.py -t context.xml.template > context.xml
ssh $CONNECTION 'sudo dnf install -y nginx'
ssh $CONNECTION 'sudo systemctl enable --now nginx.service'
ssh $CONNECTION 'sudo systemctl status nginx'
ssh $CONNECTION 'sudo firewall-cmd --add-service=http --permanent'
ssh $CONNECTION 'sudo firewall-cmd --add-service=https --permanent'
ssh $CONNECTION 'sudo firewall-cmd --reload'
./skeleton.py -t default.conf.template > default.conf
scp default.conf $CONNECTION:/tmp
ssh $CONNECTION 'sudo scp /tmp/default.conf /etc/nginx/conf.d/'
ssh $CONNECTION 'sudo systemctl restart nginx'
