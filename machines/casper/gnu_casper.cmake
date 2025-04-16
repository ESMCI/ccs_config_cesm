if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_NANOTIME -DBIT64 -DHAVE_SLASHPROC -DHAVE_GETTIMEOFDAY")
endif()
string(APPEND CMAKE_C_FLAGS_RELEASE " -O2 -g")
string(APPEND CMAKE_Fortran_FLAGS_RELEASE " -O2 -g")
set(MPICC "mpicc")
set(MPICXX "mpicxx")
set(MPIFC "mpif90")
set(SCC "gcc")
set(SCXX "g++")
set(SFC "gfortran")

if (USE_KOKKOS)
  # Generic setting that are used regardless of Architecture or Kokkos backend
  string(APPEND KOKKOS_OPTIONS " -DKokkos_ENABLE_DEPRECATED_CODE=OFF -DKokkos_ENABLE_EXPLICIT_INSTANTIATION=OFF")
  if (KOKKOS_GPU_OFFLOAD)
    string(APPEND CPPDEFS " -DGPU -DTHRUST_IGNORE_CUB_VERSION_CHECK")
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
    if (compile_threaded)
      # Settings used when OpenMP is the Kokkos backend
      string(APPEND KOKKOS_OPTIONS " -DKokkos_ARCH_ZEN4=ON -DKokkos_ENABLE_AGGRESSIVE_VECTORIZATION=ON -DKokkos_ENABLE_SERIAL=OFF -DKokkos_ENABLE_OPENMP=ON")
    else()
      string(APPEND KOKKOS_OPTIONS " -DKokkos_ARCH_ZEN4=ON -DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_OPENMP=OFF")
    endif()
    string(APPEND CXXFLAGS " -march=znver4 -mtune=znver4")
  endif()
  if (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 10)
    set(CMAKE_Fortran_FLAGS "-fallow-argument-mismatch"  CACHE STRING "" FORCE) # only works with gnu v10 and above
  endif()
  string(APPEND LDFLAGS " -lstdc++ -lkokkoscontainers -lkokkoscore -lkokkossimd ")
endif()
