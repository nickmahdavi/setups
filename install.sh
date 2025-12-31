#!/bin/bash

set -e

WDIR=$PWD

sudo apt install -y nvidia-driver-580
git clone https://github.com/lightvector/KataGo.git
cd KataGo/cpp
wget https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-b28c512nbt-adam-s11165M-d5387M.bin.gz -o network.bin.gz
cp $PWD/analysis.cfg .
cmake . -DUSE_BACKEND=OPENCL
make -j
