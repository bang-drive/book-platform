#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")

IMAGE="xiangquan/stk-assets:0.1"
docker build --network host -t ${IMAGE} $@ .
