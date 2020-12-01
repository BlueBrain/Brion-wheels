#!/bin/bash
git clone https://github.com/Bluebrain/Brion.git
pushd Brion
git submodule update --init --recursive
#TODO: merge it to Brion
git apply ../cmake.patch
popd

docker build -t local/wheel_builder .
docker run  -v `pwd`:/tmp/ -ti local/wheel_builder

printf '=%.0s' {1..100}
printf "\nWheels built:"
ls dist
