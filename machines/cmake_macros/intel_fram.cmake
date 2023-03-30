
set(MPICC "mpiicc")

set(MPICXX "mpiicpc")

set(MPIFC "mpiifort")

set(SCC "icc")
set(SCXX "icpc")
set(SFC "ifort")

set(MPI_LIB_NAME "impi")

set(NETCDF_C_PATH $ENV{EBROOTNETCDF})

set(NETCDF_FORTRAN_PATH $ENV{EBROOTNETCDFMINFORTRAN})

#set(PNETCDF_PATH $ENV{PNETCDF})

set(ESMF_LIBDR $ENV{EBROOTESMF})

set(PIO_FILESYSTEM_HINTS "lustre")

if (MPILIB STREQUAL impi)
	string(APPEND SLIBS " -mkl=cluster  -lnetcdff -lnetcdf")
endif()


string(APPEND FFLAGS " -O2 -xCORE-AVX2 -warn nointerfaces ")
