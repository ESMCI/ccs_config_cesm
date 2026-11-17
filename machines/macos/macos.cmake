# Use NETCDF_PATH from the environment if set (e.g., via config_machines.xml)
if (NOT "$ENV{NETCDF_PATH}" STREQUAL "")
  set(NETCDF_PATH "$ENV{NETCDF_PATH}")
endif()

# Runtime library search path for NetCDF libraries that use @rpath install names
# (e.g., custom CMake builds)
if (DEFINED NETCDF_PATH AND EXISTS "${NETCDF_PATH}/lib")
  string(APPEND LDFLAGS " -Wl,-rpath,${NETCDF_PATH}/lib")
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
