#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")/..

BIN="$(pwd)/cmake_build/bin/supertuxkart"

if [ ! -f "${BIN}" ]; then
    ./bang/build.sh
fi

# Avoid karts like gnu, sara_the_racer, xue.
ALLOWED_KARTS=(adiumy amanda emule beastie gavroche hexley kiki konqi nolok pidgin puffy sara_the_wizard suzanne tux wilber)
shuffled_karts=($(shuf -e "${ALLOWED_KARTS[@]}"))
num_karts=${#ALLOWED_KARTS[@]}

# https://manpages.debian.org/testing/supertuxkart/supertuxkart.1
# scotland: Nessie's Pond
# snowmountain: Northern Resort
"${BIN}" \
    --laps=10 \
    --no-start-screen \
    --disable-item-collection \
    --numkarts=$((num_karts + 1)) \
    --ai=$(IFS=,; echo "${shuffled_karts[*]}") \
    --screensize=1024x576 \
    --track="scotland"
