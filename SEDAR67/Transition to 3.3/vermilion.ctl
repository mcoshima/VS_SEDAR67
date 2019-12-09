#V3.30.14.00-safe;_2019_07_19;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.0
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#_user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_user_info_available_at:https://vlab.ncep.noaa.gov/group/stock-synthesis
#_data_and_control_files: vermilion.dat // vermilion.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_between/within_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
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
#
# AUTOGEN
1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: null;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  21-24 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement 
#
3 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
 #_Age_natmort_by sex x growthpattern
 0.234 0.342 0.287 0.257 0.239 0.228 0.22 0.215 0.212 0.209 0.207 0.206 0.205 0.204 0.204
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
1 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
2 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
 #          0.0001        1e+006      0.2          11.83         0           0            -1       0      0 0 0 0 0 0 # M
# Sex: 1  BioPattern: 1  Growth
 0.0001 1e+006 11.83 11.83 0 0 -1 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 0.0001 1e+006 34.4 34.4 0 0 -1 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1e+006 0.3254 0.3254 0 0 -1 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 1e+006 0.2535 0.0001 0 0 -1 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0 1e+006 0.2535 0.0001 0 0 -1 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 0 1e+006 2.19e-005 2.19e-005 0 0 -1 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 0 1e+006 2.916 2.916 0 0 -1 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 0 1e+006 14.087 14.087 0 0 -1 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -1 1e+006 -0.574 -0.574 0 0 -1 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 0 1e+006 278.715 278.715 0 0 -1 0 0 0 0 0 0 0 # Eggs_scalar_Fem_GP_1
 0 1e+006 3.042 3.042 0 0 -1 0 0 0 0 0 0 0 # Eggs_exp_len_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution  
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-006 0.999999 0.5 0.5 0.5 0 -1 0 0 0 0 0 0 0 # FracFemale_GP_1
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
1  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_ LO      HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
   0       16        6.91         6.91          0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
  0.22     0.96      0.75           0.6          0.74           0          2          0          0          0          0          0          0          0 # SR_BH_steep
   0       2      0.263505          0.2           0             0          3          0          0          0          0          0          0          0 # SR_sigmaR
  -5       5            0           0             0             0         -3          0          0          0          0          0          0          0 # SR_regime
   0       0.5          0           0             0             0         -2          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1994 # first year of main recr_devs; early devs can preceed this era
2014 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase 
1 # (0/1) to read 13 advanced options
0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 -5 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1973.9997 #_last_early_yr_nobias_adj_in_MPD                   
 2001.2355 #_first_yr_fullbias_adj_in_MPD                      
 2010.1785 #_last_yr_fullbias_adj_in_MPD                       
 2014.6085 #_first_recent_yr_nobias_adj_in_MPD                 
    0.7988 #_max_bias_adj_in_MPD (1.0 to mimic pre-2009 models)
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
#  1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013F 2014F 2015F 2016F 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F 2035F 2036F 2037F 2038F 2039F 2040F 2041F 2042F 2043F 2044F 2045F 2046F 2047F 2048F 2049F 2050F 2051F 2052F 2053F 2054F 2055F 2056F 2057F 2058F 2059F 2060F 2061F 2062F 2063F 2064F 2065F 2066F 2067F 2068F 2069F 2070F 2071F 2072F 2073F 2074F
#  -0.340875 -0.123589 -0.0999198 -0.0515514 -0.242645 0.365387 0.223196 0.192095 0.105425 0.0503564 -0.232414 -0.0292865 0.373182 -0.0514549 -0.209711 -0.356058 0.104545 0.203449 0.119869 0.146461 -0.208541 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# implementation error by year in forecast:  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.5 # F ballpark
-2001 # F ballpark year (neg value to disable)
2 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
 0.05 1 0 # overall start F value; overall phase; N detailed inputs to read
#Fleet Yr Seas F_value se phase (for detailed setup of F_Method=2; -Yr to fill remaining years)

#
#_initial_F_parms; count = 0
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#2074 2035
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         1         0         0         0         1  #  CM_E
         2         1         0         0         0         1  #  CM_W
         3         1         0         0         0         1  #  REC
         4         1         0         0         0         0  #  SMP_BYC
         5         1         0         0         0         1  #  HB_E
         6         1         0         0         0         1  #  HB_W
         7         1         0         0         0         1  #  CM_E_IFQ
         8         1         0         0         0         1  #  CM_W_IFQ
         9         1         0         0         0         1  #  LARVAL
        10         1         0         0         0         1  #  VIDEO
        11         1         0         0         0         1  #  SEAMAP
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -25            25       0             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CM_E(1)
           -25            25      0            0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CM_W(2)
           -25            25      0            0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_REC(3)
           -10            20       0             0             0            0         2          0          0          0          0          0          0          0  #  LnQ_base_SMP_BYC(4)
           -25            25      0             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_HB_E(5)
           -25            25      0             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_HB_W(6)
           -25            25      0             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CM_E_IFQ(7)
           -25            25      0             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CM_W_IFQ(8)
           -25            25      0            0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_LARVAL(9)
           -25            25      0            0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_VIDEO(10)
           -25            25      0            0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_SEAMAP(11)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for all sizes
