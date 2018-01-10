from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

setup(
    # ext_modules = cythonize("cython_nbody2.pyx")
    # ext_modules = cythonize([Extension(name="cython_nbody2", sources=["cython_nbody2.pyx"], language='c', extra_compile_args=["-O3", "-march=native"])])
    ext_modules = cythonize([Extension(name="cython_nbody2", sources=["cython_nbody2.pyx"], language='c', extra_compile_args=["-Ofast"])])
)
