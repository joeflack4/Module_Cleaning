/*clear
clear matrix
clear mata
capture log close
set maxvar 15000
set more off
numlabel, add
*/
********************************************************************************
*FILENAME: CCRX_PHC_V#_$DATE.do
*PURPOSE:  Label destring and enconde PHC questions
*DATA IN:  CCRX_Combined_$date.dta
*DATA OUT: CCRX_Combined_$date.dta

*Aug 26 2016 shorten all var labels, commented multe-select cleaning questions for later
*v3 - Aug 14 2017 update based on ODK changes for GHR6 PHC FQ questions
******************************************************************************* 

/**********************************************************
*For test purpose, read in GHR6 FQ v10 csv
clear
insheet using "C:\Users\Shulin\Dropbox (Gates Institute)\Monitor GHR6\test data\GHR6_Female_Questionnaire_v10.csv"
**********************************************************/

//REVISION: SJ v3 rename vars that are nested in groups
rename impressions_1_grpimpr_* *
rename impressions_2_grpimpr_* *
rename impressions_3_grpimpr_* *
rename impressions_4_grpimpr_* *
rename impressions_4_grp* *
rename impressions_5_grpimpr_* *
rename impressions_5_grp* *
rename affordability_grp* *
rename hc_gen1_grp* *
rename hc_gen2_grp* *

//REVISION: SJ v3 some name typos in ODK need to be changed to match previous version
rename wait_ratin wait_rating
rename clean_rati clean_rating
rename trust_skil trust_skills
rename respect respect_rating
rename time_with_ time_with_provider
rename involvemen involvement
rename provider_c provider_choice
rename overall_ef overall_efficacy

* Label all variables in PHC
//REVISION: SJ v3 vars added on R6 PHC
label var health_rating "Rate your health condition"
label var mental_health_rating "Rate your mental health condition"
label var closest_facility_yn "Is this facility the closest"
label var closest_facility_why_not "Why not go to the closest facility"
label var listened "Provider listened carefully to you"
label var skills "Provider's medical knowledge and skills"
label var time_with_provider "Amount of time provider spent with you"
label var involvement "Involved in making decision for treatment"
label var privacy "Talk privately to providers"
label var provider_choice "Easy to see a provider you are happy with"
label var overall_efficacy "Overall rating of care received"
label var hc_overall_view "Your overall view of health care system"

*****existing variables in GHR5
label var rec_visit "Visited health facility in last 6 months"
label var not_rec_visit "Why not visit health facility in last 6 months"
capture label var not_rec_visit_other "Other reason if not visiting health facility"
label var care_for_whom "Person seek for care"
capture label var care_for_other "Other person seek for care" 
label var care_reason "Reasons to seek for care"
capture label var care_reason_other "Other reasons to seek for care"
label var facility "Facility type"
label var facility_name "Name of the facility"
label var facility_name_other "Name of facility if not in the list"
label var visit_factor "Important factors on choosing health services"
capture label var factor_other "Specify other factor if not in the list" 
label var visit_factor_most "The most important factor on choosing health services"
label var tomorrow "Care-seeking easy or difficult if care needed tomorrow"
label var same_provider "Taken care of by the same provider each time"
label var time_wait "How long waiting for provider"
capture rename FQtime_wait_int time_wait_int
label var time_wait_int "Waiting time" 
label var wait_rating "Rate waiting time"
label var clean_rating "Rate cleanliness of the facility including toilets"
label var trust_skills "Trust skills of health workers at the facility"
label var understand "Understand information from the provider easy or difficult"
label var provider_advice "Follow provider's advice easy or difficult"
label var respect_rating "Rate level of respect to you by the providers"
label var quality_rating "Rate the quality of care at this facility"
label var return_rating "Likeliness of returning to the facility for care"
label var insurance "Services covered by insurance"
label var which_insurance "Insurance that covered the services"
label var insurance_paid "Cost lowered due to insurance"
label var amount_paid "Amount paid out of pocket"
label var pay_rating "Pay for visit easy or difficult"
label var borrow "Borrow money or sell things to afford the costs of this visit"
*label var survey_language "In what language was this interview conducted?"

capture label define yes_no_dnk_nr_list 0 "no" 1 "yes" -88 "-88" -99 "-99"

capture label define yes_no_nr_list 0 "no" 1 "yes" -99 "-99"

capture label define yes_no_list 0 "no" 1 "yes" 

foreach var in rec_visit borrow insurance insurance_paid closest_facility_yn {
encode `var',gen(`var'n2) lab(yes_no_dnk_nr_list)
}

