# NetCDF: This configuration always uses separate C and Fortran paths
# (NETCDF_C_PATH and NETCDF_FORTRAN_PATH), even if they are the same; NETCDF_PATH is
# never set.

# Set out_var from the environment variable env_var if set (e.g., via
# config_machines.xml); otherwise from `config_tool --prefix`; otherwise error. (This
# is done in a function because every variable set at the top level of this file is
# written to Macros.make; the function keeps its temporaries out of it.)
function(macos_netcdf_path out_var env_var config_tool)
  if (NOT "$ENV{${env_var}}" STREQUAL "")
    set(path "$ENV{${env_var}}")
  else()
    execute_process(COMMAND ${config_tool} --prefix
      OUTPUT_VARIABLE path
      RESULT_VARIABLE result
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_QUIET)
    if (NOT result EQUAL 0 OR path STREQUAL "")
      message(FATAL_ERROR
        "${env_var} is not set, and it could not be determined from "
        "`${config_tool} --prefix`. Set ${env_var}.")
    endif()
  endif()
  set(${out_var} "${path}" PARENT_SCOPE)
endfunction()

macos_netcdf_path(NETCDF_C_PATH NETCDF_C_PATH nc-config)
macos_netcdf_path(NETCDF_FORTRAN_PATH NETCDF_FORTRAN_PATH nf-config)

# Runtime library search paths for NetCDF libraries that use @rpath install names
# (e.g., custom CMake builds); avoid duplicates, which the macOS linker warns about
string(APPEND LDFLAGS " -Wl,-rpath,${NETCDF_C_PATH}/lib")
if (NOT NETCDF_FORTRAN_PATH STREQUAL NETCDF_C_PATH)
  string(APPEND LDFLAGS " -Wl,-rpath,${NETCDF_FORTRAN_PATH}/lib")
endif()

# Use PFUNIT_PATH from the environment if set (e.g., via config_machines.xml).
if (NOT "$ENV{PFUNIT_PATH}" STREQUAL "")
  set(PFUNIT_PATH "$ENV{PFUNIT_PATH}")
endif()

# If using an external PIO (PIO set, e.g., via config_machines.xml), point the
# Makefile-based builds to it
if (NOT "$ENV{PIO}" STREQUAL "")
  set(PIO_LIBDIR "$ENV{PIO}/lib")
  set(PIO_INCDIR "$ENV{PIO}/include")
endif()
