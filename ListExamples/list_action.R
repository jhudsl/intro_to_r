library(dplyr)
library(lubridate)

## get files
files = list.files("Reports", full.names=TRUE)
names(files) = gsub("_Report.txt", "", list.files("Reports"))

## read in as list
fileList = lapply(files, read.delim, header=TRUE, as.is=TRUE)

## combine? this is useful in dplyr, from john
dat = bind_rows(fileList, .id = "Date")
# trick to use lubridate, needs day
dat$Date = myd(paste0(dat$Date, "_01")) 

## order by date, then id
dat = dat %>% arrange(Date, id)

## do stuff to overall table
## filter based on criteria?

## group by randomization block
dat = dat %>% group_by(block)

## or split
datList = split(dat, dat$block)

## write back out
dir.create("ReportsByBlock")
for(i in seq(along=datList)) {
    write.csv(datList[[i]], row.names=FALSE,
          file = paste0("ReportsByBlock/surveyData_byBlock_",names(datList)[i],".csv"))
    
}

## or lapply, prints random null stuff though
lapply(seq(along=datList), function(i) { 
  write.csv(datList[[i]], row.names=FALSE,
            file = paste0("ReportsByBlock/surveyData_byBlock_",names(datList)[i],".csv"))
  
})
