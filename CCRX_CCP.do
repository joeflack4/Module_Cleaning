/*******************************************************************************
*
*  FILENAME:	CCRX_CCP_v#_$date.do
*  PURPOSE:		Label and encode implant removal questions
*  CREATED:		Shulin Jiang (sjiang19@jhu.edu)
*  DATA IN:		CCRX_Combined_$date.dta
*  DATA OUT:	CCRX_Combined_$date.dta
*  UPDATES:		
*******************************************************************************/

*CCP_301. Have you heard about the radio program called “Ireti Eda”?
encode ccp_ireti_eda_yn, gen(ccp_ireti_eda_ynv2) lab(yes_no_dnk_nr_list)

*CCP_302. In the last six months, did you listen to the radio program called “Ireti Eda”?
label define ccp_radio_list 0 "no" 1 "yes" -77 "-77" -88 "-88" -99 "-99"
encode ccp_ireti_eda_6mo, gen(ccp_ireti_eda_6mov2) lab(ccp_radio_list)
label define ccp_radio_list 0 "no" 1 "yes" -77 "Doesn't listen to radio" -88 "-88" -99 "-99", replace

*CCP_303. What are the key messages of the radio program? That is, what did you learn from the radio program?


*CCP_304. Have you heard about a television drama series called “Newman street”?
encode ccp_newman_st_yn, gen(ccp_newman_st_ynv2) lab(yes_no_dnk_nr_list)

*CCP_305. In the last six months did you watch any episodes of the television drama series? 
label define ccp_tv_list 0 "no" 1 "yes" -77 "-77" -88 "-88" -99 "-99"
encode ccp_newman_st_6mo, gen(ccp_newman_st_6mov2) lab(ccp_tv_list)
label define ccp_tv_list 0 "no" 1 "yes" -77 "Doesn't watch TV" -88 "-88" -99 "-99", replace

*CCP_306. What are the key messages of the television drama series? That is, what did you learn from the drama series?

*CCP_307a. Have you heard on the radio or seen on the television a jingle or spot with people talking about family planning during a naming ceremony?
encode ccp_ceremony_yn, gen(ccp_ceremony_ynv2) lab(yes_no_dnk_nr_list)

*CCP_307b. Did you hear it on radio, see it on television or on both radio and television.
label define ccp_radio_tv_list 1 "radio" 2 "tv" 3 "both" -99 "-99"
encode ccp_ceremony_how, gen(ccp_ceremony_howv2) lab(ccp_radio_tv_list)

*CCP_308a. Have you heard on the radio or seen on the television a jingle or spot with people talking about family planning in a hairdressing salon? 
encode ccp_hairdressing_salon_yn, gen(ccp_hairdressing_salon_ynv2) lab(yes_no_dnk_nr_list)

*CCP_308b. Did you hear it on radio, see it on television or on both radio and television.
encode ccp_hairdressing_salon_how, gen(ccp_hairdressing_salon_howv2) lab(ccp_radio_tv_list)

*CCP_309a. Have you heard on the radio or seen on the television a jingle or spot with people talking about family planning in a barbing salon? 
encode ccp_barbing_salon_yn, gen(ccp_barbing_salon_ynv2) lab(yes_no_dnk_nr_list)

*CCP_309b. Did you hear it on radio, see it on television or on both radio and television.
encode ccp_barbing_salon_how, gen(ccp_barbing_salon_howv2) lab(ccp_radio_tv_list)

*CCP_310a. Have you heard on the radio or seen on the television a jingle or spot with a couple talking to each other about family planning? 
encode ccp_couple_yn, gen(ccp_couple_ynv2) lab(yes_no_dnk_nr_list)

*CCP_310b. Did you hear it on radio, see it on television or on both radio and television.
encode ccp_couple_how, gen(ccp_couple_howv2) lab(ccp_radio_tv_list)

*CCP_311a. Have you heard on the radio or seen on the television a song on family planning by Paul Okoye and Tiwa Savage?
encode ccp_okoye_savage_yn, gen(ccp_okoye_savage_ynv2) lab(yes_no_dnk_nr_list)

*CCP_311b. Did you hear it on radio, see it on television or on both radio and television.
encode ccp_okoye_savage_how, gen(ccp_okoye_savage_howv2) lab(ccp_radio_tv_list)


***
unab vars: *v2
local stubst: subinstr local vars "v2" "", all
foreach var in `stubst'{
rename `var' `var'SJ
order `var'v2, after (`var'SJ)
}
rename *v2 *
drop *SJ

label var ccp_ireti_eda_yn "Heard about radio program Ireti Eda"
label var ccp_ireti_eda_6mo "Listen to Ireti Eda in last 6months"
label var ccp_ireti_eda_learned "Key messages of Ireti Eda"
label var ccp_newman_st_yn "Heard about TV series Newman Street"
label var ccp_newman_st_6mo "Watch any episodes of Newman Street"
label var ccp_newman_st_learned "Key messages of Newman Street"
label var ccp_ceremony_yn "From radio/TV: People discuss FP in naming ceremony"
label var ccp_ceremony_how "radio,TV or both: People discuss FP in naming ceremony"
label var ccp_hairdressing_salon_yn "From radio/TV: People discuss FP in hair salon"
label var ccp_hairdressing_salon_how "radio,TV or both: People discuss FP in hair salon"
label var ccp_barbing_salon_yn "From radio/TV: People discuss FP in barbing salon"
label var ccp_barbing_salon_how "radio,TV or both: People discuss FP in barbing salon"
label var ccp_couple_yn "From radio/TV: A couple discuss FP"
label var ccp_couple_how "radio,TV or both: A couple discuss FP"
label var ccp_okoye_savage_yn "From radio/TV: Heard song on FP by Okoye&Savage"
label var ccp_okoye_savage_how "radio,TV or both: Heard song on FP by Okoye&Savage"

save, replace

