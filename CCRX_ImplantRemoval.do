/*******************************************************************************
*
*  FILENAME:	CCRX_ImplantRemoval_v#_$date.do
*  PURPOSE:		Label and encode implant removal questions
*  CREATED:		Linnea Zimmerman (lzimme12@jhu.edu)
*  DATA IN:		CCRX_Combined_$date.dta
*  DATA OUT:	CCRX_Combined_$date.dta
*
*******************************************************************************/
*Rename Variables
capture rename implant_removed_attempt implant_removed_attempt_12_rw

*Label Variables
label var implant_type "How many rods is your implant?"
label var implant_protect "Were you told how long the implant would protect you from pregnancy?"
label var implant_duration "How long were you told?"
label var implant_duration_value "Value of months/years entered in implant_duration_value"
label var told_removal "Were you told where you could go to have the implant removed?"
label var implant_removed_attempt_12_rw	"In past 12 months, tried to have your current implant removed?"
label var implant_removed_who_rec "When you stopped using the implant, where was it removed?"
label var implant_removed_who "Who attempted/where did you go to try to remove your implant?"
label var implant_not_removed	"Why were you not able to have your implant removed?"
label var implant_not_other "IMP_306b. Why not able to have implant removed? "

*Encode Variables
label define implant_list 1 "one" 2 "two" 6 "six" -88 "-88" -99 "-99" 
encode implant_type, gen(implant_typev2) lab(implant_list)
 
encode implant_protect, gen(implant_protectv2) lab(yes_no_dnk_nr_list)

label define impduration_list 1 "months" 2 "years" -88 "-88" -99 "-99"
encode implant_duration, gen(implant_durationv2) lab(impduration_list)

destring implant_duration_value, replace
 
encode told_removal, gen(told_removalv2) lab(yes_no_dnk_nr_list)

encode implant_removed_attempt_12_rw, gen(implant_removed_attempt_12_rwv2) lab(yes_no_dnk_nr_list)

label define provider_self_list 10 govt_hosp 11 govt_health_center 12 govt_dispensary 13 other_public ///
	20 private_hosp 21 pharmacy 22 nursing_materinity 23 faith_based 24 FHOK_health_center 25 other_private ///
	30 shop 31 mobile_clinic 32 community_based 33 chw 34 friend_relative 35 self 96 other -99 "-99"
	
encode implant_removed_who_rec, gen(implant_removed_who_recv2) lab(provider_self_list)
encode implant_removed_who, gen(implant_removed_whov2) lab(provider_self_list)

*Clean implant_not_removed variable
replace implant_not_removed=subinstr(implant_not_removed, "counseled_against", "couns_against", .)

foreach reason in not_open unavailable unsuccessful refused cost travel couns_against told_return ///
	told_elsewhere other {
		gen impl_not_removed_`reason'=0 if implant_not_removed!="" & implant_not_removed!="-99"
		replace impl_not_removed_`reason'=1 if (regexm(implant_not_removed, "`reason'"))
	}

gen impl_not_removed_dnk=0 if implant_not_removed!="" & implant_not_removed!="-99"
replace impl_not_removed_dnk=1 if (regexm(implant_not_removed, "-88"))

unab vars: *v2
local stubs: subinstr local vars "v2" "", all
foreach var in `stubs'{
rename `var' `var'QZ
order `var'v2, after (`var'QZ)
}
rename *v2 *

drop *QZ

save, replace
