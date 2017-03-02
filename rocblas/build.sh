ROCBLAS_SHA="6cc5f5fdb7cae0c8411469a666b03d24605327fd"
docker build --build-arg ROCBLAS_SHA="${ROCBLAS_SHA}" -t numba_rocm_rocblas .

