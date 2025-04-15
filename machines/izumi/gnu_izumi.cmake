if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_SLASHPROC")
endif()
if (COMP_NAME STREQUAL mpi-serial)
  string(APPEND CFLAGS " -std=c89 ")
endif()

if (USE_KOKKOS)
  # Skylake optimization
  option(KOKKOS_ARCH_AVX512XEON "" ON)
  # Generic setting that are used regardless of Architecture or Kokkos backend
  set(Kokkos_ENABLE_DEPRECATED_CODE FALSE CACHE BOOL "")
  set(Kokkos_ENABLE_EXPLICIT_INSTANTIATION FALSE CACHE BOOL "")
  if (compile_threaded)
    # Settings used when OpenMP is the Kokkos backend
    set(Kokkos_ENABLE_AGGRESSIVE_VECTORIZATION TRUE CACHE BOOL "")
    set(Kokkos_ENABLE_OPENMP TRUE CACHE BOOL "")
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ENABLE_SERIAL=OFF -DKokkos_ENABLE_OPENMP=ON")
  else()
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_OPENMP=Off")
  endif()
  if (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 10)
    set(CMAKE_Fortran_FLAGS "-fallow-argument-mismatch"  CACHE STRING "" FORCE) # only works with gnu v10 and above
    string(APPEND FFLAGS " -fallow-argument-mismatch")
  endif()
  string(APPEND LDFLAGS " -lstdc++ -lkokkoscontainers -lkokkoscore -lkokkossimd ")
endif()
