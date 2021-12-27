#/usr/bin/env bash

source config.properties

function pega_install {

for srv in ${HOST_NAME_ARRAY[@]}; do
  ./ssh-config -l -H ${srv}
  local retval=$?
  return 1
done

for srv in ${HOST_NAME_ARRAY[@]}; do
  ssh-copy-id root@${srv} || return 1
done

for srv in ${HOST_NAME_ARRAY[@]}; do
  ./001-create-user-pegauser.sh ${srv} || return 1
done

for srv in ${HOST_NAME_ARRAY[@]}; do
  ./002-install-sdkman.sh ${srv} || return 1
done

./003-install-postgresql.sh ${HOST_NAME_DATABASE} || return 1

./004-enable-ssh-for-postgres-user.sh ${HOST_NAME_DATABASE} || return 1

./005-initdb.sh ${HOST_NAME_DATABASE} || return 1
./006-initdb.sh ${HOST_NAME_DATABASE} || return 1

for srv in ${HOST_NAME_ARRAY[@]}; do
  ./007-install-ntp.sh ${srv} || return 1
done

for srv in ${HOST_NAME_APP_ARRAY[@]}; do
  ./008-install-tomcat.sh ${srv} || return 1
done

for srv in ${HOST_NAME_APP_ARRAY[@]}; do
  ./009-deploy-pega.sh ${srv} || return 1
done

return 0
}
