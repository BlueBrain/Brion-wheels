#!/bin/bash
git clone https://github.com/Bluebrain/Brion.git
cd Brion
git submodule update --init --recursive
git apply ../cmake.patch
cd ..

docker build -t ppx86/wb . 
docker run  -v `pwd`:/tmp/ -ti ppx86/wb

printf '=%.0s' {1..100}
printf "\nWheels built:"
ls -l dist
