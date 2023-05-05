#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "007 - INSTALL NTP"
export CONNECTION="$1"
ssh $CONNECTION 'sudo dnf -y install chrony'
ssh $CONNECTION 'sudo systemctl start chronyd'
ssh $CONNECTION 'sudo systemctl status chronyd'
ssh $CONNECTION 'sudo systemctl enable chronyd'
