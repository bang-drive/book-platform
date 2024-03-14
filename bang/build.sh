#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")/..

set -e

if [ "$1" == "new" ]; then
    rm -rf cmake_build
fi

if [ ! -f "cmake_build/Makefile" ]; then
    mkdir -p cmake_build
    cd cmake_build
    cmake .. -DBUILD_RECORDER=off -DCMAKE_BUILD_TYPE=Release
else
    cd cmake_build
fi

make -j$(nproc)
