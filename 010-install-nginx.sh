#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "010 - INSTALL NGINX"
export CONNECTION="$1"
./skeleton.py -t context.xml.template > context.xml
ssh $CONNECTION 'dnf install -y nginx'
ssh $CONNECTION 'systemctl enable --now nginx.service'
ssh $CONNECTION 'systemctl status nginx'
ssh $CONNECTION 'firewall-cmd --add-service=http --permanent'
ssh $CONNECTION 'firewall-cmd --add-service=https --permanent'
ssh $CONNECTION 'firewall-cmd --reload'
./skeleton.py -t default.conf.template > default.conf
scp default.conf $CONNECTION:/etc/nginx/conf.d/
ssh $CONNECTION 'systemctl restart nginx'
