# Base on the numba_rocm_numba image
FROM numba_rocm_numba

# Get pyroclib
RUN git clone https://github.com/numba/pyroclib
ARG PYROCLIB_SHA
WORKDIR pyroclib
RUN git fetch
RUN git checkout "${PYROCLIB_SHA}"

# Setup environemnt
ADD roclib /root/roclib
ENV LD_LIBRARY_PATH "/root/roclib:$LD_LIBRARY_PATH"

# Testing
# LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libc++.so python -m pyroclib.tests.test_blas
