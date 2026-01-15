***(20231205 updated) "FinTech Credit and Entrepreneurial Growth" regression code
*** This file contains the code for the captioned paper.
*** The code was applied to the original datasets stored on the local workstation at Ant Financial in Hangzhou, China.
*** For illustration, we apply the code to psuedo datasets, because the original datasets are proprietary and confidential, 
*** and can only be accessed physically on the local workstation mentioned above.
*** The pseudo datasets are constructed only for demonstrating the functionality of the code, not for replicating the results.

/*********************************************************Preparation (optional)*****************************************************/

/*install/update the following packages*/
cap ado uninstall ivreg2
ssc install ivreg2

cap ado uninstall ftools
net install ftools, from("https://raw.githubusercontent.com/sergiocorreia/ftools/master/src/")

cap ado uninstall reghdfe
net install reghdfe, from("https://raw.githubusercontent.com/sergiocorreia/reghdfe/master/src/")

cap ado uninstall ivreghdfe
net install ivreghdfe, from(https://raw.githubusercontent.com/sergiocorreia/ivreghdfe/master/src/)

/*update the route*/ 
cd "D:\..." 

/***********************************************************************************************************************************/


/*********************************************************Regressions***************************************************************/

*** Table 2 ***
use city_2005,clear
global control "bank_pop_soe_dm bank_pop soe_output_pct loans2gdpf gdppc population digital_index"

reg ld_num_exist_2015 $control, vce(robust) 
outreg2 using T2.xls, tstat bdec(4) tdec(2)  

use city_2015,clear
global control "bank_pop_soe_dm bank_pop soe_output_pct loans2gdpf gdppc population digital_index"

reg ln_creditamt_ttl_mon_mean $control, vce(robust)
outreg2 using T2.xls, tstat bdec(4) tdec(2)  

reg ln_credituse_ttl_mon_mean $control, vce(robust)
outreg2 using T2.xls, tstat bdec(4) tdec(2)  


*** Table 3 ***
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

*A. report 1st and 2nd stage results
reghdfe is_admission above_480 delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T3A.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

predict prediction_d 

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {
reghdfe `var' prediction_d delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T3B.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)
} 

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft1_b1_w delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Table 4-5 ***
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

global name "age_rank dispersion durability property"

foreach i of global name {

gen ab480_`i'=above_480*`i'
gen s_`i'=is_admission*`i'

reghdfe is_admission above_480 ab480_`i' `i' delta, keepsin a(mon_full ind) cluster(ind)

predict prediction_d

reghdfe s_`i' above_480 ab480_`i' `i' delta, keepsin a(mon_full ind) cluster(ind)

predict d_`i'

*A. report 2nd stage results
foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

reghdfe `var' d_`i' prediction_d `i' delta, keepsin a(mon_full ind) cluster(ind)

outreg2 using T4&5_`i'.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

}

drop prediction_d

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft1_b1_w (is_admission s_`i' = above_480 ab480_`i') `i' delta, a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf) /*Warning message would arise for "durability" as it is colinear with ind FE - can be resolved by dropping `durability' from the regression*/

}
 
 
*** Table 6 ***
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

*A. report 2nd stage results
reghdfe is_admission above_480 delta, keepsin a(mon_full ind) cluster(ind)
predict prediction_d

