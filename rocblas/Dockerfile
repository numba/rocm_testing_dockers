# Base the image on the numba_rocm_base image
FROM numba_rocm_base:latest

# Get Miniconda2
RUN wget -q https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda2.sh
RUN bash ./miniconda2.sh -b
ENV OLDPATH "${PATH}"
ENV PATH "/root/miniconda2/bin:${PATH}"
# pyYAML needed for Tensile configuration
RUN conda install pyyaml --yes

# Build rocblas
RUN git clone https://github.com/RadeonOpenCompute/rocBLAS.git
ARG ROCBLAS_SHA
RUN cd rocBLAS && git fetch
RUN cd rocBLAS && git checkout "${ROCBLAS_SHA}"
RUN cd rocBLAS  && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_LIBRARY=ON -DBUILD_SHARED_LIBS=ON  -DBUILD_CLIENTS=OFF -DBUILD_CLIENTS_SAMPLES=OFF  -DBUILD_CLIENTS_TESTS=OFF -DBUILD_WITH_TENSILE=ON  -DHIP_ROOT=/opt/rocm/hip .. && make

# Output at
# /root/rocBLAS/build/library-build/src
# libTensile.so        librocblas-hcc.so.0.0.2.0
