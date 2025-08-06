set(SCC icx)
set(SCXX icpx)
set(SFC ifort)
set(MPICC "mpicc")
set(MPICXX "mpicxx")
set(MPIFC "mpif90")
string(APPEND CFLAGS " -qopt-report -march=core-avx2")
string(APPEND CXXFLAGS " -qopt-report -march=core-avx2")
string(APPEND FFLAGS " -qopt-report -march=core-avx2")
string(APPEND SLIBS " -qmkl=cluster")

if (USE_KOKKOS)
  # Generic setting that are used regardless of Architecture or Kokkos backend
  string(APPEND KOKKOS_OPTIONS " -DKokkos_ENABLE_DEPRECATED_CODE=OFF -DKokkos_ENABLE_EXPLICIT_INSTANTIATION=OFF")
  # Enable EPYC arch in kokkos
  if (compile_threaded)
    # Settings used when OpenMP is the Kokkos backend
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ARCH_ZEN4=ON -DKokkos_ENABLE_AGGRESSIVE_VECTORIZATION=ON -DKokkos_ENABLE_SERIAL=OFF -DKokkos_ENABLE_OPENMP=ON")
  else()
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ARCH_ZEN4=ON -DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_OPENMP=OFF")
  endif()
  set(CMAKE_CXX_FLAGS "-DTHRUST_IGNORE_CUB_VERSION_CHECK" CACHE STRING "" FORCE)
  string(APPEND LDFLAGS " -lstdc++ -lkokkoscontainers -lkokkoscore -lkokkossimd ")
endif()
