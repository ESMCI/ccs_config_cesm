if (USE_KOKKOS)
   # dynamic netcdff library doesn't have netcdf_MP_xxx symbols defined, link with static version
   string(APPEND SLIBS " -L${NETCDF_PATH}/lib ${NETCDF_PATH}/lib/libnetcdff.a -lnetcdf -Wl,-Wl,,-rpath,$(NETCDF_PATH)/lib")
  string(APPEND CPPDEFS " -DUSE_KOKKOS")
  # Generic setting that are used regardless of Architecture or Kokkos backend
  set(Kokkos_ENABLE_DEPRECATED_CODE FALSE CACHE BOOL "")
  set(Kokkos_ENABLE_EXPLICIT_INSTANTIATION FALSE CACHE BOOL "")
  if (KOKKOS_GPU_OFFLOAD)
    # Set the mpic++ compiler for use with nag
    set(USE_CUDA "TRUE")
    string(APPEND CPPDEFS " -DGPU")
    string(APPEND CPPDEFS " -DTHRUST_IGNORE_CUB_VERSION_CHECK")
    string(APPEND CMAKE_CUDA_FLAGS " -ccbin CC -O2 -arch=sm_80 --use_fast_math")
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ARCH_AMPERE80=On -DKokkos_ENABLE_CUDA=On -DKokkos_ENABLE_CUDA_LAMBDA=On -DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_OPENMP=Off -DKokkos_ENABLE_IMPL_CUDA_MALLOC_ASYNC=Off")
    # Enable A100 arch in kokkos
    option(Kokkos_ARCH_AMPERE80 "" ON)
    # This var is needed by relatively recent CMake when CUDA language is enabled
    # If not defined, CMake issues a warning
    set(CMAKE_CUDA_ARCHITECTURES 80 CACHE STRING "")
    # Settings used when Cuda is the Kokkos backend
    set(Kokkos_ENABLE_AGGRESSIVE_VECTORIZATION FALSE CACHE BOOL "")
    set(Kokkos_ENABLE_CUDA TRUE CACHE BOOL "")
    set(Kokkos_ENABLE_CUDA_LAMBDA TRUE CACHE BOOL "")
    set(CMAKE_CXX_FLAGS "-DTHRUST_IGNORE_CUB_VERSION_CHECK" CACHE STRING "" FORCE)
  else()
    # Enable EPYC arch in kokkos
    option(Kokkos_ARCH_ZEN3 "" ON)
    # Settings used when OpenMP is the Kokkos backend
    set(Kokkos_ENABLE_AGGRESSIVE_VECTORIZATION TRUE CACHE BOOL "")
    set(Kokkos_ENABLE_OPENMP TRUE CACHE BOOL "")
  endif()
  if (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 10)
    set(CMAKE_Fortran_FLAGS "-fallow-argument-mismatch"  CACHE STRING "" FORCE) # only works with gnu v10 and above
  endif()
  string(APPEND LDFLAGS " -lstdc++ -lkokkoscontainers -lkokkoscore -lkokkossimd ")
else()
  string(APPEND SLIBS " -L${NETCDF_PATH}/lib -lnetcdff -lnetcdf -Wl,-Wl,,-rpath,$(NETCDF_PATH)/lib")
endif()
