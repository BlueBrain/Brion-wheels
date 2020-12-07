#!/bin/bash
cd /Brion

mkdir /opt/dist

source /opt/rh/rh-python36/enable
pip install pip --upgrade
pip3.6 install cmake 

python_versions=( "/opt/rh/rh-python36/root/usr/" "/opt/py37" "/opt/py38")

for i in "${python_versions[@]}"
do : 
  printf '=%.0s' {1..100}
  printf "\nworking on $i python wheel\n"
  printf '=%.0s' {1..100}
  printf "\n"
  export PYTHON_ROOT_PATH="$i"
  LD_LIBRARY_PATH=$PYTHON_ROOT_PATH/lib:$LD_LIBRARY_PATH  $PYTHON_ROOT_PATH/bin/pip3 install numpy wheel
  LD_LIBRARY_PATH=$PYTHON_ROOT_PATH/lib:$LD_LIBRARY_PATH  $PYTHON_ROOT_PATH/bin/python3 setup.py bdist_wheel
  auditwheel repair /Brion/dist/*.whl
  mv wheelhouse/*.whl /opt/dist
  rm dist build wheelhouse -rf
done
