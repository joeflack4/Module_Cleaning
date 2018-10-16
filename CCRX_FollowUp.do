/*******************************************************************************
*
*  FILENAME:	CCRX_FollowUp_v#_$date.do
*  PURPOSE:		Label and encode follow up questions
*  CREATED:		Shulin Jiang (sjiang19@jhu.edu)
*  DATA IN:		CCRX_Combined_$date.dta
*  DATA OUT:	CCRX_Combined_$date.dta
*  UPDATES:		
*******************************************************************************/

foreach var in flw_willing flw_number_yn flw_number_confirm {
encode `var', gen(`var'v2) lab(yes_no_dnk_nr_list)
}

unab vars: *v2
local stubs: subinstr local vars "v2" "", all
foreach var in `stubs'{
rename `var' `var'QZ
order `var'v2, after (`var'QZ)
}
rename *v2 *

label var flw_willing "Willing to participate survey in future"
label var flw_number_yn "Do you own a phone"
label var flw_number_typed "Primary phone number for future follow up"
label var flw_number_confirm "To confirm, is the number correct"

save, replace
