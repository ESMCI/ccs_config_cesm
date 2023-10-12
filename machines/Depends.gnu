geopk.o:geopk.F90
	$(FC) -c $(INCLDIR) $(INCS) $(FFLAGS) $(FREEFLAGS) -fcray-pointer $<

# RRTMGP contains openmp directives for running on GPUs.  These directives need to be
# disabled to allow building CAM with threading on CPUs enabled.
RRTMGP_OBJS=\
mo_fluxes_byband.o                       mo_rrtmgp_clr_all_sky.o \
mo_zenith_angle_spherical_correction.o   mo_gas_concentrations.o \
mo_aerosol_optics_rrtmgp_merra.o         mo_cloud_optics_rrtmgp.o \
mo_gas_optics_rrtmgp.o                   mo_gas_optics_rrtmgp_kernels.o \
mo_rte_sw.o                              mo_rte_lw.o \
mo_rte_util_array_validation.o           mo_rte_util_array.o \
mo_fluxes_broadband_kernels.o

$(RRTMGP_OBJS): %.o: %.F90
	$(FC) -c $(INCLDIR) $(INCS) $(FFLAGS) $(FREEFLAGS) -fno-openmp $<
