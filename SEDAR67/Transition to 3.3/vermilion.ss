#V3.30
#_data_and_control_files: vermilion.dat // vermilion.ctl
#_SS-V3.24Y-safe;_08/27/2015;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_11.1x64
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#
4 # recr_dist_method for parameters:  2=main effects for GP, Settle timing, Area; 3=each Settle entity; 4=none when N_GP*Nsettle*pop==1							
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area							
1 #  number of recruitment settlement assignments 							
0 # unused option
#GPattern month  area  age (for each settlement assignment)							
 1 1 1 0
#							
#_Cond 0 # N_movement_definitions goes here if Nareas > 1							
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0							
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10							
#	
1 #_Nblock_Patterns
 1 #_blocks_per_pattern 
# begin and end years of blocks
 2007 2014
#
# controls for all timevary parameters 							
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)							
#  autogen							
1 0 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex							
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345							
# 							
#							
# setup for M, growth, maturity, fecundity, recruitment distibution, movement 							
#							
3 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
 #_Age_natmort_by gender x growthpattern
 0.234 0.342 0.287 0.257 0.239 0.228 0.22 0.215 0.212 0.209 0.207 0.206 0.205 0.204 0.204
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_speciific_K; 4=not implemented
0.5 #_Growth_Age_for_L1
999 #_Growth_Age_for_L2 (999 to use as Linf)						
-999 #_exponential decay for growth above maxage (fixed at 0.2 in 3.24; value should approx initial Z; -999 replicates 3.24)							
0  #_placeholder for future growth feature							
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)							
1 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)							
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity							
1 #_First_Mature_Age							
2 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W							
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn							
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)							
#							
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr	dev_maxyr dev_PH Block Block_Fxn		
0.0001	1.00E+06	11.83	11.83	0	0	-1	0	0	0	0	0	0	0	#	L_at_Amin_Fem_GP_1
0.0001	1.00E+06	34.4	34.4	0	0	-1	0	0	0	0	0	0	0	#	L_at_Amax_Fem_GP_1
0	1.00E+06	0.3254	0.3254	0	0	-1	0	0	0	0	0	0	0	#	VonBert_K_Fem_GP_1
0	1.00E+06	0.2535	0.0001	0	0	-1	0	0	0	0	0	0	0	#	CV_young_Fem_GP_1
0	1.00E+06	0.2535	0.0001	0	0	-1	0	0	0	0	0	0	0	#	CV_old_Fem_GP_1
0	1.00E+06	2.19E-05	2.19E-05	0	0	-1	0	0	0	0	0	0	0	#	Wtlen_1_Fem
0	1.00E+06	2.916	2.916	0	0	-1	0	0	0	0	0	0	0	#	Wtlen_2_Fem
0	1.00E+06	14.087	14.087	0	0	-1	0	0	0	0	0	0	0	#	Mat50%_Fem
0	1.00E+06	-0.574	-0.574	0	0	-1	0	0	0	0	0	0	0	#	Mat_slope_Fem
0	1.00E+06	278.715	278.715	0	0	-1	0	0	0	0	0	0	0	#	Eggs_scalar_Fem
0	1.00E+06	3.042	3.042	0	0	-1	0	0	0	0	0	0	0	#	Eggs_exp_len_Fem
#-4	4	0	0	99	0	-4	0	0	0	0	0	0	0	#	RecrDist_GP_1
#-4	4	1	1	0.01	0	-4	0	0	0	0	0	0	0	#	RecrDist_Area_1
#-4	4	1	1	0.01	0	-4	0	0	0	0	0	0	0	#	RecrDist_timing_1
1	1	1	1	0	0	-4	0	0	0	0	0	0	0	#	CohortGrowDev
0.000001	0.999999	0.999999	0.5	0.5	0	-99	0	0	0	0	0	0	0	#	FracFemale_GP_1
#							
#_no timevary MG parameters							
#	
#_seasonal_effects_on_biology_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE	
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Spawner-Recruitment
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepard_3Parm
0  # 0/1 to use steepness in initial equ recruitment calculation							
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature	
#_LO	HI	INIT	PRIOR	SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn		
0	13.82	10.1916	6.91	0	0	1	0	0	0	0	0	0	0	#	SR_LN(R0)
0.22	0.96	0.572558	0.6	0.74	0	1	0	0	0	0	0	0	0	#	SR_BH_steep
0	2	0.226101	0.2	0	0	1	0	0	0	0	0	0	0	#	SR_sigmaR
-5	5	0	0	0	0	-3	0	0	0	0	0	0	0	#	SR_regime
0	0.5	0	0	0	0	-2	0	0	0	0	0	0	0	#	SR_autocorr
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1994 # first year of main recr_devs; early devs can preceed this era
2012 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1986.53 #_last_early_yr_nobias_adj_in_MPD
 1995.83 #_first_yr_fullbias_adj_in_MPD
 2010.72 #_last_yr_fullbias_adj_in_MPD
 2011 #_first_recent_yr_nobias_adj_in_MPD
 0.3 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#
