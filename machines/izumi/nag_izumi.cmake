string(APPEND SLIBS " -L${NETCDF_PATH}/lib -lnetcdff -lnetcdf -Wl,-Wl,,-rpath,$(NETCDF_PATH)/lib")
string(APPEND CONFIG_ARGS " FCLIBS='-Wl,--as-needed,--allow-shlib-undefined  -L$(COMPILER_PATH)/lib/NAG_Fortran -lf70rts'")
