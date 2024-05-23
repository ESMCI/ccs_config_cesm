string(APPEND LDFLAGS " -Wl,-rpath,${NETCDF_PATH}/lib")
string(APPEND LDFLAGS " -Wl,-rpath,$ENV{PNETCDF_PATH}/lib/")