*Save all multi-select questions to clean later

//REVISION: SJ v3: closest_facility_why_not added in R6
rename closest_facility_why_not closest_whynot
split closest_whynot, gen(closest_whynot_)
local y=r(nvars)
foreach var in no_services closed already_gone expensive reachability distrust bad_experience privacy  {
gen closest_whynot_`var'=0 if closest_whynot!="" & closest_whynot!="-99" & closest_whynot!="-88" & closest_whynot!="other"
forval x=1/`y'{
replace closest_whynot_`var'=1 if closest_whynot_`x'=="`var'"
label val closest_whynot_`var' yes_no_nr_list
label var closest_whynot_`var' "Did not visit closest facility due to `var'"
}
}
order closest_whynot_no_services-closest_whynot_privacy, after(closest_whynot)
forval x=1/`y' {
drop closest_whynot_`x'
}
rename closest_whynot closest_facility_why_not

split not_rec_visit, gen(not_rec_visit_)
local y=r(nvars)
foreach var in noneed far expensive difficult distrust negative nonprivate nowhere chw  {
gen not_rec_visit_`var'=0 if not_rec_visit!="" & not_rec_visit!="-99" & not_rec_visit!="-88" & not_rec_visit!="other"
forval x=1/`y'{
replace not_rec_visit_`var'=1 if not_rec_visit_`x'=="`var'"
label val not_rec_visit_`var' yes_no_nr_list
label var not_rec_visit_`var' "Did not visit health facility due to `var'"
}
}
order not_rec_visit_noneed-not_rec_visit_chw, after(not_rec_visit)
forval x=1/`y' {
drop not_rec_visit_`x'
}


split care_for_whom, gen(care_for_whom_)
local y=r(nvars)
foreach var in self child other_fam {
gen care_for_`var'=0 if care_for_whom!="" & care_for_whom!="-99" & care_for_whom!="other"
forval x=1/`y'{
replace care_for_`var'=1 if care_for_whom_`x'=="`var'"
label val care_for_`var' yes_no_nr_list
label var care_for_`var' "Seeking care for `var'"
}
}
order care_for_self-care_for_other_fam, after(care_for_whom)
forval x=1/`y' {
drop care_for_whom_`x'
}


split care_reason, gen(care_reason_)
local y=r(nvars)
foreach var in fp maternal vacc fever sick chw bite injury pressure diabetes hiv worried {
gen care_reason_`var'=0 if care_reason!="" & care_reason!="-99" & care_reason!="other"
forval x=1/`y'{
replace care_reason_`var'=1 if care_reason_`x'=="`var'"
label val care_reason_`var' yes_no_nr_list
label var care_reason_`var' "Seeking care due to `var'"
}
}
order care_reason_fp-care_reason_worried, after(care_reason)
forval x=1/`y' {
drop care_reason_`x'
}

/* wrong codes for facility
label define facility_type_list 1 "hosp" 2 "center" 3 "post" 4 "chps" 5 "fp_clinic" 6 "mobile_clinic" 7 "private_clinic" ///
8 "private_doc" 9 "pharm" 10 "store" 11 "ppag" 12 "maternity" 13 "ngo" 14 "herbal" 15 "other" -88 "-88" -99 "-99" 
encode facility, gen(facilityn2) lab(facility_type_list) 
label define facility_type_list 1 "Govt. Hospital/polyclinic" 2 "Govt. Health center" 3 "Govt. Health post" 4 "CHPS" 5 "Family planning clinic" ///
6 "Mobile Clinic" 7 "Private Hospital/Clinic" 8 "Private Doctor" 9 "Private Pharmacy" 10 "Chemical/drug Store" 11 "FP/PPAG Clinic" ///
12 "Maternity Home" 13 "NGO" 14 "Herbal Clinic" 15 "Other" -88 "-88" -99 "-99", replace 
*/

* clean the response of facility first and then code
label define phc_facility_type_list 11 "hosp" 12 "center" 13 "post" 10 "chps" 14 "fp_clinic" 15 "mobile_clinic" 21 "private_clinic" ///
22 "private_doc" 23 "pharm" 24 "store" 25 "ppag" 26 "maternity" 35 "ngo" 36 "herbal" 96 "other" -88 "-88" -99 "-99" 
encode facility, gen(facilityn2) lab(phc_facility_type_list) 
label define phc_facility_type_list 11 "Govt. Hospital/polyclinic" 12 "Govt. Health center" 13 "Govt. Health post" 10 "CHPS" 14 "Family planning clinic" ///
15 "Mobile Clinic" 21 "Private Hospital/Clinic" 22 "Private Doctor" 23 "Private Pharmacy" 24 "Chemical/drug Store" 25 "FP/PPAG Clinic" ///
26 "Maternity Home" 35 "NGO" 36 "Herbal Clinic" 96 "Other" -88 "-88" -99 "-99", replace 


