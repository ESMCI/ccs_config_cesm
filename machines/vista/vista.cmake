string(APPEND LDFLAGS " -Wl,-rpath,/scratch/00422/cazes/netcdf_installs/netcdf_4.7.4_nvhpc_24.7/lib")
string(APPEND LDFLAGS " -Wl,-rpath,/scratch/00422/cazes/pnetcdf_1.13.0_nvhpc/lib")
set(LAPACK_LIBDIR "/home1/apps/nvidia/Linux_aarch64/24.7/compilers/lib")
