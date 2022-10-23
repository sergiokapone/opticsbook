set table "TEST.parable2.table"; set format "%.5f"
set format "%.7e";; set samples 500; set dummy x; plot [x=-20:20] 2*1/x*besj1(x)-besj0(x);
