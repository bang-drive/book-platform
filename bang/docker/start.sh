#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")/../..
source bang/docker/utils.sh

ASSETS_IMAGE="xiangquan/stk-assets:0.1"
ASSETS_CONTAINER="stk-assets-${USER}"
DEV_IMAGE="xiangquan/bang-platform:0.1"
DEV_CONTAINER="bang-platform-${USER}"
REDIS_IMAGE="redis:7.2"
REDIS_CONTAINER="redis-${USER}"

sudo chmod 777 /var/run/docker.sock

if ! reuse "${ASSETS_CONTAINER}"; then
    docker run -d --name "${ASSETS_CONTAINER}" "${ASSETS_IMAGE}" sleep 99999999
fi

if ! reuse "${REDIS_CONTAINER}"; then
    docker run -d --name "${REDIS_CONTAINER}" --restart=always -p 6379:6379 "${REDIS_IMAGE}"
fi

if [ "$1" == "new" ]; then
    docker rm -f "${DEV_CONTAINER}" 2> /dev/null
fi
if ! reuse "${DEV_CONTAINER}"; then
    WORKDIR=$(pwd)
    docker run -d -it --privileged \
        --name "${DEV_CONTAINER}" \
        --hostname "${DEV_CONTAINER}" \
        --network=host \
        --add-host "${DEV_CONTAINER}:127.0.0.1" \
        -e USER=${USER} \
        -e GROUP=$(id -g -n) \
        -e HOST_UID=$(id -u) \
        -e HOST_GID=$(id -g) \
        -e HOST_WORKDIR="${WORKDIR}" \
        -e DISPLAY="${DISPLAY}" \
        -e XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR}" \
        -v "${XDG_RUNTIME_DIR}:${XDG_RUNTIME_DIR}" \
        -v "${WORKDIR}:/work/platform" \
        -v "${WORKDIR}:${WORKDIR}" \
        --volumes-from "${ASSETS_CONTAINER}" \
        -w "/work/platform" \
        ${DEV_IMAGE} \
        bash -c -- '
            addgroup --gid ${HOST_GID} ${USER}
            adduser --disabled-password --force-badname --gecos "" ${USER} --uid ${HOST_UID} --gid ${HOST_GID}
            chown ${USER}:${GROUP} /work
            usermod -aG sudo ${USER}

            touch /tmp/READY
            bash
        '
    while ! docker exec ${DEV_CONTAINER} ls /tmp/READY >/dev/null 2>&1; do
        sleep 0.1
    done
fi

docker exec -it -u ${USER} ${DEV_CONTAINER} bash
