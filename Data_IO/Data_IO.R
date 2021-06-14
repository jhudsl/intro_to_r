## ---- echo = FALSE------------------------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")


## ----read_url, message = FALSE------------------------------------------------
# load library `readr` that contains function `read_csv`
library(readr)
dat = read_csv("http://johnmuschelli.com/intro_to_r/data/Youth_Tobacco_Survey_YTS_Data.csv")

# `head` displays first few rows of a data frame 
head(dat, 5)


## ---- eval = FALSE------------------------------------------------------------
## ## Examples
## 
## dat = read_csv("/Users/martakaras/Downloads/Youth_Tobacco_Survey_YTS_Data.csv")
## 
## dat = read_csv("Youth_Tobacco_Survey_YTS_Data.csv")
## 
## dat = read_csv("www.someurl.com/table1.csv")


## ---- eval = FALSE------------------------------------------------------------
## ## Examples
## dat = read_delim("Youth_Tobacco_Survey_YTS_Data.csv", delim = ",")
## 
## dat = read_delim("www.someurl.com/table1.txt", delim = "\t")


## ----readCSV2-----------------------------------------------------------------
dat = read_csv("../data/Youth_Tobacco_Survey_YTS_Data.csv")


## ----stop_problems------------------------------------------------------------
problems(dat)
spec(dat)


## ----stop_problems2-----------------------------------------------------------
stop_for_problems(dat)


## ---- eval = FALSE------------------------------------------------------------
## ?read_delim
## help("read_delim")


## ----readCSV_readr, message=FALSE---------------------------------------------
head(dat, 3)
class(dat)


## ---- dims--------------------------------------------------------------------
dim(dat)
nrow(dat)
ncol(dat)


## ---- colnames_rownames-------------------------------------------------------
colnames(dat)


## ----workingDirectory,eval=FALSE----------------------------------------------
## # get the working directory
## getwd()
## setwd("~/Lectures")


## ----directoryNav-------------------------------------------------------------
dir("./") # shows directory contents
dir("..")


## ---- eval = FALSE------------------------------------------------------------
## setwd("~/Lectures/Data_IO/lecture")


## ----writecsv,eval=FALSE------------------------------------------------------
## # load `dplyr` package that has `rename` function
## library(dplyr)
## dat = rename(dat, Location_Abbr = LocationAbbr)
## 
## write_csv(dat, path = "YouthTobacco_newNames.csv")


## -----------------------------------------------------------------------------
write_rds(dat, file = "yts_dataset.rds")


## -----------------------------------------------------------------------------
dat2 = read_rds(file = "yts_dataset.rds")
identical(dat, dat2) # test if they are the same 


## ---- message = FALSE---------------------------------------------------------
x = 5; # can have semicolons a the end!

# calling read_csv function and pasting a long string together
yts = readr::read_csv(
  paste0("http://johnmuschelli.com/intro_to_r/",
         "data/Youth_Tobacco_Survey_YTS_Data.csv")) 

# saving two files 
save(yts, x, file = "yts_data.rda")


## -----------------------------------------------------------------------------
ls() # list things in the workspace
rm(list = c("x", "yts"))
ls()
z = load("yts_data.rda")
ls()


## -----------------------------------------------------------------------------
z = load("yts_data.rda")
print(z)


## ---- echo = FALSE, message = FALSE, results='hide'---------------------------
file.remove("yts_data.rda") # removing temporary file

