mkdir -p output
id=$(docker create numba_rocm_rocblas:latest)
basepath=/root/rocBLAS/build/library-build/src/
docker cp $id:$basepath/libTensile.so output/libTensile.so
docker cp $id:$basepath/librocblas-hcc.so.0.2.0.0 output/librocblas-hcc.so
docker rm -v $id
