rm(SS_output)
rm(SS_plots)
rm(list=ls())
library("devtools")
devtools::install_github("r4ss/r4ss") #, ref="v1.23.1")
library("r4ss")


# hessian
rm(myreplist)

#direct <- "R:\\_Assessments-SEDAR\\GAJ_2013\\Assessment models\\Stock Synthesis\\Predecisional\\SSC RUNS\\ssc base2"
#direct  <- "R:/_Assessments-SEDAR/SEDAR_45_GoM_Vermilion_Snapper/Assessment models/StockSynthesis/6. Base Model Runs/B. base/test double normal priors/no priors"
direct <- "D:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\transition work\\Convert to 3.3 by hand\\All_at_once"
base <- SS_output(dir = direct,printstats = T, covar=T, cormax=0.70, forecast=F,printhighcor=50, printlowcor=50)
SS_fitbiasramp(base)
write.csv(base$highcor, file="correlations.csv")

direct2<-"D:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\transition work\\Base_3.24_run_with_plots\\est rec dev to 2014"

base2 <- SS_output(dir = direct2,printstats = T, covar=T, cormax=0.70, forecast=F,printhighcor=50, printlowcor=50)
SS_fitbiasramp(base2)


SS_plots(replist = base, uncertainty=T, plot=c(1:6,8:24),sprtarg=0.30, btarg=0.3, datplot=T, minbthresh=-1,png=T, 
		 dir="default", pdf=F,printfolder="R_Plots_Report")

SS_plots(replist = base, uncertainty=T, sprtarg=0.30, btarg=0.3, datplot=T, minbthresh=-1,png=F, 
         printfolder="R_Plots_Report", dir="default", pdf=T)


SSplotCatch(replist=base,print=TRUE)
SS_fitbiasramp(base)
write.csv(base$highcor, file="correlations.csv")


###################################################################################
# table output
###################################################################################
# directories
table_sub_dir <- 'Tables'
figures_sub_dir <- 'Figures'

if (!file.exists(table_sub_dir)) dir.create(file.path(direct, table_sub_dir))
if (!file.exists(figures_sub_dir)) dir.create(file.path(direct, figures_sub_dir))

# indicies
dat <- base$cpue
names <- unique(dat$Name)

for(i in 1: length(names)){
  out <- dat[dat$Name == names[i], ]
  cihi <- out$Obs + 1.96*out$SE
  cilo <- out$Obs - 1.96*out$SE
  final.out <- data.frame('Year' = out$Yr, 'Observed' = out$Obs, 'Expected' = out$Exp, 'Std.Err.' = out$SE,
                          'CI_Hi' = cihi, 'CI_Low' = cilo)
  name.out <- paste('Obs and Pred', names[i])
  name.out <- paste0(name.out, '.csv')
 setwd(file.path(direct, table_sub_dir))
 
 write.csv(final.out, name.out)
 ylims <- range(final.out$Observed)
 ylims <- c(0, ylims[2]*1.25)
 setwd(file.path(direct, figures_sub_dir))
 png(paste0(paste(names[i], 'CPUE'), '.png'))
 plot(final.out$Year, final.out$Expected, typ='l', col = 'blue', lwd = 2, xlab = 'Year', ylab='Std.CPUE', ylim = ylims)
 points(final.out$Year, final.out$Observed, pch=19, col='red')
 legend('top', legend = c('OBS','PRED'), col = c('red', 'blue'), pch = c(19, NA), bty = 'n', lty = c(NA, 1))
 dev.off()
}

# Catch and F
dat <- base$timeseries
cm_e_obs <- as.vector(dat['obs_cat:_1'])
cm_w_obs <- dat['obs_cat:_2']
rec_obs <- dat['obs_cat:_3']

cm_e_pred <- dat['retain(B):_1']
cm_w_pred <- dat['retain(B):_2']
rec_pred <- dat['retain(N):_3']

out <- data.frame(dat$Yr, cm_e_obs, cm_e_pred, cm_w_obs, cm_w_pred, rec_obs, rec_pred)
names(out) <- c('Year', 'Commercial East OBS (mt)', 'Commercial East PRED (mt)',
                'Commercial West OBS (mt)', 'Commercial West PRED (mt)', 
                'Recreational OBS (1000s)', 'Recreational PRED (1000s)')

setwd(file.path(direct, table_sub_dir))
out <- out[-(1:2), ]
write.csv(out, 'Obs and Pred Catch.csv')

ylims <- range(c(cm_e_obs, cm_w_obs))
ylims <- c(0, ylims[2]*1.25)

