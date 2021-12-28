#!/usr/bin/env bash
VERSION=1.20
yum update
dnf -qy install unzip
dnf -qy module install python27
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
