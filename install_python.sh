#!/bin/bash
# Install some tools
yum install -y wget.x86_64
yum install -y zlib zlib-devel zlib-static
yum install -y bzip2-devel bzip2-libs
yum install -y tkinter tk-devel
yum install -y xz-devel xz-libs xz-lzma-compat
yum install -y hdf5 hdf5-devel hdf5-static
cd /

# OPENSSL
wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz
tar xf openssl-1.1.1d.tar.gz  
cd openssl-1.1.1d
./config shared 
make -j && make install -j
cd /


#PYTHON
git clone https://github.com/python/cpython python_build
pushd python_build


git checkout v3.7.7
./configure --enable-optimizations --enable-shared --prefix=/opt/py37
make -j build_all && make -j install


git checkout v3.8.5

cat <<EOT >> Modules/Setup
SSL=/usr/local/
_ssl _ssl.c \
        -DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \
	        -L$(SSL)/lib64 -lssl -lcrypto
EOT

./configure --enable-optimizations --enable-shared --with-openssl=/usr/local --prefix=/opt/py38
make -j build_all && make -j install
popd

