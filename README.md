# Dockers for testing numba HSA support and pyroclib on ROCm platforms

## Basic instructions

Use `make all` to build all dockers.

Use `make test` to run all the tests.

Use `make test_numba` run the [numba HSA](https://github.com/numba/numba/pull/2293) tests inside the docker ("numba_rocm_numba").

Use `make test_pyroclib` run the [pyroclib](https://github.com/numba/pyroclib) tests inside the docker ("numba_rocm_pyroclib").

## Organization

"./base" contains the base image "numba_rocm_base" that installs the ROCm packages and cmake-3.5.

"./numba" contains the numba testing image "numba_rocm_numba" that builds and installs the numba package and it's dependencies: LLVM and [libHLC](https://github.com/numba/libHLC).

"./rocblas" and "./rocfft" contains the "numba_rocm_rocblas" and "numba_rocm_rocfft" images.  They are both based on "numba_rocm_base" image.  They produces shared library builds of rocBLAS and rocFFT.

"./pyroclib" contains the "numba_rocm_pyroclib" image that builds and installs the pyroclib, the python wrapper for rocBLAS and rocFFT.  This image is based on "numba_rocm_numba".  It gets the rocBLAS and rocFFT prebuilt binaries from the "numba_rocm_rocblas" and "nubma_rocm_rocfft" images.

All these directories have a "build.sh" script that builds the images.  The exact commit for each source component is specified in these scripts.
