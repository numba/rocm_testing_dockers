docker run --privileged -e LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libc++.so -w /root/pyroclib \
    -ti numba_rocm_pyroclib:latest python -m unittest discover -v
