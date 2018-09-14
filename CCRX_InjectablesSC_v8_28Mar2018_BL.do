/*******************************************************************************
*
*  FILENAME:	CCRX_SayanaPress_Module_v1_2016.02.23.dta
*  PURPOSE:		Recode SP questions and methods list
*  CREATED:		Linnea Zimmerman (linnea.zimmerman@jhu.edu)
*  DATA IN:		CCRX_Combined_NONAME_ECRECODE_$date.dta
*  DATA OUT:	CCRX_Combined_NONAME_ECRECODE_$date.dta
*  UPDATES:		For Burkina Round 4, -99 was coded as no_response. Modified label to adjust 
				Updated replace pattern to use subinstr rather than replacement if multiple 
				methods selected
				v5- HC- *v2 renamed to * 3/3/2017
				v6- LZ- 03/6/2017 - reclassify injectable users who say "both" as 
				current or recent SP users
				v7 - LZ-05/08/2017 only labels and destrings.  Does not replace values as sayana press. 
				Renamed to injectablesSC
				
*******************************************************************************/


label var injectable_probe_current "FQ21a. PROBE: Was the injection administered via syringe or small needle?"
label var injectable_probe_recent "FQ26a. PROBE: Was the injection administered via syringe or small needle?"
label var injectable_probe_first "FQ42a. PROBE: Was the injection administered via syringe or small needle?"
label var injectable_probe_pp "LCL_PP1. PROBE: Was the injection administered via syringe or small needle?"

label define injectable_probe_list 1 "syringe" 2 "small_needle" 3 "both" -99 "-99" -88 "-88", replace
foreach var in injectable_probe_first injectable_probe_recent injectable_probe_current injectable_probe_pp {
encode `var', gen(`var'v2) lab(injectable_probe_list)
}

drop injectable_probe_first injectable_probe_recent injectable_probe_current injectable_probe_pp
rename injectable_probe_firstv2 injectable_probe_first
rename injectable_probe_recentv2 injectable_probe_recent
rename injectable_probe_currentv2 injectable_probe_current
rename injectable_probe_ppv2 injectable_probe_pp

save, replace
