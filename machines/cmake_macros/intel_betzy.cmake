set(PIO_FILESYSTEM_HINTS "lustre")

set(NETCDF_C_PATH	$ENV{EBROOTNETCDF})
set(NETCDF_FORTRAN_PATH $ENV{EBROOTNETCDFMINFORTRAN})
set(PNETCDF_PATH	$ENV{PNETCDF})

if (COMP_WAV STREQUAL ww3dev)
  if (MPILIB STREQUAL openmpi)
     string(APPEND SLIBS "  -l:libparmetis.a -lmetis ")
  endif()
endif() 

if (MPILIB STREQUAL impi)
 set(MPICC "mpiicc")
 set(MPICXX "mpiicpc")
 set(MPIFC "mpiifort")
endif()