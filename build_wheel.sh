#!/bin/bash

mkdir /brioncompile && cd /brioncompile
#git clone https://github.com/BlueBrain/Brion.git
git clone https://github.com/NadirRoGue/Brion.git
cd Brion
git submodule update --init --recursive
source /opt/rh/rh-python36/enable 
python setup.py bdist_wheel
auditwheel repair dist/*.whl -w /out

