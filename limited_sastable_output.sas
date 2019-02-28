** limited observations output in sas base **;

data work.ttt;
	set data.dynmicstable_oue(where=(JAHR = 2018 and TYP = 'ALL'));
	** only 2 observations will be read from the source table **;
	if _n_ < 3 then put _all_;
	else stop;
run;
