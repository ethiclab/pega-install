#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "007 - INSTALL NTP"
export CONNECTION="$1"
ssh $CONNECTION 'dnf -y install chrony'
ssh $CONNECTION 'systemctl start chronyd'
ssh $CONNECTION 'systemctl status chronyd'
ssh $CONNECTION 'systemctl enable chronyd'
