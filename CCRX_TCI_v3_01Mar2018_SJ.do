
********************************************************************************
* TCI Module
* First used in KER5
* Created by SJ
********************************************************************************
local CCRX $CCRX
*use `CCRX'_Combined_$date.dta, clear


/*TCI_301a. Have you or your partner faced any challenges in obtaining ${current_best_method_label}?
capture label define yes_no_dnk_nr_tci_list 0 "no" 1 "yes" -88 "Do not know/partner obtains method" -99 "-99"
encode method_challenges_present, gen(method_challenges_presentv2) lab(yes_no_dnk_nr_tci_list)
*/

/*TCI_301b. What challenges have you faced in obtaining ${current_best_method_label}?
split method_challenges, gen(method_challenges_)
local x=r(nvars)
foreach var in fear_partner fear_relative work no_childcare transport_cost distance closed ///
cost wait_time stock_out provider_away unfriendly {
gen mc_`var'=0 if method_challenges!="" & method_challenges!="-99" //SJ:consider "other" here?
forval y=1/`x' {
replace mc_`var'=1 if method_challenges_`y'=="`var'"
label val mc_`var' yes_no_dnk_nr_list
}
}
drop method_challenges_*
order mc_fear_partner-mc_unfriendly, after(method_challenges)


*TCI_302. Besides you and your husband/partner, who else influences the decision to use a family planning method?
split method_influences_pro, gen(method_influences_pro_)
local x=r(nvars)
foreach var in mother mother_in_law sisters sisters_in_law grandmother friend health_worker ///
community_leader religious_leader aunt other_relatives {
gen mip_`var'=0 if method_influences_pro!="" & method_influences_pro!="-99" & method_influences_pro!="-77" //SJ:consider "other" here?
forval y=1/`x' {
replace mip_`var'=1 if method_influences_pro_`y'=="`var'"
label val mip_`var' yes_no_dnk_nr_list
}
}
drop method_influences_pro_*
order mip_mother-mip_other_relatives, after(method_influences_pro)
*/

*TCI_302x. In the last 12 months, have you recommended any family planning method to your friends and/or relatives?
*encode method_recommendations_given, gen(method_recommendations_givenv2) lab(yes_no_dnk_nr_list)
encode method_recommendations_given_cc, gen(method_recommend_given_ccv2) lab(yes_no_dnk_nr_list)
rename method_recommendations_given_cc method_recommend_given_cc

*TCI_303. Why did you choose the facility where you received your most recent/current FP method? 
//SJ:ODK missing service_free; ODK has home_far but not in paper; treat_well --> vague meaning to me; 

split facility_chosen, gen(facility_chosen_)
local x=r(nvars)
foreach var in home_close convenient hours privacy reputation staff_discreet affordable home_far ///
services_good services_desired insurance treated_well youth_group chw_referral provider_referral ///
friend_referral loudspeaker drama {
gen fc_`var'=0 if facility_chosen!="" & facility_chosen!="-99" & facility_chosen!="-88" //SJ:consider "other" here?
forval y=1/`x' {
replace fc_`var'=1 if facility_chosen_`y'=="`var'"
label val fc_`var' yes_no_dnk_nr_list
}
}
drop facility_chosen_*
order fc_home_close-fc_drama, after(facility_chosen)


/*TCI_304. Besides you and your husband/partner, who else influences the decision 
**not to use a family planning method?
split method_influences_con, gen(method_influences_con_)
local x=r(nvars)
foreach var in mother mother_in_law sisters sisters_in_law grandmother friend health_worker ///
community_leader religious_leader aunt other_relatives {
gen mic_`var'=0 if method_influences_con!="" & method_influences_con!="-99" & method_influences_con!="-77" //SJ:consider "other" here?
forval y=1/`x' {
replace mic_`var'=1 if method_influences_con_`y'=="`var'"
label val mic_`var' yes_no_dnk_nr_list
}
}
drop method_influences_con_*
order mic_mother-mic_other_relatives, after(method_influences_con)
*/

*TCI_304x. In the last 12 months, has a friend and/or relative recommended that you use a family planning method?
rename method_recommendations_received method_recommend_received
encode method_recommend_received, gen(method_recommend_receivedv2) lab(yes_no_dnk_nr_list)

*TCI_305. Have you attended a community event in the last year where family planning was favorably discussed?
encode community_event_attended, gen(community_event_attendedv2) lab(yes_no_dnk_nr_list)


*TCI_306. Do you think there are some people within this community who will call you 
**bad names or avoid your company if they knew that you were using a family planning method? //SJ: maybe add "neutral"?
encode personal_perception_neg, gen(personal_perception_negv2) lab(yes_no_dnk_nr_list)


*TCI_307. Do you think there are some people within this community who will praise, 
**encourage, or talk favorably about you if they knew that you were using a family planning method?
encode personal_perception_pos, gen(personal_perception_posv2) lab(yes_no_dnk_nr_list)


/*TCI_308. In the past 12 months, have you heard any of the following people speaking
** publicly in favor of family planning?
split public_leader_influence_pro, gen(public_leader_influence_pro_)
local x=r(nvars)
foreach var in govt local religious {
gen plip_`var'=0 if public_leader_influence_pro!="" & public_leader_influence_pro!="-99" & public_leader_influence_pro!="-77"
forval y=1/`x' {
replace plip_`var'=1 if public_leader_influence_pro_`y'=="`var'"
label val plip_`var' yes_no_dnk_nr_list
}
}
drop public_leader_influence_pro_*
order plip_govt-plip_religious, after(public_leader_influence_pro)


*TCI_309. In the past 12 months, have you heard any of the following people speaking 
** publicly against family planning?
split public_leader_influence_con, gen(public_leader_influence_con_)
local x=r(nvars)
foreach var in govt local religious {
gen plic_`var'=0 if public_leader_influence_con!="" & public_leader_influence_con!="-99" & public_leader_influence_con!="-77"
forval y=1/`x' {
replace plic_`var'=1 if public_leader_influence_con_`y'=="`var'"
label val plic_`var' yes_no_dnk_nr_list
}
}
drop public_leader_influence_con_*
order plic_govt-plic_religious, after(public_leader_influence_con)
*/

*TCI_309x. How many of your close friends and relatives do you think use family planning: none, some, most, or all?
label define nsm_list 1 "none" 2 "some" 3 "most" 4 "all"
encode (usage_perception), gen(usage_perceptionv2) lab(nsm_list)

*TCI_310. Read about family planning in a brochure, leaflet, or flyer? 
capture rename fp_ad_brochure_leaflet_ fp_ad_brochure_leaflet_flyer
encode (fp_ad_brochure_leaflet_flyer), gen(fp_ad_brochure_leaflet_flyerv2) lab(yes_no_dnk_nr_list)


*TCI_311. Seen a poster or billboard with a family planning message? 
encode (fp_ad_poster_billboard), gen(fp_ad_poster_billboardv2) lab(yes_no_dnk_nr_list)


***
unab vars: *v2
local stubst: subinstr local vars "v2" "", all
foreach var in `stubst'{
rename `var' `var'SJ
order `var'v2, after (`var'SJ)
}
rename *v2 *
drop *SJ
rename method_recommend_received method_recommendations_received
rename method_recommend_given_cc method_recommendations_given_cc

