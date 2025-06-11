string(APPEND FFLAGS " -fallow-argument-mismatch  -fallow-invalid-boz ")
string(APPEND LDFLAGS " -Wl,-rpath,$LD_LIBRARY_PATH")