#Fishing Mortality info 
0.5 # F ballpark for annual F (=Z-M) for specified year
-2001 # F ballpark year (neg value to disable)
2 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
 0.05 1 0 # overall start F value; overall phase; N detailed inputs to read
#Fleet Year Seas F_value se phase (for detailed setup of F_Method=2)
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
1	1	0	0	0	1	#	1	CM_E
2	1	0	0	0	1	#	2	CM_W
3	1	0	0	0	1	#	3	REC
4	1	0	0	0	0	#	4	SMP_BYC
5	1	0	0	0	1	#	5	HB_E
6	1	0	0	0	1	#	6	HB_W
7	1	0	0	0	1	#	7	CM_E_IFQ
8	1	0	0	0	1	#	8	CM_W_IFQ
9	1	0	0	0	1	#	9	LARVAL
10	1	0	0	0	1	#	10	VIDEO
11	1	0	0	0	1	#	11	SEAMAP	
-9999	0	0	0	0	0		
#
#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
#_Q_parms(if_any);Qunits_are_ln(q)
#_	LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn	#	parm_name
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	CM_E
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	CM_W
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	REC
	-10	20	1.43823	1	0	-1	2	0	0	0	0	0	0	0	#	SMP_BYC
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	HB_E
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	HB_W
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	CM_E_IFQ
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	CM_W_IFQ
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	LARVAL
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	VIDEO
	-25	25	0	0	1	0	-1	0	0	0	0	0	0	0	#	SEAMAP
#_no timevary Q parameters							
#		
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_Pattern Discard Male Special
 0 0 0 0 # 1 CM_E
 0 0 0 0 # 2 CM_W
 0 0 0 0 # 3 REC
 0 3 0 0 # 4 SMP_BYC
 0 0 0 0 # 5 HB_E
 0 0 0 0 # 6 HB_W
 0 0 0 0 # 7 CM_E_IFQ
 0 0 0 0 # 8 CM_W_IFQ
 0 0 0 0 # 9 LARVAL
 24 0 0 0 # 10 VIDEO
 24 0 0 0 # 11 SEAMAP
#
#_age_selex_types
#_Pattern ___ Male Special
 12 0 0 0 # 1 CM_E
 12 0 0 0 # 2 CM_W
 20 0 0 0 # 3 REC
 19 0 0 0 # 4 SMP_BYC
 15 0 0 3 # 5 HB_E
 15 0 0 3 # 6 HB_W
 15 0 0 1 # 7 CM_E_IFQ
 15 0 0 2 # 8 CM_W_IFQ
 0 0 0 0 # 9 LARVAL
 0 0 0 0 # 10 VIDEO
 0 0 0 0 # 11 SEAMAP
