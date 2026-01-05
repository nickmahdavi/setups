#!/bin/bash

set -e

WDIR=$PWD

cd ~

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/$(uname -m)/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt install -y libcudnn9-dev-cuda-12

git clone https://github.com/lightvector/KataGo.git
cd KataGo/cpp
wget https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-b28c512nbt-adam-s11165M-d5387M.bin.gz -o network.bin.gz
cp $PWD/analysis.cfg .
cmake . -DUSE_BACKEND=CUDA
make -j
