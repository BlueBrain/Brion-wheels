#!/bin/bash
# Install some tools
# Install basic python pnd system ackages
yum install -y wget.x86_64
yum install -y rh-python36.x86_64 rh-python36-scldevel.x86_64 rh-python36-numpy.x86_64
yum install -y zlib zlib-devel zlib-static
yum install -y bzip2-devel bzip2-libs
yum install -y tkinter tk-devel
yum install -y xz-devel xz-libs xz-lzma-compat
yum install -y hdf5 hdf5-devel hdf5-static

# Enable python installation
source /opt/rh/rh-python36/enable

# Install boost 1.70
mkdir /boostinstall && cd /boostinstall
wget https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.gz
tar -xzf boost_1_70_0.tar.gz
cd ./boost_1_70_0
./bootstrap.sh --with-python=/opt/rh/rh-python36/root/usr/bin/python3.6m
# Fix python location for boost compilation
sed -i '/^    using python/c\    using python : 3.6 : /opt/rh/rh-python36/root/usr : /opt/rh/rh-python36/root/usr/include/python3.6m ;' project-config.jam
./b2 install -j 12