#Pattern:_1; parm=2; logistic; with 95% width specification
#Pattern:_5; parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6; parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8; parm=8; New doublelogistic with smooth transitions and constant above Linf option
#Pattern:_9; parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in size
#Pattern:_27; parm=3+special; cubic spline 
#Pattern:_42; parm=2+special+3; // like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
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
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#_Pattern Discard Male Special
 12 0 0 0 # 1 CM_E
 12 0 0 0 # 2 CM_W
 20 0 0 0 # 3 REC
 19 0 0 0 # 4 SMP_BYC
 15 0 0 3 # 5 HB_E
 15 0 0 3 # 6 HB_W
 15 0 0 1 # 7 CM_E_IFQ
 15 0 0 2 # 8 CM_W_IFQ
 10 0 0 0 # 9 LARVAL
 0 0 0 0 # 10 VIDEO
 0 0 0 0 # 11 SEAMAP
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   CM_E LenSelex
# 2   CM_W LenSelex
# 3   REC LenSelex
# 4   SMP_BYC LenSelex
# 5   HB_E LenSelex
# 6   HB_W LenSelex
# 7   CM_E_IFQ LenSelex
# 8   CM_W_IFQ LenSelex
# 9   LARVAL LenSelex
# 10   VIDEO LenSelex
           3.5          52.5       27.4          42.7         0             0          2          0          0          0          0        0          0          0  #  Size_DblN_peak_VIDEO(10)
           -10             0      -8.5          -0.4          0             0          3          0          0          0          0        0          0          0  #  Size_DblN_top_logit_VIDEO(10)
             0            12       4.1           5.5          0             0          3          0          0          0          0        0          0          0  #  Size_DblN_ascend_se_VIDEO(10)
            -5             0      -3.8           5.1          0             0          3          0          0          0          0        0          0          0  #  Size_DblN_descend_se_VIDEO(10)
           -15             0      -5.4          -4.2          0             0          2          0          0          0          0        0          0          0  #  Size_DblN_start_logit_VIDEO(10)
           0.5             5       1.2           0.4          0             0          2          0          0          0          0        0          0          0  #  Size_DblN_end_logit_VIDEO(10)
# 11   SEAMAP LenSelex
           7.5          52.5            13       13           0             0          2          0          0          0          0        0          0          0  #  Size_DblN_peak_SEAMAP(11)
           -10             3          -5.38      -1.1         0             0          3          0          0          0          0        0          0          0  #  Size_DblN_top_logit_SEAMAP(11)
            -6            12            -0.5      3.1         0             0          3          0          0          0          0        0          0          0  #  Size_DblN_ascend_se_SEAMAP(11)
            -4             6            3.6          5        0             0          3          0          0          0          0        0          0          0  #  Size_DblN_descend_se_SEAMAP(11)
           -15             5          -0.4      -4.5          0             0          2          0          0          0          0        0          0          0  #  Size_DblN_start_logit_SEAMAP(11)
            -8             5           -5.9       0.1         0             0          2          0          0          0          0        0          0          0  #  Size_DblN_end_logit_SEAMAP(11)
# 1   CM_E AgeSelex
           0.5            14      2.4          2.66            0             0          3          0          0          0          0          0          1          2  #  Age_inflection_CM_E(1)
           0.5            14      0.8         7.2774           0             0          1          0          0          0          0          0          1          2  #  Age_95%width_CM_E(1)
# 2   CM_W AgeSelex
           0.5            14       3.4        2.66             0             0          3          0          0          0          0          0          1          2  #  Age_inflection_CM_W(2)
           0.5            14       1.4        7.2774           0             0          1          0          0          0          0          0          1          2  #  Age_95%width_CM_W(2)
# 3   REC AgeSelex
             1            10       3.89           4.3          0.             0          2          0          0          0          0        0          0          0  #  Age_DblN_peak_REC(14)
           -10           -1.5      -1.9          -4.6        0.             0          3          0          0          0          0        0          0          0  #  Age_DblN_top_logit_REC(14)
            -6            12       0.5           0.7          0.             0          3          0          0          0          0        0         0          0  #  Age_DblN_ascend_se_REC(14)
             0             6       3.4           2.7        0.             0          3          0          0          0          0        0          0          0  #  Age_DblN_descend_se_REC(14)
           -16             5      -14.2         -11.2      0.             0          2          0          0          0          0        0          0          0  #  Age_DblN_start_logit_REC(14)
           -10            -1.5     -2.5             -3.3       0.             0          3          0          0          0          0        0          0          0  #  Age_DblN_end_logit_REC(14)
