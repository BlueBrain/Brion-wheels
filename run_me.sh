#!/bin/bash
docker build  -t ppx86:wb . 
docker run  -v `pwd`:/out -ti ppx86:wb
