#!/usr/bin/env bash
VERSION=1.12
yum update
dnf -qy install unzip
dnf -qy module install python27
ln -s /usr/bin/python2 /usr/bin/python
python2 -m pip install --user Cheetah
curl -O -L https://github.com/ethiclab/pega-install/archive/refs/tags/${VERSION}.zip
unzip ${VERSION}.zip
cd pega-install-${VERSION}
source install.sh
echo "Start installation with command: pega_install"
