# Exempt atm2lndType.F90 from bounds checks on macOS (Darwin) gfortran ARM64
# (reproduced on Homebrew GCC 16.1.0 / gfortran 16.1.0) due to an internal compiler
# segfault when bounds checking polymorphic arrays.
atm2lndType.o: atm2lndType.F90
	$(FC) -c $(INCLDIR) $(INCS) $(FFLAGS) $(FREEFLAGS) -fno-check=bounds $<
