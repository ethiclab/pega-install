#!/usr/bin/env bash
function usage {
  >&2 echo usage $0 "<ssh server>"
  exit 1
}
[[ -z "$1" ]] && usage
echo "001 - CREATE USER PEGAUSER"
export CONNECTION="pegadmin@$1"
export CONNECTION2="pegauser@$1"
ssh $CONNECTION 'sudo groupadd -f -g 9001 pegauser'
ssh $CONNECTION 'sudo getent passwd pegauser || sudo useradd -r -u 9001 -g pegauser pegauser'
ssh $CONNECTION '[[ -d /home/pegauser ]] || sudo mkdir /home/pegauser'
ssh $CONNECTION 'sudo cp -R ~/.ssh /home/pegauser'
ssh $CONNECTION 'sudo chown -R pegauser:pegauser /home/pegauser'

# Check if the user is a sudoers without password
ssh $CONNECTION2 'sudo -n ls -latrh'
retval=$?
if [[ $retval != "0" ]]; then
  ssh $CONNECTION 'echo "pegauser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
  ssh $CONNECTION2 'sudo -n ls -latrh'
fi
