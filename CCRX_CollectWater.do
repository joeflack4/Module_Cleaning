**Round specific FQ changes

*******************************************************************************
*
*  FILENAME:	CCRX_TimeToCollectWater_Module_v1_$date.do
*  PURPOSE:		Label and encode collect water 
*  CREATED:		Linnea Zimmerman (lzimme12@jhu.edu)
*  DATA IN:		CCRX_Combined_$date.dta
*  DATA OUT:	CCRX_Combined_$date.dta
*  UPDATES:		1 Feb 2016 - Linnea Zimmerman - added question labels
*
*******************************************************************************

********************************************************************************
*Round 1 Questions on Time to collect water
********************************************************************************
*Time to collect water

label var 	collect_water_dry			"Time collect water - DRY season"
label var	collect_water_dry_value		"Value - collect water dry"
label var	collect_water_wet			"Time collect water - WET season"
label var 	collect_water_wet_value		"Value - collect water wet"

label define collect_water_list 1 minutes 2 hours 3 someone_else 4 no_one -88 "-88" -99 "-99"
encode collect_water_dry, gen(collect_water_dryv2) lab(collect_water_list)
encode collect_water_wet, gen(collect_water_wetv2) lab(collect_water_list)

destring collect_water_dry_value, replace
destring collect_water_wet_value, replace

save, replace




