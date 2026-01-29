#!/bin/bash

set -e

WDIR=$PWD

cd ~

arch=$(uname -m)

if [ "$arch" = "aarch64" ] && [ -d /sys/firmware/acpi ]; then
    arch="sbsa"
fi

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/$arch/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt install -y libcudnn9-dev-cuda-12

git clone https://github.com/lightvector/KataGo.git
cd KataGo/cpp
wget https://media.katagotraining.org/uploaded/networks/models/kata1/kata1-b28c512nbt-s12192929536-d5655876072.bin.gz -O network.bin.gz
cp $WDIR/analysis.cfg .
cmake . -DUSE_BACKEND=CUDA
make -j