#_	LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	env-var	use_dev	dev_mnyr	dev_mxyr	dev_PH	Block	Blk_Fxn	#	parm_name		
7.5	52.5	27.3943	42.7	0.05	0	2	0	0	0	0	0.5	0	0	#	SizeSel_10P_1_VIDEO
-10	3	-8.52527	-0.4	0.05	0	3	0	0	0	0	0.5	0	0	#	SizeSel_10P_2_VIDEO
-6	12	4.16955	5.5	0.05	0	3	0	0	0	0	0.5	0	0	#	SizeSel_10P_3_VIDEO
-4	6	-3.81667	5.1	0.05	0	3	0	0	0	0	0.5	0	0	#	SizeSel_10P_4_VIDEO
-15	5	-5.38037	-4.2	0.05	0	2	0	0	0	0	0.5	0	0	#	SizeSel_10P_5_VIDEO
-8	5	1.07568	0.4	0.05	0	2	0	0	0	0	0.5	0	0	#	SizeSel_10P_6_VIDEO
7.5	52.5	13.0293	13	0.05	0	2	0	0	0	0	0.5	0	0	#	SizeSel_11P_1_SEAMAP
-10	3	-5.38036	-1.1	0.05	0	3	0	0	0	0	0.5	0	0	#	SizeSel_11P_2_SEAMAP
-6	12	-0.521245	3.1	0.05	0	3	0	0	0	0	0.5	0	0	#	SizeSel_11P_3_SEAMAP
-4	6	3.6083	5	0.05	0	3	0	0	0	0	0.5	0	0	#	SizeSel_11P_4_SEAMAP
-15	5	-0.444832	-4.5	0.05	0	2	0	0	0	0	0.5	0	0	#	SizeSel_11P_5_SEAMAP
-8	5	-5.8722	0.1	0.05	0	2	0	0	0	0	0.5	0	0	#	SizeSel_11P_6_SEAMAP
0.5	14	2.40093	2.66	0	0	3	0	0	0	0	0	1	2	#	AgeSel_1P_1_CM_E
0.5	14	0.815116	7.2774	0	0	1	0	0	0	0	0	1	2	#	AgeSel_1P_2_CM_E
0.5	14	3.43436	2.66	0	0	3	0	0	0	0	0	1	2	#	AgeSel_2P_1_CM_W
0.5	14	1.36515	7.2774	0	0	1	0	0	0	0	0	1	2	#	AgeSel_2P_2_CM_W
1	10	3.8971	4.3	0.05	0	2	0	0	0	0	0.5	0	0	#	AgeSel_3P_1_REC
-10	3	-1.95988	-4.6	0.05	0	3	0	0	0	0	0.5	0	0	#	AgeSel_3P_2_REC
-6	12	0.476059	0.7	0.05	0	3	0	0	0	0	0.5	0	0	#	AgeSel_3P_3_REC
-4	6	3.38152	2.7	0.05	0	3	0	0	0	0	0.5	0	0	#	AgeSel_3P_4_REC
-15	5	-14.188	-11.2	0.05	0	2	0	0	0	0	0.5	0	0	#	AgeSel_3P_5_REC
-8	5	-2.49577	-3.3	0.05	0	2	0	0	0	0	0.5	0	0	#	AgeSel_3P_6_REC
1.00E-07	2	0.5	0.5	0	0	-4	0	0	0	0	0	0	0	#	AgeSel_4P_1_SMP_BYC
0.5	1.00E+07	100	100	0	0	-4	0	0	0	0	0	0	0	#	AgeSel_4P_2_SMP_BYC
0.3	3	1.5	1.5	0	0	-4	0	0	0	0	0	0	0	#	AgeSel_4P_3_SMP_BYC
0.5	1.00E+07	2.4096	2.4096	0	0	-4	0	0	0	0	0	0	0	#	AgeSel_4P_4_SMP_BYC
-1	1	0	0	0	0	-4	0	0	0	0	0	0	0	#	AgeSel_4P_5_SMP_BYC
-1	1	0	0	0	0	-4	0	0	0	0	0	0	0	#	AgeSel_4P_6_SMP_BYC
#0	15	0.1	2.66	0	0	-1	0	0	0	0	0	0	0	#	AgeSel_10P_1_VIDEO
#0	15	14	7.2774	0	0	-1	0	0	0	0	0	0	0	#	AgeSel_10P_2_VIDEO
#0	15	0.1	2.66	0	0	-1	0	0	0	0	0	0	0	#	AgeSel_11P_1_SEAMAP
#0	15	14	7.2774	0	0	-1	0	0	0	0	0	0	0	#	AgeSel_11P_2_SEAMAP
# timevary selex parameters 	
#_	LO	HI	INIT	PRIOR	PR_SD	PR_type	PHASE	#	parm_name			
	0.5	14	2.47319	2.66	0	0	3	#	AgeSel_1P_1_CM_E_BLK1repl_2007			
	0.5	14	0.838296	7.2774	0	0	1	#	AgeSel_1P_2_CM_E_BLK1repl_2007			
	0.5	14	3.91039	2.66	0	0	3	#	AgeSel_2P_1_CM_W_BLK1repl_2007			
	0.5	14	1.4895	7.2774	0	0	1	#	AgeSel_2P_2_CM_W_BLK1repl_2007			
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 							
#							
0   #  use 2D_AR1 selectivity(0/1):  experimental feature							
#_no 2D_AR1 selex offset used							
#				
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# Input variance adjustments factors: 							
 #_1=add_to_survey_CV							
 #_2=add_to_discard_stddev							
 #_3=add_to_bodywt_CV							
 #_4=mult_by_lencomp_N							
 #_5=mult_by_agecomp_N							
 #_6=mult_by_size-at-age_N							
 #_7=mult_by_generalized_sizecomp							
#_Factor  Fleet  Value							
 -9999 0 0  # terminator	
#
4 #_maxlambdaphase
1 #_sd_offset
# read 7 changes to default Lambdas (default value is 1.0)							
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 							
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark							
#like_comp fleet  phase  value  sizefreq_method								
-9999  1  1  1  1  #  terminator			
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

