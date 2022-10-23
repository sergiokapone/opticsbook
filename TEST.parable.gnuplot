set table "TEST.parable.table"; set format "%.5f"
set format "%.7e";; set samples 500; set dummy x; plot [x=-10:10] 4*besj1(x)**2/x**2;
