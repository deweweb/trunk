/************ 1 *************/

** Number of obsetvations in table **;
%macro number_obs(TABLE=);

	%let NUM_OBS = 0;
	data _null_;
		set &TABLE nobs=nobs;
		if _n_ = 1 then do;
			call symput('NUM_OBS', compress(put(nobs, best.)));
			stop;
		end;
	run;
	%put "Number of obsetvations is &TABLE ist &num_obs";

%mend;

/* Test:
	%number_obs(TABLE= data.dynmicstable_oue);
*/

/************ 2 *************/

** First filter data then limited output **;
%macro limit_obs(TABLE_IN=, TABLE_OUT=, WHERE_CL= 1=1, NUM_OBS=);

	data &TABLE_OUT.;
		set &TABLE_IN(where=(&WHERE_CL.));
		** only 2 observations will be read from the filtered source table **;
		if _n_ < &NUM_OBS. then put _all_;
		else stop;
	run;

%mend;

/* Test:

%limit_obs(
    TABLE_IN  = data.dynmicstable_oue
  , TABLE_OUT = work.ttt
  , NUM_OBS   = 3
)

%limit_obs(
    TABLE_IN  = data.dynmicstable_oue
  , TABLE_OUT = work.ttt
  , WHERE_CL  = JAHR = 2018 and TYP = 'ALL'
  , NUM_OBS   = 3
)

*/
