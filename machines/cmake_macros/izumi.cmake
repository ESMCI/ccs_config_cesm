if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_NANOTIME -DBIT64 -DHAVE_VPRINTF -DHAVE_BACKTRACE -DHAVE_SLASHPROC -DHAVE_COMM_F2C -DHAVE_TIMES -DHAVE_GETTIMEOFDAY")
endif()
set(LAPACK_LIBDIR "/usr/lib64")
if (MPILIB STREQUAL mvapich2)
  set(MPI_LIB_NAME "mpich")
endif()
# These should not be evaluated until build time

string(APPEND LDFLAGS " -Wl,-rpath,\$(PARALLELIO_PATH)/lib")
string(APPEND LDFLAGS " -Wl,-rpath,\$(NETCDF_PATH)/lib")
string(APPEND SLIBS "  -lnetcdff -lnetcdf")
