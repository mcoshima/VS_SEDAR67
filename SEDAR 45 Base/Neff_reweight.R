# Iterative reweighting of Neff for Age comps and length comps
# Matthew Smith 
# matthew.w.smith@noaa.gov
# Version 1.0 
# created on 1/8/2015

# function uses the Neff values created by SS to iteratively reweigth the age or length comps.  Success is achieved when the difference between
# the input N's and the estimated Neff is minimized calculated as sum((effN - N)^2)

#Arguments
# replist - list of SS output obtained by running the r4ss SS_output function
# kind - either 'AGE' or 'LEN' depending on whether the age comp or length comp N's are to be reweighted
# dat_file_name - name of the SS datafile (e.g., vermilion.dat)
# max_effn - maximum effective N.  After solution is found any effective N greater than this value will be reduced to this value
# hessian - logical, do you want final SS run to estimate the hessian (T) or not (F)
# crit - initial critical value (do not change)


direct <- getwd()

require(r4ss)
dat_file_name <- 'vermilion.dat'

base <- SS_output(dir = direct, covar=T, cormax=0.70, forecast=F, verbose = F)
#ss_dat <- SS_readdat(paste0(direct, '/', dat_file_name))

Reweighter <- function(replist, kind = 'AGE', dat_file_name, max_effn = 100)
{
  if(kind == 'AGE') {
    ss_dat <- SS_readdat(paste0(direct, '/', dat_file_name), verbose = F) # read in SS datafile
    report_base <- replist$agedbase # extract agecomp data from report file
    dat_base <- ss_dat$agecomp # extract agecomp data from SS.dat file
    report_extract <- unique(report_base[, c('Yr', 'Seas', 'Fleet', 'Gender', 'effN')]) #Select unique rows from report file
    
    if(dim(dat_base)[1] != dim(report_extract)[1]) {
      stop('age comp data extracted from report file is not of the same dimension as the input age comp.  Function may need repaired')
    } # error trap comparing rows of .dat age comp and unique report file age comp.  if no match problem
    
    check <- sum((report_extract$effN - dat_base$Nsamp)^2) # calculate rough sum of squares
    print(paste('Check value this iteration is', check))   # print stat value
    ss_dat_new <- ss_dat # create duplicate of SS.dat file
    
    for(i in unique(dat_base$FltSvy)){ # replace agecomp N's with report file Neffs
      dat_base[dat_base$FltSvy == i, ]$Nsamp <- report_extract[report_extract$Fleet == i, ]$effN
    }
        
    ss_dat_new$agecomp <- dat_base # replace dat list age comp with new agecomp
    SS_writedat(ss_dat_new, paste0(direct, '/', dat_file_name), overwrite = T, verbose = F) #write out new .dat file
    system("SS3 -nohess",wait=T,show.output.on.console=F) #run ss  
    base_new <- SS_output(dir = direct, covar=F, cormax=0.70, forecast=F, verbose = F, printstats = F) #read in ss report
    report_base_new <- base_new$agedbase
    dat_base_new <- ss_dat_new$agecomp
    report_extract_new <- unique(report_base_new[, c('Yr', 'Seas', 'Fleet', 'Gender', 'effN')])
    check_new <- sum((report_extract_new$effN - dat_base_new$Nsamp)^2)
    
    if(check_new < check){
       Reweighter(base_new, kind = 'AGE', dat_file_name, max_effn)
    } else {
      if(any(dat_base$Nsamp > max_effn)){
        dat_base[dat_base$Nsamp > max_effn, ]$Nsamp <- max_effn
        ss_dat$agecomp <- dat_base
        SS_writedat(ss_dat, paste0(direct, '/', dat_file_name), overwrite = T, verbose = F)
      }
      system("SS3 -nohess",wait=T,show.output.on.console=T) 
    }
  }
  #------------------------------------------------------
  if(kind == 'LEN') {
    ss_dat <- SS_readdat(paste0(direct, '/', dat_file_name), verbose = F) # read in SS datafile
    report_base <- replist$lendbase # extract lengthcomp data from report file
    dat_base <- ss_dat$lencomp # extract lengthcomp data from SS.dat file
    report_extract <- unique(report_base[, c('Yr', 'Seas', 'Fleet', 'Gender', 'effN')]) #Select unique rows from report file
    
    if(dim(dat_base)[1] != dim(report_extract)[1]) {
      stop('age comp data extracted from report file is not of the same dimension as the input age comp.  Function may need repaired')
    } # error trap comparing rows of .dat age comp and unique report file age comp.  if no match problem
    
    check <- sum((report_extract$effN - dat_base$Nsamp)^2) # calculate rough sum of squares
    print(paste('Check value this iteration is', check))   # print stat value
    ss_dat_new <- ss_dat # create duplicate of SS.dat file
    
    for(i in unique(dat_base$FltSvy)){ # replace agecomp N's with report file Neffs
      dat_base[dat_base$FltSvy == i, ]$Nsamp <- report_extract[report_extract$Fleet == i, ]$effN
    }
        
    ss_dat_new$lencomp <- dat_base # replace dat list age comp with new agecomp
    SS_writedat(ss_dat_new, paste0(direct, '/', dat_file_name), overwrite = T, verbose = F) #write out new .dat file
    system("SS3 -nohess",wait=T,show.output.on.console=F) #run ss  
    base_new <- SS_output(dir = direct, covar=F, cormax=0.70, forecast=F, verbose = F, printstats = F) #read in ss report
    report_base_new <- base_new$lendbase
    dat_base_new <- ss_dat_new$lencomp
    report_extract_new <- unique(report_base_new[, c('Yr', 'Seas', 'Fleet', 'Gender', 'effN')])
    check_new <- sum((report_extract_new$effN - dat_base_new$Nsamp)^2)
    
    if(check_new < check){
      Reweighter(base_new, kind = 'LEN', dat_file_name, max_effn)
    } else {
      if(any(dat_base$Nsamp > max_effn)){
        dat_base[dat_base$Nsamp > max_effn, ]$Nsamp <- max_effn
        ss_dat$lencomp <- dat_base
        SS_writedat(ss_dat, paste0(direct, '/', dat_file_name), overwrite = T, verbose = F)
      }
      system("SS3",wait=T,show.output.on.console=T) 
    }
  }
}
    

Reweighter(base, 'AGE', dat_file_name)
Reweighter(base, 'LEN', dat_file_name)




 