docker build \
    --build-arg NUMBA_SHA="072fc50" \
    --build-arg LLVM_SHA="d6c57ac" \
    --build-arg LLD_SHA="1d3cc9e" \
    --build-arg LIBHLC_SHA="wip/cmake_gtest" \
    -t numba_rocm_numba .
