# Legacy machine macro file; core settings inherited from Darwin_gnu.cmake
if (DEFINED NETCDF_PATH)
  string(APPEND LDFLAGS " -Wl,-rpath,${NETCDF_PATH}/lib")
endif()
