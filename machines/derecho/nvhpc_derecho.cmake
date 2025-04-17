string(APPEND CONFIG_ARGS " --host=cray")
string(APPEND CPPDEFS " -DHAVE_IEEE_ARITHMETIC")
if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_NANOTIME -DBIT64 -DHAVE_SLASHPROC -DHAVE_GETTIMEOFDAY")
endif()
if (NOT DEBUG)
  string(APPEND FFLAGS " -tp=zen3 -Mstack_arrays -Mallocatable=03")
  string(APPEND CXXFLAGS " -tp=zen3")
  string(APPEND LDFLAGS " -tp=zen3 -Mnofma")
endif()
message("GPU_TYPE is ${GPU_TYPE}")
message("OPENACC_GPU_OFFLOAD is ${OPENACC_GPU_OFFLOAD}")
message("OPENMP_GPU_OFFLOAD is ${OPENMP_GPU_OFFLOAD}")

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
    string(APPEND KOKKOS_OPTIONS " -DKokkos_ARCH_ZEN3=ON -DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_OPENMP=OFF") # work-around for nvidia as kokkos is not passing "-mp" for threaded build
  endif()
  string(APPEND LDFLAGS " -lstdc++ -lkokkoscontainers -lkokkoscore -lkokkossimd ")
  string(APPEND SLIBS " -lsci_nvidia ")
endif()