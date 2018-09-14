********************************************************************************
*
*  FILENAME:	CCRX-Panel-v##_$date-initials.do
*  PURPOSE:		Label and encode questions in panel module of PMA2020 surveys
*  CREATED:		Shulin Jiang (sjiang19@jhu.edu
*  DATA IN:		CCRX_Female_Questionnaire_v#_results.csv
*  Country round applied: UGR6	
*  UPDATES:		
********************************************************************************

cd "$datadir"

*PNL_001. Does your husband/partner want to have a/another child within two years?
label define yes_no_us_nr_list 0 no 1 yes -88 "unsure" -99 "-99"
encode partner_want_kid_2yr_yn, gen(partner_want_kid_2yr_ynv2) lab(yes_no_us_nr_list)

*PNL_002. In the next few weeks, if you discovered that you were pregnant, would that be a big problem, a small problem, or no problem for you?
label define big_small_list 2 "big" 1 "small" 0 "no_problem" -99 "-99"
encode preg_problematic, gen(preg_problematicv2) lab(big_small_list)

*PNL_003. Is your husband/partner supportive of you using family planning?
label define yes_no_np_dnk_nr_list 0 "no" 1 "yes" 2 "nopartner" -88 "-88" -99 "-99"
encode partner_supportive_now, gen(partner_supportive_nowv2) lab(yes_no_np_dnk_nr_list)

*PNL_004. When do you think you will start using a method?
label define fp_start_when_list 1 "0_to_1" 2 "1_to_2" 3 "2_plus" -99 "-99"
encode fp_start_when, gen(fp_start_whenv2) lab(fp_start_when_list)
label define fp_start_when_list 1 "less than 12 months" 2 "1 or 2 years" 3 "more than 2 years" -99 "-99", replace

*PNL_005. Would your husband/partner be supportive of you using family planning?
encode partner_supportive_future, gen(partner_supportive_futurev2) lab(yes_no_np_dnk_nr_list) 

*PNL_007. According to the provider, what are the possible side effects or problems related to the use of this method?
split fp_side_effects_what, gen(fp_side_effects_what_)
local x=r(nvars)
foreach var in bleed_less bleed_more bleed_irreg spotting uterine_cramping weight_gain ///
weight_loss facial_spotting headache infection nausea morecramping fert_delay libido ///
vag_dryness infertility fp_lost weakness diarrhea other {
gen fsew_`var'=0 if fp_side_effects_what!="" & fp_side_effects_what!="-99" & fp_side_effects_what!="-88"
forval y=1/`x' {
replace fsew_`var'=1 if fp_side_effects_what_`y'=="`var'"
label val fsew_`var' yes_no_dnk_nr_list
label var fsew_`var' "Side effects told by provider: `var'"
}
}
drop fp_side_effects_what_*
order fsew_bleed_less-fsew_other, after(fp_side_effects_what)

*PNL_009. Which method did you use most recently?
encode ever_rec_method, gen(ever_rec_methodv2) lab(methods_list)

*PNL_010. When did you stop using ${ever_rec_method}?
encode ever_rec_method_stop_lab, gen(ever_rec_method_stop_labv2) lab(dwmy_list)
destring ever_rec_method_stop_value, replace

*PNL_014. What side-effects have you experienced?
split side_effects_exp, gen(side_effects_exp_)
local x=r(nvars)
foreach var in bleed_less bleed_more bleed_irreg spotting uterine_cramping weight_gain ///
weight_loss facial_spotting headache infection nausea morecramping fert_delay libido ///
vag_dryness infertility fp_lost weakness diarrhea other {
gen see_`var'=0 if side_effects_exp!="" & side_effects_exp!="-99" & side_effects_exp!="-88"
forval y=1/`x' {
replace see_`var'=1 if side_effects_exp_`y'=="`var'"
label val see_`var' yes_no_dnk_nr_list
label var see_`var' "Side effects experienced: `var'"
}
}
rename side_effects_exp_method method_side_effects_exp
rename side_effects_exp_yn yn_side_effects_exp
drop side_effects_exp_*
order see_bleed_less-see_other, after(side_effects_exp)


*PNL_015. What method or methods of contraception were you using when you experienced these side effects?
rename method_side_effects_exp side_effects_exp_method 
split side_effects_exp_method, gen(side_effects_exp_method_)
local x=r(nvars)
foreach var in female_sterilization male_sterilization implants IUD injectables pill ///
emergency male_condoms female_condoms diaphragm foam beads LAM rhythm withdrawal {
gen see_`var'=0 if side_effects_exp_method!="" & side_effects_exp_method!="-99" & side_effects_exp_method!="-88"
forval y=1/`x' {
replace see_`var'=1 if side_effects_exp_method_`y'=="`var'"
label val see_`var' yes_no_dnk_nr_list
label var see_`var' "Method used when having side effects: `var'"
}
}
drop side_effects_exp_method_*
order see_bleed_less-see_other, after(side_effects_exp_method)

*PNL_016a. Which side effects are you currently experiencing?
split which_side_effect_now, gen(which_side_effect_now_)
local x=r(nvars)
foreach var in bleed_less bleed_more bleed_irreg spotting uterine_cramping weight_gain ///
weight_loss facial_spotting headache infection nausea morecramping fert_delay libido ///
vag_dryness infertility fp_lost weakness diarrhea other {
gen wsen_`var'=0 if which_side_effect_now!="" & which_side_effect_now!="-99" & which_side_effect_now!="-88"
forval y=1/`x' {
replace wsen_`var'=1 if which_side_effect_now_`y'=="`var'"
label val wsen_`var' yes_no_dnk_nr_list
label var wsen_`var' "Side effects have now: `var'"
}
}
drop which_side_effect_now_*
order wsen_bleed_less-wsen_other, after(which_side_effect_now)