split visit_factor, gen(visit_factor_)
local y=r(nvars)
foreach var in wait distance clean respect competent privacy supply cost choice know traditional {
gen visit_factor_`var'=0 if visit_factor!="" & visit_factor!="-99" & visit_factor!="other"
forval x=1/`y'{
replace visit_factor_`var'=1 if visit_factor_`x'=="`var'"
label val visit_factor_`var' yes_no_nr_list
}
}
order visit_factor_wait-visit_factor_traditional, after(visit_factor)
forval x=1/`y' {
drop visit_factor_`x'
}

label define difficult_4_bot_list 1 "very_difficult" 2 "difficult" 3 "easy" 4 "very_easy" -99 "-99"
encode tomorrow, gen(tomorrown2) lab(difficult_4_bot_list)

label define freq_4_top_list 1 "always" 2 "freq" 3 "rare" 4 "never" -88 "-88" -99 "-99"
encode same_provider, gen(same_providern2) lab(freq_4_top_list) 

label define time_wait_list 1 "minutes" 2 "hours" 3 "gave_up" -88 "-88" -99 "-99"
encode time_wait, gen(time_waitn2) lab(time_wait_list) 
 
label define wait_rating_list 1 "unbearable" 2 "very_long" 3 "long" 4 "little_long" 5 "fine" -99 "-99"
encode wait_rating, gen(wait_ratingn2) lab(wait_rating_list) 

label define excellent_5_top_list 1 "excellent" 2 "very_good" 3 "good" 4 "fair" 5 "poor" -99 "-99"
//REVISION: SJ v3 added vars in R6
foreach var in clean_rating health_rating mental_health_rating listened skills ///
time_with_provider involvement privacy provider_choice overall_efficacy {
encode `var', gen(`var'n2) lab(excellent_5_top_list) 
}

label define agree_4_top_list 1 "strong_agree" 2 "agree" 3 "disagree" 4 "strong_disagree" -99 "-99"
encode trust_skills, gen(trust_skillsn2) lab(agree_4_top_list) 

encode understand, gen(understandn2) lab(difficult_4_bot_list) 

encode provider_advice, gen(provider_advicen2) lab(difficult_4_bot_list) 

encode respect_rating, gen(respect_ratingn2) lab(excellent_5_top_list) 

encode quality_rating, gen(quality_ratingn2) lab(excellent_5_top_list) 

label define likely_4_top_list 1 "ex_likely" 2 "likely" 3 "unlikely" 4 "ex_unlikely" -88 "-88" -99 "-99"
encode return_rating, gen(return_ratingn2) lab(likely_4_top_list) 
encode recommend, gen(recommendn2) lab(likely_4_top_list)

encode pay_rating, gen(pay_ratingn2) lab(difficult_4_bot_list)

*label define language_list 1 "english" 2 "akan" 3 "ga" 4 "ewe" 5 "nzema" 6 "dagbani" 7 "other"
*encode survey_language, gen(survey_languagen2) lab(language_list)
//REVISION: SJ v3 added in GHR6
label define hc_overall_view_list 1 "unfavorable" 2 "relatively_neutral" 3 "favorable"
encode hc_overall_view, gen(hc_overall_viewn2) lab(hc_overall_view_list)

split which_insurance, gen(which_insurance_)
local y=r(nvars)
foreach var in national employer mutual {
gen which_ins_`var'=0 if which_insurance!="" & which_insurance!="other"
forval x=1/`y'{
replace which_ins_`var'=1 if which_insurance_`x'=="`var'"
label val which_ins_`var' yes_no_nr_list
label var which_ins_`var' "`var' insurance covers your services"
}
}
order which_ins_national-which_ins_mutual, after(which_insurance)
forval x=1/`y' {
drop which_insurance_`x'
}

unab vars: *n2
local stubst: subinstr local vars "n2" "", all
foreach var in `stubst'{
rename `var' `var'HC
order `var'n2, after (`var'HC)
}
rename *n2 *

drop *HC

drop visit_factor_choices time_wait_label
*phc_opening_note last_time_note
destring time_wait_int, replace
destring amount_paid, replace

********************************************************************************
* Drop all name variables and GPS for data release
*drop facility_name facility_name_other
********************************************************************************

save, replace

*save "`CCRX'_Combined_$date.dta", replace
