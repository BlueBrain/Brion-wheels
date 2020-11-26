#!/bin/bash
# Install some tools
yum install -y wget.x86_64
# Install basic python packages
yum install -y rh-python36.x86_64
yum install -y rh-python36-scldevel.x86_64
yum install -y rh-python36-numpy.x86_64
# Enable python installation
source /opt/rh/rh-python36/enable
# Install needed packages from pip
pip install pip --upgrade
pip install cmake
pip install auditwheel # Will install wheel alongside
# Install extra libraries
yum install -y zlib.x86_64 zlib-devel.x86_64 zlib-static.x86_64
yum install -y hdf5.x86_64 hdf5-devel.x86_64 hdf5-static.x86_64
# Install boost 1.70
mkdir /boostinstall && cd /boostinstall
wget https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.gz
tar -xzf boost_1_70_0.tar.gz
cd ./boost_1_70_0
./bootstrap.sh --with-python=/opt/rh/rh-python36/root/usr/bin/python3.6m
# Fix python location for boost compilation
sed -i '/^    using python/c\    using python : 3.6 : /opt/rh/rh-python36/root/usr : /opt/rh/rh-python36/root/usr/include/python3.6m ;' project-config.jam
./b2 install -j 12
