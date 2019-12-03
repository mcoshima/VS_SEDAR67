rm(SS_output)
rm(SS_plots)
rm(list=ls())
library("devtools")
devtools::install_github("r4ss/r4ss") #, ref="v1.23.1")
library("r4ss")


mydir<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\transition work\\Convert to 3.3 by hand\\All_at_once"
setwd(mydir)

#mydir1<-"R:/_Assessments-SEDAR/SEDAR_45_GoM_Vermilion_Snapper/Assessment models/StockSynthesis/1. Update Version of SS"
mydir4<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_45\\Base_SS3.24\\Base"
mydir5<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\transition work\\Convert to 3.3 by hand\\All_at_once"

MYdirvec<-c(mydir4,mydir5) #mydir11


#read in and summarize results from retros
BaseComp <- SSgetoutput(dirvec=MYdirvec, forecast=FALSE)
BaseCompSummary <- SSsummarize(BaseComp)
SSplotComparisons(BaseCompSummary, subplots=c(1:10,13:20), sprtarg=.3, btarg=.3,legendncol = 1,legendloc = "bottomleft", 
                  legendlabels=c("SEDAR 45, SS3.24","SEDAR 67, SS3.3"),pdf=TRUE,plotdir=mydir,indexfleets=11)



