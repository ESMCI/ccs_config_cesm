string(APPEND CFLAGS " -std=gnu99")
string(APPEND CXXFLAGS " -std=c++17")
if (DEBUG)
  string(APPEND CFLAGS " -g")
endif()
string(APPEND CPPDEFS " -DFORTRANUNDERSCORE -DNO_CRAY_POINTERS -DNO_SHR_VMATH -DCPRNAG -DNO_R16")
set(FC_AUTO_R8 "-r8")
string(APPEND FFLAGS " -Wp,-macro=no_com -convert=BIG_ENDIAN ")
string(APPEND FFLAGS "-indirect ${SRCROOT}/ccs_config/machines/nag_mpi_argument.txt")
if (NOT DEBUG)
  string(APPEND FFLAGS " -ieee=full -O2")
endif()
if (DEBUG)
  string(APPEND FFLAGS " -C=all -g -time -f2003 -ieee=stop")
endif()
if (DEBUG AND NOT compile_threaded)
  string(APPEND FFLAGS " -gline")
endif()
if (COMP_NAME STREQUAL cism)
  string(APPEND FFLAGS " -mismatch_all")
endif()
set(FFLAGS_NOOPT "-O0")
set(FIXEDFLAGS "-fixed")
set(FREEFLAGS "-free")
set(HAS_F2008_CONTIGUOUS "FALSE")
set(MPICC "mpicc")
set(MPICXX "mpicxx")
set(MPIFC "mpif90")
set(SCC "gcc")
set(SCXX "g++")
set(SFC "nagfor")
string(APPEND LDFLAGS " -lpthread")
string(APPEND CONFIG_ARGS " FCLIBS='-Wl,--as-needed,--allow-shlib-undefined  -L$(COMPILER_PATH)/lib/NAG_Fortran -lf62rts'")
set(CMAKE_CXX_COMPILER g++)
