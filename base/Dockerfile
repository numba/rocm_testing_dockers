# Base the image on ubuntu
FROM ubuntu:14.04
# update
RUN lsb_release -a
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install wget -y

WORKDIR /root
# addin in ROCm repo
RUN wget -qO - http://packages.amd.com/rocm/apt/debian/rocm.gpg.key | apt-key add -
RUN /bin/bash -c 'echo deb [arch=amd64] http://packages.amd.com/rocm/apt/debian/ trusty main > /etc/apt/sources.list.d/rocm.list'
# get the dev packages
RUN apt-get update -y
RUN apt-get install rocm-dev -y
# install required packages
RUN apt-get install -y cmake libdwarf-dev libelf-dev llvm-dev ncurses-dev re2c perl git oprofile python software-properties-common python-software-properties curl fakeroot gdb valgrind g++
# print gcc version
RUN gcc -v

# get a CMake that is high enough version for llvm post this commit
# https://github.com/llvm-mirror/llvm/commit/37735dbc09b0877f5ece8fb2e47a008fa6abf7e0
RUN wget -q https://cmake.org/files/v3.5/cmake-3.5.2.tar.gz
RUN wget -q https://cmake.org/files/v3.5/cmake-3.5.2-SHA-256.txt
RUN wget -q https://cmake.org/files/v3.5/cmake-3.5.2-SHA-256.txt.asc
# use roundrobin key server (likely onioned)
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 34921684
RUN gpg --verify cmake-3.5.2-SHA-256.txt.asc
RUN sha256sum -c cmake-3.5.2-SHA-256.txt|grep "cmake-3.5.2.tar.gz: OK"
RUN tar -zxf cmake-3.5.2.tar.gz
RUN cd cmake-3.5.2 &&  mkdir build && cd ~/cmake-3.5.2/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=/usr/bin/g++  && make -j
# add cmake to path
ENV PATH "/root/cmake-3.5.2/build/bin:${PATH}"

# Get rocm 1.4
RUN apt-get install -y rocm=1.4.0
# Patch
ADD hip_vector_types.patch /root/hip_vector_types.patch
RUN patch /opt/rocm/hip/include/hip/hcc_detail/hip_vector_types.h /root/hip_vector_types.patch

# Get clang-3.5
RUN apt-get install -y clang-3.5
RUN update-alternatives --install /usr/bin/clang  clang  /usr/bin/clang-3.5 50 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-3.5
