rm(SS_output)
rm(SS_plots)
rm(list=ls())
library("devtools")
devtools::install_github("r4ss/r4ss") #, ref="v1.23.1")
library("r4ss")


mydir<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional"
setwd(mydir)

#mydir1<-"R:/_Assessments-SEDAR/SEDAR_45_GoM_Vermilion_Snapper/Assessment models/StockSynthesis/1. Update Version of SS"
mydir4<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\SEDAR 45 updates\\Base"
mydir5<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\SEDAR 45 updates\\Update 2014 comm catch"
mydir6<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\SEDAR 45 updates\\Update rec catch and indices"
mydir7<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\SEDAR 45 updates\\update all catch"
mydir8<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional\\Transition to 3.3"
mydir9<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional\\3.3 with updated landings 2014"
mydir10<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional\\Update landings and indices (combined vid w old MS labs length comps)"
mydir11<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional\\update landings, indices, length comps"
mydir12<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional\\update landings, indices, length comps, fill age comps with 2014 values"
mydir13<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional\\drop CPUE indices all data updated (except shrimp, age comps)"
mydir14<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional\\Update landings and indices (MS labs vid index)"
mydir15<-"E:\\NOAA FILES\\Work Projects\\SEDAR 67 Vermilion Snapper\\Analyses\\SEDAR_67\\Predecisional\\update landings, indices, length comps (MS labs vid index)"

MYdirvec<-c(mydir4,mydir5,mydir6,mydir7) #mydir11


#read in and summarize results from retros
BaseComp <- SSgetoutput(dirvec=MYdirvec, forecast=FALSE)
BaseCompSummary <- SSsummarize(BaseComp)
SSplotComparisons(BaseCompSummary, subplots=c(1:10,13:20), sprtarg=.3, btarg=.3,legendncol = 1,legendloc = "bottomleft", 
                  legendlabels=c("SEDAR 45, SS3.24","SEDAR 45, Update 2014 Comm Landings", "SEDAR 45, Update Rec. Landings", 
"SEDAR 45, Update All Landings"),pdf=TRUE,plotdir=mydir,indexfleets=11)



MYdirvec2<-c(mydir4,mydir7,mydir8,mydir9) #mydir11
BaseComp2 <- SSgetoutput(dirvec=MYdirvec2, forecast=FALSE)
BaseCompSummary2 <- SSsummarize(BaseComp2)
SSplotComparisons(BaseCompSummary2, subplots=c(1:10,13:20), sprtarg=.3, btarg=.3,legendncol = 1,legendloc = "bottomleft", 
                  legendlabels=c("SEDAR 45, SS3.24", 
"SEDAR 45,Update All Landings 2014","Convert SS3.24 to SS3.3","SS3.3 with Updated Landings 2014"),pdf=TRUE,plotdir=mydir,indexfleets=11)



MYdirvec3<-c(mydir4,mydir8) #mydir11
BaseComp3 <- SSgetoutput(dirvec=MYdirvec3, forecast=FALSE)
BaseCompSummary3 <- SSsummarize(BaseComp3)
SSplotComparisons(BaseCompSummary3, subplots=c(1:10,13:20), sprtarg=.3, btarg=.3,legendncol = 1,legendloc = "bottomleft", 
                  legendlabels=c("SEDAR 45, SS3.24", 
"Convert SS3.24 to SS3.3"),pdf=TRUE,plotdir=mydir,indexfleets=11)


MYdirvec4<-c(mydir8,mydir9,mydir14,mydir15) #mydir11
BaseComp4 <- SSgetoutput(dirvec=MYdirvec4, forecast=FALSE)
BaseCompSummary4 <- SSsummarize(BaseComp4)
SSplotComparisons(BaseCompSummary4, subplots=c(1:10,13:20), sprtarg=.3, btarg=.3,legendncol = 1,legendloc = "bottomleft", 
                  legendlabels=c(
"Convert SS3.24 to SS3.3","SS3.3 with Updated Landings 2014","SS3.3, Update Catch, Indices (Cont)"
,"SS3.3 Update Catch, Indices, Length Comps (Cont)"),pdf=TRUE,plotdir=mydir,indexfleets=11)


MYdirvec6<-c(mydir8,mydir9,mydir14,mydir10,mydir15,mydir11) #mydir11
BaseComp6 <- SSgetoutput(dirvec=MYdirvec6, forecast=FALSE)
BaseCompSummary6 <- SSsummarize(BaseComp6)
SSplotComparisons(BaseCompSummary6, subplots=c(1:10,13:20), sprtarg=.3, btarg=.3,legendncol = 1,legendloc = "bottomleft", 
                  legendlabels=c(
"Convert SS3.24 to SS3.3","SS3.3 with Updated Landings 2014","SS3.3, Update Catch, Indices (Cont)","SS3.3, Update Catch, Indices (Combined Video, MS old length comps)"
,"SS3.3 Update Catch, Indices, Length Comps (Cont)","SS3.3 Update Catch, Indices, Length Comps (Combined Video)"),pdf=TRUE,plotdir=mydir,indexfleets=11)

MYdirvec7<-c(mydir8,mydir9,mydir14,mydir10) #mydir11
BaseComp7 <- SSgetoutput(dirvec=MYdirvec7, forecast=FALSE)
BaseCompSummary7 <- SSsummarize(BaseComp7)
SSplotComparisons(BaseCompSummary7, subplots=c(1:10,13:20), sprtarg=.3, btarg=.3,legendncol = 1,legendloc = "bottomleft", 
                  legendlabels=c(
"Convert SS3.24 to SS3.3","SS3.3 with Updated Landings 2014","SS3.3, Update Catch, Indices (Cont)","SS3.3, Update Catch, Indices (Combined Video, MS old length comps)"
),pdf=TRUE,plotdir=mydir,indexfleets=11)



MYdirvec5<-c(mydir8,mydir9,mydir10,mydir11,mydir12,mydir13) #mydir11
BaseComp5 <- SSgetoutput(dirvec=MYdirvec5, forecast=FALSE)
BaseCompSummary5 <- SSsummarize(BaseComp5)
SSplotComparisons(BaseCompSummary5, subplots=c(1:10,13:20), sprtarg=.3, btarg=.3,legendncol = 1,legendloc = "bottomleft", 
                  legendlabels=c(
"Convert SS3.24 to SS3.3","SS3.3 with Updated Landings 2014","SS3.3, Update Catch, Indices"
,"SS3.3 Update Catch, Indices, Length Comps","SS3.3, Update Catch, Indices, Length Comps, Fill Age Comps w/2014","SS3.3, Update Catch, Indices, Length Comps, Drop CPUE"
),pdf=TRUE,plotdir=mydir,indexfleets=11)

