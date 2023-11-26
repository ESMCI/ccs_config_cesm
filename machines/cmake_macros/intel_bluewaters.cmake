set(HAS_F2008_CONTIGUOUS "FALSE")
string(APPEND FFLAGS " -dynamic -mkl=sequential")
string(APPEND CFLAGS " -dynamic -mkl=sequential")
