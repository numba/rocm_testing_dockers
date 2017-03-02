# Base the image on the numba_rocm_base image
FROM numba_rocm_base:latest

# get llvm mainline
ARG LLVM_SHA
RUN git clone -v https://github.com/llvm-mirror/llvm.git
RUN cd ~/llvm && git checkout "${LLVM_SHA}"

ARG LLD_SHA
RUN cd ~/llvm/tools && git clone http://llvm.org/git/lld.git
RUN cd ~/llvm/tools/lld && git checkout "${LLD_SHA}"

RUN echo `which g++`
RUN cd ~/llvm/ && mkdir build && cd ~/llvm/build && cmake .. -DCMAKE_CXX_COMPILER=/usr/bin/g++ -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" && make -j 8

RUN wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh
RUN bash ./miniconda3.sh -b
ENV OLDPATH "${PATH}"
ENV PATH "/root/miniconda3/bin:${PATH}"
RUN conda install python=3.5 --yes
RUN conda install conda-build --yes

# Setup LIBHLC and create a conda package locally
ARG LIBHLC_SHA
RUN git clone https://github.com/sklam/libHLC.git
RUN cd ~/libHLC && git checkout "${LIBHLC_SHA}"
RUN LLVM_MAINLINE=/root/llvm/build conda build libHLC/condarecipe --output-folder libHLC/condarecipe/output
RUN conda install -c ./libHLC/condarecipe/output libhlc --yes

# Get env for numba
RUN conda install -y -c numba llvmlite numpy

# Get Numba
ARG NUMBA_SHA
RUN git clone https://github.com/sklam/numba.git
RUN cd numba && git checkout ${NUMBA_SHA} && python setup.py build_ext --inplace && python setup.py install

# Setup env for tests
ENV HSAILBIN "/root/llvm/build/bin"
ENV ROC_ROOT "/opt/rocm"
ENV NUMBA_HSA_DRIVER  "${ROC_ROOT}/lib/libhsa-runtime64.so"
# RUN cd numba && python runtests.py -vb numba.hsa.tests
