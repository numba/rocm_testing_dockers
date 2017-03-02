ROCFFT_SHA="8eead49dc4fbd9bb50387824e4f86d0910b47455"
docker build --build-arg ROCFFT_SHA="${ROCFFT_SHA}" -t numba_rocm_rocfft .

