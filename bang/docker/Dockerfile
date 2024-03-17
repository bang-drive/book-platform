FROM ubuntu:24.04
RUN apt update -y

# sudo
RUN apt install -y sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# supertuxkart: https://github.com/supertuxkart/stk-code/blob/1.4/INSTALL.md
RUN apt install -y \
    build-essential \
    cmake \
    git \
    libbluetooth-dev \
    libcurl4-openssl-dev \
    libenet-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libjpeg-dev \
    libmbedtls-dev \
    libogg-dev \
    libopenal-dev \
    libpng-dev \
    libsdl2-dev \
    libsqlite3-dev \
    libssl-dev \
    libvorbis-dev \
    pkg-config \
    zlib1g-dev

# shaderc: https://github.com/google/shaderc/blob/main/Dockerfile
RUN apt install -y ninja-build python3-pip python-is-python3
RUN cd /root && git clone --depth=1 https://github.com/google/shaderc && \
    cd shaderc && ./utils/git-sync-deps && \
    mkdir build && cd build && \
    cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    ninja install && \
    cd /root && rm -rf shaderc

RUN apt install -y \
    # bang deps
    libevent-dev \
    libhiredis-dev \
    nlohmann-json3-dev \
    # other tools
    locate \
    tree \
    vim

# TODO(xiaoxq): Revisit this after ubuntu 24.04 is released.
RUN deluser ubuntu
