#!/usr/bin/env bash

./skeleton.py -t config.properties.template > config.properties

source config.properties

function pega_install {
#for i in "${!HOST_NAME_ARRAY[@]}"; do
#  ./ssh-config -s -H ${HOST_NAME_ARRAY[$i]} -o Hostname=${HOST_NAME_IPADDRESS_ARRAY[$i]} -f ~/.ssh/config
#done

#for srv in ${HOST_NAME_ARRAY[@]}; do
#  ssh-copy-id pegadmin@${srv} || return 1
#done

#for srv in ${HOST_NAME_ARRAY[@]}; do
#  ./001-create-user-pegauser.sh ${srv} || return 1
#done

for srv in ${HOST_NAME_ARRAY[@]}; do
  ./002-install-sdkman.sh ${srv} || return 1
done

./003-install-postgresql.sh pegauser@${HOST_NAME_DATABASE} || return 1

./004-enable-ssh-for-postgres-user.sh ${HOST_NAME_DATABASE} || return 1

./005-initdb.sh postgres@${HOST_NAME_DATABASE} || return 1

./006-install-pega.sh pegauser@${HOST_NAME_DATABASE} || return 1

for srv in ${HOST_NAME_ARRAY[@]}; do
  ./007-install-ntp.sh pegauser@${srv} || return 1
done

for srv in ${HOST_NAME_APP_ARRAY[@]}; do
  ./008-install-tomcat.sh pegauser@${srv} || return 1
done

for srv in ${HOST_NAME_APP_ARRAY[@]}; do
  ./009-deploy-pega.sh pegauser@${srv} || return 1
  ./010-deploy-pega.sh pegauser@${srv} || return 1
done

return 0
}