# 4   SMP_BYC AgeSelex
        1e-007             2           0.5           0.5             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P1_SMP_BYC(4)
           0.5        1e+007           100           100             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P2_SMP_BYC(4)
           0.3             3           1.5           1.5             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P3_SMP_BYC(4)
           0.5        1e+007        2.4096        2.4096             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P4_SMP_BYC(4)
            -1             1             0             0             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P5_SMP_BYC(4)
            -1             1             0             0             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P6_SMP_BYC(4)
# 5   HB_E AgeSelex
# 6   HB_W AgeSelex
# 7   CM_E_IFQ AgeSelex
# 8   CM_W_IFQ AgeSelex
# 9   LARVAL AgeSelex
# 10   VIDEO AgeSelex
#            0             15           0          2.66             0              0           -2          0          0          0          0          0          0          0
#            0             15           14           7.2774             0              0         -2          0          0          0          0          0          0          0
# 11   SEAMAP AgeSelex
#            0             15           0          2.66             0              0           -2          0          0          0          0          0          0          0
#            0             15           14           7.2774             0              0         -1          0          0          0          0          0          0          0
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
           0.5            14       2.51778          2.66             0             0      3  # Age_inflection_CM_E(1)_BLK1repl_2007
           0.5            14       0.90367        7.2774             0             0      1  # Age_95%width_CM_E(1)_BLK1repl_2007
           0.5            14       3.94193          2.66             0             0      3  # Age_inflection_CM_W(2)_BLK1repl_2007
           0.5            14       1.52535        7.2774             0             0      1  # Age_95%width_CM_W(2)_BLK1repl_2007
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      5    13     1     1     2     0     0     0     0     0     0     0
#      5    14     2     1     2     0     0     0     0     0     0     0
#      5    15     3     1     2     0     0     0     0     0     0     0
#      5    16     4     1     2     0     0     0     0     0     0     0
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
       4    10    0.668488    #    0.667098    0.668488 0.395138     1.002084   0.653629   2.311751 0.592324  len  VIDEO     
       4    11    0.810542    #    0.402801    0.810542 0.459746     2.012263   1.679227  45.325004 1.141373  len SEAMAP     
       5     1    0.276162    #    0.294618    0.276162 0.249331     0.937355   0.614065   2.088935 0.846286  age   CM_E     
       5     2    0.225210    #    0.234331    0.225210 0.480282     0.961075   0.658834   2.059218 2.049588  age   CM_W     
       5     3    0.857365    #    0.866142    0.857365 0.363493     0.989867   0.693835   1.964183 0.419669  age    REC     
 -9999   1    0  # terminator
#
7 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 1 1 1 #_CPUE/survey:_1
#  1 1 1 1 #_CPUE/survey:_2
#  1 1 1 1 #_CPUE/survey:_3
#  1 1 1 1 #_CPUE/survey:_4
#  1 1 1 1 #_CPUE/survey:_5
#  1 1 1 1 #_CPUE/survey:_6
#  1 1 1 1 #_CPUE/survey:_7
#  1 1 1 1 #_CPUE/survey:_8
#  1 1 1 1 #_CPUE/survey:_9
#  1 1 1 1 #_CPUE/survey:_10
#  1 1 1 1 #_CPUE/survey:_11
#  0 0 0 0 #_discard:_1
#  0 0 0 0 #_discard:_2
#  0 0 0 0 #_discard:_3
#  1 1 1 1 #_discard:_4
#  0 0 0 0 #_discard:_5
#  0 0 0 0 #_discard:_6
#  0 0 0 0 #_discard:_7
#  0 0 0 0 #_discard:_8
#  0 0 0 0 #_discard:_9
#  0 0 0 0 #_discard:_10
#  0 0 0 0 #_discard:_11
#  0 0 0 0 #_lencomp:_1
#  0 0 0 0 #_lencomp:_2
#  0 0 0 0 #_lencomp:_3
#  0 0 0 0 #_lencomp:_4
#  0 0 0 0 #_lencomp:_5
#  0 0 0 0 #_lencomp:_6
#  0 0 0 0 #_lencomp:_7
#  0 0 0 0 #_lencomp:_8
#  0 0 0 0 #_lencomp:_9
#  1 1 1 1 #_lencomp:_10
#  1 1 1 1 #_lencomp:_11
#  1 1 1 1 #_agecomp:_1
#  1 1 1 1 #_agecomp:_2
#  1 1 1 1 #_agecomp:_3
#  0 0 0 0 #_agecomp:_4
#  0 0 0 0 #_agecomp:_5
#  0 0 0 0 #_agecomp:_6
#  0 0 0 0 #_agecomp:_7
#  0 0 0 0 #_agecomp:_8
#  0 0 0 0 #_agecomp:_9
#  0 0 0 0 #_agecomp:_10
#  0 0 0 0 #_agecomp:_11
#  1 1 1 1 #_init_equ_catch
#  1 1 1 1 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_crashPenLambda
#  0 0 0 0 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 0 0 0 0 0 0 0 0 # placeholder for # selex_fleet, 1=len/2=age/3=both, year, N selex bins, 0 or Growth pattern, N growth ages, 0 or NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

