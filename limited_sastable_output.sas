** limited observations output in sas base **;

data work.ttt;
	set data.dynmicstable_oue(where=(JAHR = 2018 and TYP = 'ALL'));
	if _n_ < 3 then put _all_;
	else stop;
run;
