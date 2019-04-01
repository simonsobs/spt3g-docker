#!/usr/bin/env bash

git clone https://github.com/CMB-S4/spt3g_software.git
cd spt3g_software
git checkout 36d0c3d81d550c385b533f8901be053e455fe17e
mkdir -p build
cd build
cmake .. -DPYTHON_EXECUTABLE=`which python3`
make
