set(CMAKE_OPTS "-DCMAKE_SYSTEM_NAME=Catamount")
string(APPEND CPPDEFS " -DLINUX")
if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_NANOTIME -DBIT64 -DHAVE_VPRINTF -DHAVE_BACKTRACE -DHAVE_SLASHPROC -DHAVE_COMM_F2C -DHAVE_TIMES -DHAVE_GETTIMEOFDAY")
endif()
set(MPICC "cc")
set(MPICXX "CC")
set(MPIFC "ftn")
set(SCC "cc")
set(SCXX "CC")
set(SFC "ftn")
set(NETCDF_PATH "$ENV{NETCDF_DIR}")
set(PIO_FILESYSTEM_HINTS "lustre")
set(PNETCDF_PATH "$ENV{PARALLEL_NETCDF_DIR}")
