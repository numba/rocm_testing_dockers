# Base the image on the numba_rocm_base image
FROM numba_rocm_base:latest

# Get Miniconda2
RUN wget -q https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda2.sh
RUN bash ./miniconda2.sh -b
ENV OLDPATH "${PATH}"
ENV PATH "/root/miniconda2/bin:${PATH}"
# RUN conda install pyyaml --yes

# Build rocblas
ARG ROCFFT_SHA
RUN git clone https://github.com/RadeonOpenCompute/rocFFT.git
RUN cd rocFFT && git checkout "${ROCFFT_SHA}"
RUN cd rocFFT && mkdir build && cd build && cmake -DBUILD_LIBRARY=ON  -DBUILD_SHARED_LIBS=ON  -DCMAKE_BUILD_TYPE=DEBUG  -DHIP_ROOT=/opt/rocm/hip  .. && make VERBOSE=1

# /root/rocFFT/build/library-build/src
# librocfft-hcc-d.so.0.0.2.0
