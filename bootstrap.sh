#!/usr/bin/env bash
function log_info {
  >&2 echo $@
}
log_info bootstrap version 2.7
function throw {
  >&2 echo $@
  exit 1
}
if [ "$EUID" -ne 0 ]
  then export SUDO=sudo
fi
VERSION=1.21
[[ ! $(which --version) ]] && throw which not found
[[ ! -x $(which yum) ]] && throw yum not found
[[ ! -x $(which dnf) ]] && throw dnf not found
$SUDO yum update -qy || throw error
$SUDO dnf -qy install unzip || throw error
$SUDO dnf -qy install zip || throw error
$SUDO dnf -qy module install python27 || throw error
$SUDO ln -f -s /usr/bin/python2 /usr/bin/python
python2 -m pip install --user Cheetah3
curl -O -L https://github.com/ethiclab/pega-install/archive/refs/tags/${VERSION}.zip
unzip ${VERSION}.zip
[[ ! -f "~/.ssh/id_rsa" ]] && ssh-keygen -f ~/.ssh/id_rsa -q
[[ ! -f "~/.ssh/config" ]] && touch ~/.ssh/config
cd pega-install-${VERSION}
echo ""
echo ""
echo "Almost done!"
echo ""
echo "    cd pega-install-${VERSION}"
echo "    # configure config.json accordingly and then issue the following command:"
echo ""
echo "    source install.sh"
echo ""
echo "then, start installation with command:"
echo ""
echo "    pega_install"
