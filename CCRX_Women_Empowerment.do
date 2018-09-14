/*******************************************************************************
*
*  FILENAME:	CCRX_Women_Empowerment_v1_$date.do
*  PURPOSE:		Label and encode Women and girls empowerment questions
*  CREATED:		Shulin Jiang (sjiang19@jhu.edu)
*  DATA IN:		CCRX_Combined_$date.dta
*  DATA OUT:	CCRX_Combined_$date.dta
*  UPDATES:		
*******************************************************************************/

capture label drop agree_4_list
label define agree_4_list 1 "1" 2 "2" 3 "3" 4 "4" -99 "-99"

capture label drop capable_4_list
label define capable_4_list 1 "1" 2 "2" 3 "3" 4 "4" -99 "-99"

*WGE501. If I didn’t want to have sex, I could tell my husband/partner
encode sex_tell, gen(sex_tellv2) lab(agree_4_list)

*WGE502. If I don’t want to have sex, I am capable of avoiding it with my husband/partner.
encode sex_avoid, gen(sex_avoidv2) lab(capable_4_list)

*WGE503. If I want to use contraception, I can tell my husband/partner I am using it.
encode contraception_tell, gen(contraception_tellv2) lab(agree_4_list)

*WGE504. If I want to use contraception, I am capable of using it when I want.
encode contraception_capable, gen(contraception_capablev2) lab(capable_4_list)

label define capable_4_list 1 "not at all capable" 2 "somewhat capable" 3 "capable" 4 "very capable", replace
label define agree_4_list 1 "strongly disagree" 2 "disagree" 3 "agree" 4 "strongly agree", replace

foreach var in sex_tell sex_avoid contraception_tell contraception_capable {
	recode `var'v2 5=.
	order `var'v2, after(`var')
	drop `var'
	rename `var'v2 `var'
	}

label var sex_tell "Can tell partner if don't want sex"
label var sex_avoid "Capable of avoiding sex with partner if don't want sex"
label var contraception_tell "Can tell partner if using contraception"
label var contraception_capable "Capable of using contraception when wanted"

save,replace