***Label all TCI vars //SJ: do we label the binaries broken down from select-multiple?
capture label var method_challenges_present "Faced any challenge obtaining current best fp method"
capture label var method_challenges "Challanges faced obtaining current best fp method"
capture label var method_influences_pro "Who else influences decision to use fp method"
capture label var facility_chosen_because "Why choose the facility where received most recent fp method"
capture label var method_influences_con "Who else influences decision NOT to use fp method"
capture label var community_event_attended "Attended a community event where fp was favored"
capture label var personal_perception_neg "Anyone in community against you if you use fp"
capture label var personal_perception_pos "Anyone in community favors you if you use fp"
capture label var public_leader_influence_pro "Heard following people speak in favor of fp in past 12mo"
capture label var public_leader_influence_con "Heard following people speak against fp in past 12mo"
capture label var fp_ad_brochure_leaflet_flyer "Read about fp in a brochure, leaflet, or flyer"
capture label var fp_ad_poster_billboard "Seen a poster or billboard with a fp message"
capture label var method_recommendations_given_cc "Have you recommended fp method to family/friend"
capture label var method_recommendations_received "Have you received fp method from family/friend"
//revision: sj 3/1
capture label var facility_chosen "Why choose the facility you received the recent/current FP method"
capture label var usage_perception "How many of your close friends & relatives do you think uses FP"


save, replace



