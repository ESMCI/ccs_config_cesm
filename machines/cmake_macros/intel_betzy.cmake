if (MPILIB STREQUAL impi)
 set(MPICC "mpiicc")
 set(MPICXX "mpiicpc")
 set(MPIFC "mpiifort")
endif()


set(SCC "icc")
set(SCXX "icpc")
set(SFC "ifort")

set(PIO_FILESYSTEM_HINTS "lustre")

set(NETCDF_C_PATH	$ENV{EBROOTNETCDF})
set(NETCDF_FORTRAN_PATH $ENV{EBROOTNETCDFMINFORTRAN})
set(NETCDF		$ENV{EBROOTNETCDFMINFORTRAN})
set(NETCDF_PATH		$ENV{EBROOTNETCDF})
set(PNETCDF_PATH	$ENV{PNETCDF})

if (COMP_NAME STREQUAL blom)
   string(APPEND FFLAGS FC_AUTO_R8)
endif()

string(APPEND SLIBS "-L/cluster/home/mvertens/ParMETIS/4.0.3-iompi  -lparmetis -lmetis")

