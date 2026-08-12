# Exempt atm2lndType.F90 from bounds checks on macOS (Darwin) gfortran ARM64
# due to an internal compiler segfault when bounds checking polymorphic arrays.
atm2lndType.o: atm2lndType.F90
	$(FC) -c $(INCLDIR) $(INCS) $(FFLAGS) $(FREEFLAGS) -fno-check=bounds $<
