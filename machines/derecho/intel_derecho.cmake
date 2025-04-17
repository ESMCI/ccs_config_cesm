set(CONFIG_ARGS "--host=cray")
string(APPEND CFLAGS " -qopt-report -march=core-avx2")
string(APPEND CXXFLAGS " -qopt-report -march=core-avx2")
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
  string(APPEND KOKKOS_OPTIONS " -DKokkos_ENABLE_DEPRECATED_CODE=OFF -DKokkos_ENABLE_EXPLICIT_INSTANTIATION=OFF")
  # Enable EPYC arch in kokkos
  if (compile_threaded)
    # Settings used when OpenMP is the Kokkos backend
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ARCH_ZEN3=ON -DKokkos_ENABLE_AGGRESSIVE_VECTORIZATION=ON -DKokkos_ENABLE_SERIAL=OFF -DKokkos_ENABLE_OPENMP=ON")
  else()
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ARCH_ZEN3=ON -DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_OPENMP=OFF")
  endif()
  set(CMAKE_CXX_FLAGS "-DTHRUST_IGNORE_CUB_VERSION_CHECK" CACHE STRING "" FORCE)
  string(APPEND LDFLAGS " -lstdc++ -lkokkoscontainers -lkokkoscore -lkokkossimd ")
endif()