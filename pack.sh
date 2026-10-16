#!/usr/bin/env bash
set -euo pipefail
cd "$HOME/crdroid_f1"
IMG=out/arch/arm64/boot/Image.gz-dtb
[ -f "$IMG" ] || { echo "no $IMG, build first"; exit 1; }
KVER=$(make -s kernelversion)
KSU_VER=$(grep -o -E 'KSU_VERSION=[0-9]+' KernelSU/kernel/Makefile | head -1 | cut -d= -f2)
STAMP=$(date -r "$IMG" +%H%M-%d%m%Y)
NAME="CrDroid-A15-${KVER}-xxksu-${KSU_VER}-NM-${STAMP}.zip"
cp "$IMG" ak3/Image.gz-dtb
rm -f "Crdroid stock perf"*.zip
(cd ak3 && zip -r9 "../$NAME" . -x '*.git*' -x '*Zone.Identifier')
ls -l "$NAME"
