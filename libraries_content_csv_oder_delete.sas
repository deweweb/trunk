%let LIBNAME = TEST;
proc sql noprint;
	CREATE TABLE work.hui AS
		SELECT memname /*, filesize format=sizekmg10.1 */
			FROM dictionary.tables
			WHERE libname = "&LIBNAME."
			  and memtype='DATA'
			ORDER BY memname
	;
quit;
proc export data= work.hui
	outfile = "/data/ablage/_&LIBNAME._TBLS_.csv"
	dbms = dlm
	replace;
	delimiter = ';';
run;

proc datasets lib=user kill; quit;

proc datasets lib=TEST nolist;
  delete
 DIFF_ARM
 DIFF_ARM_AKT
 PA03_BERATER
 PA03_OE
 PA03_VRT
  ;
quit;
run;


proc spdo lib = user;
	cluster undo
		_P_ZRT;
quit;


** AIR CNTAINER FAILURE METAIMDB RETAIL **;
%macro delete_from_lib_like(LIB_NAME=, DATA_TYPE= DATA, NAME_LIKE= _ie_tst);
	%let DEL_LIST =;
	proc sql noprint;
		SELECT memname INTO: DEL_LIST
			SEPARATED BY ' '
			FROM sashelp.vmember
			WHERE libname = "&LIB_NAME."
			  AND memtype = "&DATA_TYPE"
			  /* AND memname like '_AI_%' escape '_' */
			  AND find(memname, "&NAME_LIKE.", 'i') ge 1
		;
	quit;
	%put &DEL_LIST.;
	%*if "&DEL_LIST." ~= "" %then %do;
		*proc datasets lib= &LIB_NAME. nolist;
			*delete &DEL_LIST.;
		*quit;
	%*end;
%mend;

%delete_from_lib_like(LIB_NAME= WORK, DATA_TYPE= DATA, NAME_LIKE= _ai_);

/*
data work._AI_ROMB;
    set sashelp.AIR;
run;
*/
** AIR CNTAINER FAILURE METAIMDB RETAIL **;


/* Testaufruf:

%delete_from_lib_like(LIB_NAME= DATA, DATA_TYPE= DATA, NAME_LIKE= _ie_);

http://support.sas.com/kb/43/303.html

*/

