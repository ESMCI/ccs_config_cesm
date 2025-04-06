string(APPEND CFLAGS " -qopt-report -march=core-avx2")
string(APPEND FFLAGS " -qopt-report -march=core-avx2")
if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_SLASHPROC")
endif()
if (COMP_NAME STREQUAL mpi-serial)
  string(APPEND CFLAGS " -std=c89 ")
endif()	
if (MPILIB STREQUAL mpi-serial AND NOT compile_threaded)
  set(PFUNIT_PATH "$ENV{CESMDATAROOT}/tools/pFUnit/pFUnit4.8.0_derecho_Intel2023.2.1_noMPI_noOpenMP")
endif()
set(SCC icx)
set(SCXX icpx)
set(SFC ifort)

if (USE_KOKKOS)
  # Generic setting that are used regardless of Architecture or Kokkos backend
  set(Kokkos_ENABLE_DEPRECATED_CODE FALSE CACHE BOOL "")
  set(Kokkos_ENABLE_EXPLICIT_INSTANTIATION FALSE CACHE BOOL "")
  option(Kokkos_ARCH_ZEN4 "" ON)
  # Settings used when OpenMP is the Kokkos backend
  set(Kokkos_ENABLE_AGGRESSIVE_VECTORIZATION TRUE CACHE BOOL "")
  set(Kokkos_ENABLE_OPENMP TRUE CACHE BOOL "")
  set(CMAKE_CXX_FLAGS "-DTHRUST_IGNORE_CUB_VERSION_CHECK" CACHE STRING "" FORCE)
  string(APPEND LDFLAGS " -lstdc++ ")
endif()