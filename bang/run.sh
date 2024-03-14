#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")/..

BIN="$(pwd)/cmake_build/bin/supertuxkart"

if [ ! -f "${BIN}" ]; then
    ./bang/build.sh
fi

# https://manpages.debian.org/testing/supertuxkart/supertuxkart.1
# scotland: Nessie's Pond
# snowmountain: Northern Resort
"${BIN}" \
    --laps=5 \
    --no-start-screen \
    --numkarts=16 \
    --race-now \
    --screensize=1920x1080 \
    --track="scotland"

# TODO: --ai=a,b,c to only use Yolo-compatible karts
# TODO: Headless release mode with --no-graphics