setwd(file.path(direct, figures_sub_dir))
png('Observed and Predicted Commercial Catch.png')
plot(out$Year, out[,'Commercial East OBS (mt)'], pch=19, col='black', xlab = 'Year', ylab='Retained Catch (mt)', ylim =ylims)
points(out$Year, out[,'Commercial East PRED (mt)'], typ='l', col = 'black', lwd = 2)
points(out$Year, out[,'Commercial West OBS (mt)'], typ='p', col = 'red', pch = 19)
points(out$Year, out[,'Commercial West PRED (mt)'], typ='l', col = 'red', lwd = 2)
legend('topleft', legend = c('Commercial East OBS (mt)','Commercial East PRED (mt)','Commercial West OBS (mt)','Commercial West PRED (mt)')
       , col = c('black', 'black', 'red', 'red'), pch = c(19, NA, 19, NA), lty = c(NA, 1, NA, 1))
dev.off()


ylims <- range(rec_obs)
ylims <- c(0, ylims[2]*1.25)

png('Observed and Predicted Recreational Catch.png')
plot(out$Year, out[,'Recreational OBS (1000s)'], pch=19, col='black', xlab = 'Year', ylab='Retained Catch (1000s)', ylim =ylims)
points(out$Year, out[,'Recreational PRED (1000s)'], typ='l', col = 'black', lwd = 2)

legend('topleft', legend = c('Recreatinal OBS (1000s)','Recreational PRED (1000s)')
       , col = c('black', 'black'), pch = c(19, NA), lty = c(NA, 1))
dev.off()

#Fishing mortality rates
dat2 <- base$derived_quants
exploit <- dat2[grep('F', dat2$LABEL), ]$Value
tmp <- data.frame(dat$Yr, dat[, grep('F', names(dat))])
tmp <- tmp[-(1:2), ]
tmp <- data.frame(tmp, exploit)
names(tmp) <- c('Year', 'Commercial East', 'Commercial West', 'Recreational', 'Shrimp Bycatch', 'Harvest Rate (Exploitable Numbers)')
setwd(file.path(direct, table_sub_dir))
write.csv(tmp, 'Apical F by fleet.csv')

# SSB, Biomass, Abundance, Recruits
out <- data.frame(dat$Yr, dat$Bio_all, dat$SpawnBio, dat['SmryNum_SX:1_GP:1'], dat$Recruit_0 )
depletion <- out$dat.SpawnBio/out$dat.SpawnBio[1]
out <- data.frame(out, depletion)
out <- out[-(1:2), ]
names(out) <- c('Year', 'Biomass (mt)', 'Spawning Output (# Eggs)', 'Abundance (1000s)', 'Recruits (1000s)', 'Depletion (SSB/SSB0)')
write.csv(out, 'SSB, Biomass, Abundance, Recruits.csv')


setwd(file.path(direct, figures_sub_dir))
#Spawning output and Recruitment
png('Spawning Output and Recruitment.png')
ylims <- c(0,max(range(out['Spawning Output (# Eggs)'])))
par(mar = c(5, 4, 4, 4) + 0.3)

plot(out$Year, out[, 'Spawning Output (# Eggs)'], typ='l', col='blue', xlab = 'Year', ylab='Number of Eggs',
     ylim =ylims, lwd = 2, main='Spawning Output')
par(new = T)
plot(out$Year, out[, 'Recruits (1000s)'], typ = 'l', col = 'red', axes = F, xlab = '', ylab = '', lwd = 2,ylim=c(0,max(range(out['Recruits (1000s)']))))
axis(side = 4, at = pretty(c(0,max(range(out[, 'Recruits (1000s)'])))))
mtext('Recruits (1000s)', side = 4, line = 3)
legend('bottomleft', legend = c('SSB', 'Recruits')
       , col = c('blue', 'red'), lty = c(1, 1))
dev.off()

#Abundance
png('Abundance.png')
plot(out$Year, out[, 'Abundance (1000s)'], typ = 'l', col='blue', lwd = 2, xlab = 'Year', ylab = '1000s of Fish', 
     main = 'Total Abundance', ylim = c(0, max(out[, 'Abundance (1000s)'])))
dev.off()

#paramters
dat <- base$parameters
ForE <- rep('Estimated', dim(dat)[1])
ForE[dat$Phase < 0] <- 'Fixed' 
out <- data.frame(dat$Label, dat$Value, dat$Parm_StDev, ForE)
names(out) <- c('Parameter', 'Value', 'Standard Deviation', 'Fixed or Estimated')
setwd(file.path(direct, table_sub_dir))
write.csv(out, 'Parameter Estimates.csv')

# Stock Recruit
dir <- file.path(direct, figures_sub_dir)
SSplotSpawnrecruit(base, legendloc = 'bottomright', plot = F, print = T, plotdir = dir)

# Discards
dat <- base$discard
out <- data.frame(dat$Yr, dat$Obs, dat$Exp)
names(out) <- c('Year', 'Observed (1000s Fish)', 'Expected (1000s Fish)')
setwd(file.path(direct, table_sub_dir))
write.csv(out, 'Obs and Pred Shrimp Discards.csv')
