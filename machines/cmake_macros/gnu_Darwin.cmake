# ==============================================================================
# machines/cmake_macros/gnu_Darwin.cmake
# macOS (Darwin) specific compiler flags for GNU (GCC / gfortran)
# ==============================================================================

# macOS System Frameworks & Library Runtime Search Paths
string(APPEND LDFLAGS " -framework Accelerate")

# Dynamic include and library path appends using MAC_PREFIX defined in Darwin.cmake
if (DEFINED MAC_PREFIX AND EXISTS "${MAC_PREFIX}")
  string(APPEND CFLAGS " -I${MAC_PREFIX}/include")
  string(APPEND CXXFLAGS " -I${MAC_PREFIX}/include")
  string(APPEND FFLAGS " -I${MAC_PREFIX}/include")
  string(APPEND LDFLAGS " -L${MAC_PREFIX}/lib -Wl,-rpath,${MAC_PREFIX}/lib")
endif()

# Fortran Legacy Mismatch Flags (GCC 10+)
if (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 10 OR NOT DEFINED CMAKE_Fortran_COMPILER_VERSION)
  string(APPEND FFLAGS " -fallow-argument-mismatch -fallow-invalid-boz")
endif()