foreach var of varlist lp4p_fin_price_3m_aft1f_w lonline_prod_cnt_aft1f_w crate3f_w {

reghdfe `var' prediction_d delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T6.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

} 

*B. report KP-rk statistic
qui: ivreghdfe lp4p_fin_price_3m_aft1f_w delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Table 7 Panel A - Consecutive Treatment ***
use m_460500_xl_pseudo,clear

keep if is_admission==is_admission_aft1 & is_admission_aft1==is_admission_aft12

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

*A. report 2nd stage results
foreach var of varlist d_sales_aft12_b1_w d_lntrans_aft12_b1_w dsr_zl_mm_aft12 dsr_fw_mm_aft12 dsr_fh_mm_aft12 {

reghdfe is_admission above_480 delta if ~missing(`var'), keepsin a(mon_full ind) cluster(ind)
predict prediction_d 

reghdfe `var' prediction_d delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T7A.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

drop prediction_d
} 

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft12_b1_w delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)

qui: ivreghdfe dsr_zl_mm_aft12 delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Table 7 Panel B - Change in DSR Ratings ***
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

*A. report 2nd stage results
foreach var of varlist dsr_zl_mm_p1m1_wl dsr_fw_mm_p1m1_wl dsr_fh_mm_p1m1_wl {

reghdfe is_admission above_480 delta if ~missing(`var'), keepsin a(mon_full ind) cluster(ind)
predict prediction_d 

reghdfe `var' prediction_d delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T7B.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

drop prediction_d

} 

*B. report KP-rk statistic
qui: ivreghdfe dsr_zl_mm_p1m1_wl delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Table 7 Panel C - Differential Right and Left Slopes for the Credit Score Variable ***
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480
gen t_delta=above_480*delta

*A. report 2nd stage results
reghdfe is_admission above_480 delta t_delta, keepsin a(mon_full ind) cluster(ind)
predict prediction_d

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

reghdfe `var' prediction_d delta t_delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T7C.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

}

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft1_b1_w delta t_delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Table 7 Panel D - Second-Order Polynomial for the Credit Score Variable ***
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480
gen delta_p2=(tb_creditpd_score_last1-480)^2

*A. report 2nd stage results
reghdfe is_admission above_480 delta delta_p2, keepsin a(mon_full ind) cluster(ind)
predict prediction_d

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

reghdfe `var' prediction_d delta delta_p2, keepsin a(mon_full ind) cluster(ind)
outreg2 using T7D.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

}

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft1_b1_w delta delta_p2 (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Table 7 Panel E - Alternative Bandwidth [465, 495] ***
use m_460500_xl_pseudo,clear

keep if tb_creditpd_score_last1>=465&tb_creditpd_score_last1<=495

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

*A. report 2nd stage results
reghdfe is_admission above_480 delta, keepsin a(mon_full ind) cluster(ind)
predict prediction_d

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

reghdfe `var' prediction_d delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T7E.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

}

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft1_b1_w delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Table 7 Panel F - Alternative Bandwidth [470, 490] ***
use m_460500_xl_pseudo,clear

keep if tb_creditpd_score_last1>=470&tb_creditpd_score_last1<=490

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

*A. report 2nd stage results
reghdfe is_admission above_480 delta, keepsin a(mon_full ind) cluster(ind)
predict prediction_d

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

reghdfe `var' prediction_d delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T7F.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

}

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft1_b1_w delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Table 8 ***
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

*A. report 2nd stage results
foreach var of varlist d_sales_aft123456_b1 d_lntrans_aft123456_b1 dsr_zl_mm_aft123456 dsr_fw_mm_aft123456 dsr_fh_mm_aft123456 ///
lp4p_fin_price_3m_aft123456f lonline_prod_cnt_aft123456f crate3_aft123456f {

reghdfe is_admission above_480 delta if ~missing(`var'), keepsin a(mon_full ind) cluster(ind)
predict prediction_d

reghdfe `var' prediction_d delta, keepsin a(mon_full ind) cluster(ind)
outreg2 using T8.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

drop prediction_d

} 

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft123456_b1 delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)

qui: ivreghdfe dsr_zl_mm_aft123456 delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)


*** Appendix Table A2 & A3 ***
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

global name "distribution_cost legal_index" 

foreach i of global name {

gen ab480_`i'=above_480*`i'
gen s_`i'=is_admission*`i'

reghdfe is_admission above_480 ab480_`i' `i' delta, keepsin a(mon_full ind) cluster(ind)

predict prediction_d

reghdfe s_`i' above_480 ab480_`i' `i' delta, keepsin a(mon_full ind) cluster(ind)

predict d_`i'

*A. report 2nd stage results
foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

reghdfe `var' d_`i' prediction_d `i' delta, keepsin a(mon_full ind) cluster(ind)

outreg2 using Appendix_TA2&3_`i'.xls, tstat bdec(4) tdec(2) adjr addtext(Firm-type FE, Y, Time FE, Y)

}

drop prediction_d

*B. report KP-rk statistic
qui: ivreghdfe d_sales_aft1_b1_w (is_admission s_`i' = above_480 ab480_`i') `i' delta, a(mon_full ind) cluster(ind) 
di "KP-rk statistic is " e(rkf)

}
