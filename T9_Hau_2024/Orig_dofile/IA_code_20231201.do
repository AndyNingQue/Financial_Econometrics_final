*** 20231221 updated
*** code for Internet Appendix

*Table IA1
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

*Panel A
foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

ivreghdfe `var' delta (is_admission=above_480), first a(mon_full ind) cluster(ind) 
outreg2 using IA_T1A.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y) 
}

*Panel B-E
global name "age_rank dispersion durability property"

foreach i of global name {

gen ab480_`i'=above_480*`i'
gen s_`i'=is_admission*`i'

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

ivreghdfe `var' (is_admission s_`i' = above_480 ab480_`i') `i' delta, a(mon_full ind) cluster(ind) 
outreg2 using IA_T1B-D_`i'.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y) 

}
}


*Table IA2
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

foreach var of varlist lp4p_fin_price_3m_aft1f_w lonline_prod_cnt_aft1f_w crate3f_w {

ivreghdfe `var' delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
outreg2 using IA_T2.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y) 

}

*Table IA3

*Panel A
use m_460500_xl_pseudo,clear

keep if is_admission==is_admission_aft1 & is_admission_aft1==is_admission_aft12

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

foreach var of varlist d_sales_aft12_b1_w d_lntrans_aft12_b1_w dsr_zl_mm_aft12 dsr_fw_mm_aft12 dsr_fh_mm_aft12 {

ivreghdfe `var' delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
outreg2 using IA_T3A.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y) 

}

*Panel B
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

foreach var of varlist dsr_zl_mm_p1m1_wl dsr_fw_mm_p1m1_wl dsr_fh_mm_p1m1_wl {

ivreghdfe `var' delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
outreg2 using IA_T3B.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y) 
}

*Panel C
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480
gen t_delta=above_480*delta

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

ivreghdfe `var' delta t_delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
outreg2 using IA_T3C.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y)  

}

*Panel D
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480
gen delta_p2=(tb_creditpd_score_last1-480)^2

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

ivreghdfe `var' delta delta_p2 (is_admission=above_480), a(mon_full ind) cluster(ind) 
outreg2 using IA_T3D.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y)  

}

*Panel E
use m_460500_xl_pseudo,clear

keep if tb_creditpd_score_last1>=465&tb_creditpd_score_last1<=495

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

ivreghdfe `var' delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
outreg2 using IA_T3E.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y)  

}

*Panel F
use m_460500_xl_pseudo,clear

keep if tb_creditpd_score_last1>=470&tb_creditpd_score_last1<=490

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

foreach var of varlist d_sales_aft1_b1_w d_lntrans_aft1_b1_w dsr_zl_mm_aft1_wl dsr_fw_mm_aft1_wl dsr_fh_mm_aft1_wl {

ivreghdfe `var' delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
outreg2 using IA_T3F.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y)  

}

*Table IA4
use m_460500_xl_pseudo,clear

gen above_480=(tb_creditpd_score_last1>=480)
gen delta=tb_creditpd_score_last1-480

foreach var of varlist d_sales_aft123456_b1 d_lntrans_aft123456_b1 dsr_zl_mm_aft123456 dsr_fw_mm_aft123456 dsr_fh_mm_aft123456 ///
lp4p_fin_price_3m_aft123456f lonline_prod_cnt_aft123456f crate3_aft123456f {

ivreghdfe `var' delta (is_admission=above_480), a(mon_full ind) cluster(ind) 
outreg2 using IA_T4.xls, tstat bdec(4) tdec(2) adjr addstat(KP-rk, e(rkf)) addtext(Firm-type FE, Y, Time FE, Y) 

}

