#Jitter analysis
# This files processes jitter results and creates outputs for likelihoods, quants, and, parameters


rm(SS_output)
rm(SS_plots)
rm(list=ls())
library("devtools")
devtools::install_github("r4ss/r4ss") #, ref="v1.23.1")
library("r4ss")


#wd <- "R:\\_Assessments-SEDAR\\GAJ_2013\\Assessment models\\Stock Synthesis\\Predecisional\\SSC RUNS\\jitter"
direct  <- "E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\transition work\\Convert to 3.3 by hand\\All_at_once\\jitter"
setwd(direct)

jitter=seq(1:200)
n=length(jitter)


SS_RunJitter(direct, model = "ss",
             extras = "-nohess", n, Intern = TRUE,
             systemcmd = FALSE, printlikes = TRUE)


VS <- SSgetoutput(keyvec=1:n, getcomp=FALSE,dirvec=direct,getcovar=F)
VS_summary <- SSsummarize(VS)

#Likelihood across runs
likes=VS_summary$likelihoods

#Derived quants across runs
quants=VS_summary$quants

#Estimated parameters across runs
pars=VS_summary$pars

direct2  <- "E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\transition work\\Convert to 3.3 by hand\\All_at_once\\jitter\\Outputs"
setwd(direct2)

#Write tables
write.table(quants,"Quants.csv")
write.table(pars,"Pars.csv")
write.table(likes,"Likelihoods.csv")

h<-as.numeric(pars[pars$Label == 'SR_BH_steep', c(1:n)])
R0<-as.numeric(pars[pars$Label == 'SR_LN(R0)', c(1:n)])
Sigma_R<-as.numeric(pars[pars$Label == 'SR_sigmaR', c(1:n)])

require(reshape)
require(ggplot2)
require(lattice)
likes2=as.data.frame(melt(likes))
likes3=melt(likes[1,])


png(file="Jitter Likelihood by Data Source.png")

#ggplot(data=likes2,aes(x=factor(variable),y=value))+geom_bar(stat="identity")+facet_wrap(~Label)
barchart(value~Label|Label, group=factor(variable), data=likes2,scales='free')
dev.off()

png(file="Jitter Total Likelihood.png")
#ggplot(data=likes3,aes(x=factor(variable),y=value))+geom_bar(stat="identity")+facet_wrap(~Label)
barchart(value~Label|Label, group=factor(variable), data=likes3,scales='free')

dev.off()

png(file="Jitter Steepness Estimates.png")
barplot(h,names.arg=jitter, main="Steepness Values")
dev.off()

png(file="Jitter R0 Estimates.png")
barplot(R0,names.arg=jitter, main="R0 Values")
dev.off()

png(file="Jitter Sigma_R Estimates.png")
barplot(Sigma_R,names.arg=jitter, main="Sigma_R Values")
dev.off()


#################################################################################################################################################


#Plot derived quants across the range of steepness


SSB<-as.matrix(quants[c(which(quants$Label== 'SSB_1950'): which(quants$Label== 'SSB_2014')), c(1:n)])
BRATIO<-as.matrix(quants[c(which(quants$Label== 'Bratio_1951'): which(quants$Label== 'Bratio_2014')), c(1:n)])
Recruit<-as.matrix(quants[c(which(quants$Label== 'Recr_1950'): which(quants$Label== 'Recr_2014')), c(1:n)])
Fish.Mort<-as.matrix(quants[c(which(quants$Label== 'F_1950'): which(quants$Label== 'F_2014')), c(1:n)])
YRS<-quants$Yr[c(which(quants$Label== 'SSB_1950'): which(quants$Label== 'SSB_2014'))]
colnames(SSB)<-jitter
colnames(BRATIO)<-jitter
colnames(Fish.Mort)<-jitter
colnames(Recruit)<-jitter
#Plot estimated biology and selectivty parameters across the range of steepness values
#Need to check GTF's Report.sso file and identify which parms are being estimated

#parms=c(16,17,18,20,60:65,275:403)

#x=seq(0.4, 0.99, 0.02)
#names=pars[,"Label"]
#names
#x

