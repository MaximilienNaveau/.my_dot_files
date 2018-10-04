#!/bin/bash

export PYTHONPATH=/usr/lib/python3/dist-packages
/usr/bin/blender $@ --python "/home/mnaveau/Software/openrobots/lib/python2.7/site-packages/gepetto/blender/gepettoimport.py"
