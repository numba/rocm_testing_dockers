ROCBLAS_SHA="e4cb0a5b6953459d8056cb7214be563c4bdbb452"
docker build --build-arg ROCBLAS_SHA="${ROCBLAS_SHA}" -t numba_rocm_rocblas .

