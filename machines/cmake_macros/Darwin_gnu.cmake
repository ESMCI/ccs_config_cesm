# ==============================================================================
# machines/cmake_macros/Darwin_gnu.cmake
# macOS (Darwin) specific compiler flags for GNU (GCC / gfortran)
# ==============================================================================

# macOS System Frameworks & Library Runtime Search Paths
string(APPEND LDFLAGS " -framework Accelerate")

# Fortran Legacy Mismatch Flags (GCC 10+)
if (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER_EQUAL 10 OR NOT DEFINED CMAKE_Fortran_COMPILER_VERSION)
  string(APPEND FFLAGS " -fallow-argument-mismatch -fallow-invalid-boz")
endif()