#windows(record=T)
#par(mfrow=c(5,4),mai=c(.25,.25,.25,.25), oma=c(1,1,0,0))
#for(i in parms){
#  plot(x,as.numeric(pars[i,1:length(x)]),type='l',main=names[i])
#}


png(file="Profile Population Trajectories.png")
par(mfrow=c(2,1))
matplot(YRS,SSB,type='l',main="Spawning Stock Biomass",xlab="Years",ylab="SSB (Mil of Eggs)",ylim=c(0,max(SSB)+.1*max(SSB)))
legend("topright",cex=.4,ncol=n/2,legend = colnames(SSB), col = 1:n, lty = 1:n)
matplot(YRS[2:length(YRS)],BRATIO,type='l',main="SSB/SSB0",xlab="Years",ylab="SSB/SSB0", ylim=c(0,1))
matlines(YRS[2:length(YRS)],rep(0.3,times=(length(YRS)-1)))
dev.off()
png(file="Profile Recruitment and Harvest Rate.png")
par(mfrow=c(2,1))
matplot(YRS,Recruit,type='l', main="Recruitment",xlab="Years",ylab="Recruitment (1000s of Fish)",ylim=c(0,max(Recruit)+.1*max(Recruit)))
legend("topright",cex=.4,ncol=n/2,legend = colnames(Recruit), col = 1:n, lty = 1:n)
matplot(YRS,Fish.Mort,type='l', main="Harvest Rate",xlab="Years",ylab="Harvest Rate (Exploitable Numbers)",ylim=c(0,max(Fish.Mort)+.1*max(Fish.Mort)))
dev.off()


png(file="Profile Population Trajectories Recent Years.png")
par(mfrow=c(2,1))
matplot(YRS[ceiling(length(YRS)*0.75):length(YRS)],SSB[c(ceiling(length(YRS)*0.75):length(YRS)),],type='l',main="Spawning Biomass (Mil of Eggs)",xlab="Years",ylab="SSB (Mil of Eggs)",ylim=c(0,max(SSB[c(ceiling(length(YRS)*0.75):length(YRS)),])+.1*max(SSB[c(ceiling(length(YRS)*0.75):length(YRS)),])))
legend("top",cex=.4,ncol=n,legend = colnames(SSB), col = 1:n, lty = 1:n)
matplot(YRS[ceiling(length(YRS)*0.75):length(YRS)],BRATIO[c((ceiling(length(YRS)*0.75)-1):(length(YRS)-1)),],type='l',main="SSB/SSB0",xlab="Years",ylab="SSB/SSB0", ylim=c(0,1))
matlines(YRS[ceiling(length(YRS)*0.75):length(YRS)],rep(0.3,times=(length(YRS[ceiling(length(YRS)*0.75):length(YRS)]))))

dev.off()
png(file="Profile Recruitment and Harvest Rate Recent Years.png")
par(mfrow=c(2,1))
matplot(YRS[ceiling(length(YRS)*0.75):length(YRS)],Recruit[c(ceiling(length(YRS)*0.75):length(YRS)),],type='l', main="Recruitment (1000s of Fish)",xlab="Years",ylab="Recruitment (1000s of Fish)",ylim=c(0,max(Recruit[c(ceiling(length(YRS)*0.75):length(YRS)),])+.1*max(Recruit[c(ceiling(length(YRS)*0.75):length(YRS)),])))
legend("top",cex=.4,ncol=n/2,legend = colnames(Recruit), col = 1:n, lty = 1:n)
matplot(YRS[ceiling(length(YRS)*0.75):length(YRS)],Fish.Mort[c(ceiling(length(YRS)*0.75):length(YRS)),],type='l', main="Harvest Rate (Exploitable Numbers)",xlab="Years",ylab="Harvest Rate (Exploitable Numbers)",ylim=c(0,max(Fish.Mort[c(ceiling(length(YRS)*0.75):length(YRS)),])+.1*max(Fish.Mort[c(ceiling(length(YRS)*0.75):length(YRS)),])))
dev.off()