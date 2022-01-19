#!/usr/bin/env bash
function log_info {
  >&2 echo $@
}
log_info bootstrap version 2.0
function throw {
  >&2 echo $@
  exit 1
}
VERSION=1.20
[[ ! -x $(which yum) ]] && throw yum not found
[[ ! -x $(which dnf) ]] && throw dnf not found
yum update -qy || throw error
dnf -qy install unzip || throw error
dnf -qy module install python27 || throw error
ln -f -s /usr/bin/python2 /usr/bin/python
python2 -m pip install --user Cheetah3
curl -O -L https://github.com/ethiclab/pega-install/archive/refs/tags/${VERSION}.zip
unzip ${VERSION}.zip
cd pega-install-${VERSION}
echo "Configure config.json accordingly and then do:"
echo ""
echo "    cd pega-install-${VERSION}"
echo "    source install.sh"
echo ""
echo "then, start installation with command:"
echo ""
echo "    pega_install"
