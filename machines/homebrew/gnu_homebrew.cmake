# Legacy machine macro file; core settings inherited from gnu_Darwin.cmake
if (DEFINED NETCDF_PATH)
  string(APPEND LDFLAGS " -Wl,-rpath,${NETCDF_PATH}/lib")
endif()
