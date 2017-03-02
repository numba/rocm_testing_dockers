mkdir -p output
id=$(docker create numba_rocm_rocfft:latest)
basepath=/root/rocFFT/build/library-build/src/
docker cp $id:$basepath/librocfft-hcc-d.so.0.0.2.0 output/librocfft-hcc-d.so
docker rm -v $id
