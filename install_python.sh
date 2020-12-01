#!/bin/bash
# Install some tools
cd /

# OPENSSL
wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz
tar xf openssl-1.1.1d.tar.gz  
pushd openssl-1.1.1d
./config shared 
make -j && make install -j
popd

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

