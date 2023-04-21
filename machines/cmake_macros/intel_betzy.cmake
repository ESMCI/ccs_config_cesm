set(PIO_FILESYSTEM_HINTS "lustre")

set(NETCDF_C_PATH	$ENV{EBROOTNETCDF})
set(NETCDF_FORTRAN_PATH $ENV{EBROOTNETCDFMINFORTRAN})
set(PNETCDF_PATH	$ENV{PNETCDF})

if (COMP_WAV STREQUAL ww3dev)
  if (MPILIB STREQUAL openmpi)
     string(APPEND SLIBS " -L/cluster/software/ParMETIS/4.0.3-iompi-2021b/lib -l:libparmetis.a -lmetis")
  endif()
endif() 
