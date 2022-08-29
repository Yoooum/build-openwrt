#!/bin/bash
export OP_BUILD_PATH=$PWD
git clone -b "openwrt-21.02" --single-branch https://github.com/immortalwrt/immortalwrt

cd ${OP_BUILD_PATH}/immortalwrt
./scripts/feeds update -a && ./scripts/feeds install -a
rm -rf ./tmp && rm -rf .config
cp ${OP_BUILD_PATH}/newifi_d2.config ${OP_BUILD_PATH}/immortalwrt/.config
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
make defconfig
make download -j$(nproc) V=s
