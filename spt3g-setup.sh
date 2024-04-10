#!/usr/bin/env bash
# Based on readme in spt3g_software repo

cd spt3g_software/
mkdir -p build
cd build
cmake ..
make
