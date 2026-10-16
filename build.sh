#!/usr/bin/env bash
set -euo pipefail
cd "$HOME/crdroid_f1"
export PATH="$HOME/toolchains/aosp-clang-r536225/bin:$PATH"
export ARCH=arm64 SUBARCH=arm64
ARGS=(O=out ARCH=arm64 SUBARCH=arm64 LLVM_IAS=1 CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
  HOSTCC=gcc HOSTCXX=g++ OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip
  OBJSIZE=llvm-size READELF=llvm-readelf CROSS_COMPILE=aarch64-linux-gnu-
  CROSS_COMPILE_ARM32=arm-linux-gnueabi- CLANG_TRIPLE=aarch64-linux-gnu-)
rm -rf out && mkdir out
make "${ARGS[@]}" vendor/xiaomi/mi845_defconfig
make "${ARGS[@]}" vendor/xiaomi/beryllium.config
make "${ARGS[@]}" vendor/xiaomi/xxksu-nm.config
make "${ARGS[@]}" -j"$(nproc)" 2>&1 | tee build.log
ls -l out/arch/arm64/boot/Image.gz-dtb
