#!/bin/bash
pip3 install wheel numpy cmake 

mkdir /brioncompile && cd /brioncompile
#git clone https://github.com/BlueBrain/Brion.git
git clone https://github.com/NadirRoGue/Brion.git
cd Brion
git submodule update --init --recursive
python3 setup.py bdist_wheel

