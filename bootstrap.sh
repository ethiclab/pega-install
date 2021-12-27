#!/usr/bin/env bash
yum update
dnf -qy install unzip
dnf -qy module install python27
ln -s /usr/bin/python2 /usr/bin/python
python2 -m pip install --user Cheetah
curl -O -L https://github.com/ethiclab/pega-install/archive/refs/tags/1.1.zip
unzip 1.1.zip
cd pega-install-1.1
source install.sh
pega_install
