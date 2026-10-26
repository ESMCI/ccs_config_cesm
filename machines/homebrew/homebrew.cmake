# Dynamic include and library path appends using MAC_PREFIX defined in Darwin.cmake
if (DEFINED MAC_PREFIX AND EXISTS "${MAC_PREFIX}")
  string(APPEND CFLAGS " -I${MAC_PREFIX}/include")
  string(APPEND CXXFLAGS " -I${MAC_PREFIX}/include")
  string(APPEND FFLAGS " -I${MAC_PREFIX}/include")
  string(APPEND LDFLAGS " -L${MAC_PREFIX}/lib -Wl,-rpath,${MAC_PREFIX}/lib")
endif()

# Use NETCDF_PATH from the environment if set (e.g., via config_machines.xml);
# otherwise default to the package manager prefix
if (NOT "$ENV{NETCDF_PATH}" STREQUAL "")
  set(NETCDF_PATH "$ENV{NETCDF_PATH}")
else()
  set(NETCDF_PATH "${MAC_PREFIX}")
endif()

# Additional runtime library search path if NETCDF_PATH is set outside MAC_PREFIX
if (NOT NETCDF_PATH STREQUAL MAC_PREFIX AND EXISTS "${NETCDF_PATH}/lib")
  string(APPEND LDFLAGS " -Wl,-rpath,${NETCDF_PATH}/lib")
endif()

# Use PFUNIT_PATH from the environment if set (e.g., via config_machines.xml).
if (NOT "$ENV{PFUNIT_PATH}" STREQUAL "")
  set(PFUNIT_PATH "$ENV{PFUNIT_PATH}")
endif()