*PNL_017. Whom did you talk to about the side effects you experienced?
split fp_side_effects_spoken, gen(fp_side_effects_spoken_)
local x=r(nvars)
foreach var in spouse mother father mother_in_law sister daughter other_f_relative ///
male_relative friend chw facility_hw pharma trad_healer other no_one {
gen fses_`var'=0 if fp_side_effects_spoken!="" & fp_side_effects_spoken!="-99" & fp_side_effects_spoken!="-88"
forval y=1/`x' {
replace fses_`var'=1 if fp_side_effects_spoken_`y'=="`var'"
label val fses_`var' yes_no_dnk_nr_list
label var fses_`var' "Spoke side effect to: `var'"
}
}
drop fp_side_effects_spoken_*
order fses_spouse-fses_no_one, after(fp_side_effects_spoken)

*PNL_018. Whose advice was the most important to you when you were talking about side effects?
label define fp_side_effects_spoken_list 1 spouse 2 mother 3 father 4 mother_in_law 5 sister ///
6 daughter 7 other_f_relative 8 male_relative 9 friend 10 chw 11 facility_hw 12 pharma 13 trad_healer 96 other ///
0 no_one -88 "-88" -88 "-99"
encode fp_side_effects_impt_advice, gen(fp_side_effects_impt_advicev2) lab(fp_side_effects_spoken_list)

*PNL_019. Have you experienced any of the following changes in your menstrual period since you have started using your current method?
split current_method_prd_chng, gen(current_method_prd_chng_)
local x=r(nvars)
foreach var in bleed_less bleed_more bleed_irreg spotting nochanges other {
gen cmpc_`var'=0 if current_method_prd_chng!="" & current_method_prd_chng!="-99" & current_method_prd_chng!="-88"
forval y=1/`x' {
replace cmpc_`var'=1 if current_method_prd_chng_`y'=="`var'"
label val cmpc_`var' yes_no_dnk_nr_list
label var cmpc_`var' "Experienced change in period: `var'"
}
}
rename current_method_prd_chng_wry wry_current_method_prd_chng
drop current_method_prd_chng_*
order cmpc_bleed_less-cmpc_other, after(current_method_prd_chng)

*PNL_020. How worried are you about these changes?
rename wry_current_method_prd_chng current_method_prd_chng_wry 
label define worry_3_top_list 0 none 1 a_little 2 very -99 "-99"
encode current_method_prd_chng_wry, gen(current_method_prd_chng_wryv2) lab(worry_3_top_list)

*encode all yes no questions together 
rename yn_side_effects_exp side_effects_exp_yn 
foreach var in fp_prior_exp fp_stopped_unsatisf current_method_satisf ///
side_effects_exp_yn fp_side_effects_now pill_preg_provider inj_preg_provider ///
fp_side_effects_told_other {
encode `var', gen(`var'v2) lab(yes_no_dnk_nr_list)
}

*encode all agree list together
label define agree_4_top_list 1 "strongly_disagree" 2 "somewhat_disagree" 3 "somewhat_agree" 4 "strongly_agree" -99 "-99"
foreach var in agree_fp_effective agree_infertility agree_no_period_unhealthy ///
agree_fp_conflict agree_beauty_preserve agree_ok_before_children {
encode `var', gen(`var'v2) lab(agree_4_top_list)
}

unab vars: *v2
local stubs: subinstr local vars "v2" "", all
foreach var in `stubs'{
rename `var' `var'QZ
order `var'v2, after(`var'QZ)
}
rename *v2 *
drop *QZ

*label all vars
label var partner_want_kid_2yr_yn "Partner wants a/another child in 2 years"
label var preg_problematic "If find yourself pregnant in next few weeks, problematic"
label var partner_supportive_now "Is your partner supportive of you using FP"
label var fp_start_when "When do you think will start using FP method"
label var partner_supportive_future "Would your partner support you using FP"
label var fp_prior_exp "Provider asked prior experience with FP when obtained current FP"
label var fp_side_effects_what "Possible side effects using this FP by provider"
label var fp_side_effects_told_other "Told if have side effects can switch FP"
label var pill_preg_provider "Provider told higher pregnancy if don't take pills daily"
label var inj_preg_provider "Provider told higher pregnancy if late for injection"
label var ever_rec_method "FP method used most recently"
label var ever_rec_method_stop "When did you stop using the most recent method"
label var ever_rec_method_stop_value "When did you stop using the most recent method"
label var fp_stopped_unsatisf "Ever stop using FP because not satisfied"
label var current_method_satisf "Satisfied with current method"
label var side_effects_exp_yn "Ever had side effects from FP"
label var side_effects_exp "What side effects have you experienced"
label var side_effects_exp_method "What method used when had side effects"
label var fp_side_effects_now "Currently have any side effects"
label var which_side_effect_now "Which side effects"
label var fp_side_effects_spoken "Talk to whom about side effects"
label var fp_side_effects_impt_advice "Whose advice most important about side effects"
label var current_method_prd_chng "Experienced any change in period since current method"
label var current_method_prd_chng_wry "How worried are you about these changes"
label var agree_fp_effective "If use FP, can have sex without worrying pregnancy"
label var agree_infertility "If use FP, women won't get pregnant when needed"
label var agree_no_period_unhealthy "Unhealthy if no periods when using FP"
label var agree_fp_conflict "Use FP creates conflict in a couple"
label var agree_beauty_preserve "Beauty won't last if using FP"
label var agree_ok_before_children "Acceptable to use FP before having children"
















