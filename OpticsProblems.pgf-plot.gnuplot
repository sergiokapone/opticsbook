set table "OpticsProblems.pgf-plot.table"; set format "%.5f"
set samples 500.0; plot [x=-3.46*pi:2.24*pi] 4*besj1(x)**2/x**2 + 4*besj1(x + 1.22*pi)**2/(x + 1.22*pi)**2
