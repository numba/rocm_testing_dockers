all: pyroclib.out

test: test_numba test_pyroclib

base.out: base/Dockerfile base/build.sh
	cd base && ./build.sh | tee ../$@

numba.out: base.out numba/Dockerfile numba/build.sh
	cd numba && ./build.sh | tee ../$@

rocblas.out: numba.out rocblas/Dockerfile rocblas/build.sh
	cd rocblas && ./build.sh | tee ../$@

rocfft.out: numba.out rocfft/Dockerfile rocfft/build.sh
	cd rocfft && ./build.sh | tee ../$@

pyroclib/roclib/libTensile.so pyroclib/roclib/librocblas-hcc.so: rocblas.out rocblas/getoutput.sh
	mkdir -p pyroclib/roclib
	cd rocblas && ./getoutput.sh
	cp rocblas/output/libTensile.so pyroclib/roclib/libTensile.so
	cp rocblas/output/librocblas-hcc.so pyroclib/roclib/librocblas-hcc.so

pyroclib/roclib/librocfft-hcc-d.so: rocfft/getoutput.sh rocfft.out
	cd rocfft && ./getoutput.sh
	cp rocfft/output/librocfft-hcc-d.so pyroclib/roclib/librocfft-hcc-d.so

pyroclib.out: pyroclib/roclib/libTensile.so pyroclib/roclib/librocblas-hcc.so pyroclib/roclib/librocfft-hcc-d.so pyroclib/Dockerfile pyroclib/build.sh
	cd pyroclib && ./build.sh | tee ../$@

test_numba: numba.out
	cd numba && ./runtests.sh

test_pyroclib: pyroclib.out
	cd pyroclib && ./runtests.sh

clean:
	rm -f base.out
	rm -f numba.out
	rm -f rocblas.out
	rm -f rocfft.out
	rm -f pyroclib.out
	rm -rf rocblas/output
	rm -rf rocfft/output
	rm -rf pyroclib/roclib
