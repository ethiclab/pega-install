#!/usr/bin/env bash
yum update
dnf -qy install unzip
dnf -qy module install python27
ln -s /usr/bin/python2 /usr/bin/python
curl -O -L https://github.com/ethiclab/pega-install/archive/refs/1.0.zip
unzip 1.0.zip
cd pega-install-1.0
source install.sh
