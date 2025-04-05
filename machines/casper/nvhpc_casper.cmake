string(APPEND CPPDEFS " -DHAVE_IEEE_ARITHMETIC")
if (NOT DEBUG)
  if (GPU_TYPE STREQUAL none) # AMD EPYC 9554P CPU
    string(APPEND CFLAGS " -tp=zen4")
    string(APPEND CXXFLAGS " -tp=zen4")
    string(APPEND FFLAGS " -tp=zen4")
    string(APPEND LDFLAGS " -tp=zen4 -Mnofma")
  elseif(GPU_TYPE STREQUAL a100) # AMD EPYC Milan 7763 CPU 
    string(APPEND CFLAGS " -tp=zen3")
    string(APPEND CXXFLAGS " -tp=zen3")
    string(APPEND FFLAGS " -tp=zen3")
    string(APPEND LDFLAGS " -tp=zen3 -Mnofma")
  else()
    string(APPEND CFLAGS " -tp=cascadelake")
    string(APPEND CXXFLAGS " -tp=cascadelake")
    string(APPEND FFLAGS " -tp=cascadelake")
    string(APPEND LDFLAGS " -tp=cascadelake -Mnofma")
  endif()
endif()
string(APPEND SLIBS " -llapack -lblas")
if (MPILIB STREQUAL mpi-serial)
  string(APPEND SLIBS " -ldl")
endif()
string(APPEND SLIBS " -L${NETCDF_PATH}/lib -lnetcdf -lnetcdff")
message("GPU_TYPE is ${GPU_TYPE}")
message("OPENACC_GPU_OFFLOAD is ${OPENACC_GPU_OFFLOAD}")
message("OPENMP_GPU_OFFLOAD is ${OPENMP_GPU_OFFLOAD}")

if (USE_KOKKOS)
  # Generic setting that are used regardless of Architecture or Kokkos backend
  set(Kokkos_ENABLE_DEPRECATED_CODE FALSE CACHE BOOL "")
  set(Kokkos_ENABLE_EXPLICIT_INSTANTIATION FALSE CACHE BOOL "")
  if (KOKKOS_GPU_OFFLOAD)
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
    option(Kokkos_ARCH_ZEN4 "" ON)
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ENABLE_OPENMP=Off") # work-around for nvidia as kokkos is not passing "-mp" for threaded build
  endif()
  if (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 10)
    set(CMAKE_Fortran_FLAGS "-fallow-argument-mismatch"  CACHE STRING "" FORCE) # only works with gnu v10 and above
    string(APPEND FFLAGS " -fallow-argument-mismatch")
  endif()
  string(APPEND LDFLAGS " -lstdc++ -lkokkoscontainers -lkokkoscore -lkokkossimd ")
endif()
