#!/bin/bash
source /opt/rh/rh-python36/enable
auditwheel repair /brioncompile/Brion/dist/*.whl -w out
