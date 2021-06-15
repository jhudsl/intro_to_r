## ---- echo = FALSE------------------------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")


## ----read_url, message = FALSE------------------------------------------------
# load library `readr` that contains function `read_csv`
library(readr)
dat = read_csv("http://jhudatascience.org/intro_to_r/data/Youth_Tobacco_Survey_YTS_Data.csv")

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


## ----workingDirectory,eval=FALSE----------------------------------------------
## # get the working directory
## getwd()
## 
## # set the working directory
## setwd("/Users/martakaras/Desktop")


## ---- eval = FALSE------------------------------------------------------------
## # Examples
## 
## write_csv(dat, file = "YouthTobacco_newNames.csv")
## 
## write_delim(dat, file = "YouthTobacco_newNames.csv", delim = ",")


## -----------------------------------------------------------------------------
# write a variable: a data frame "dat" 
write_rds(dat, file = "yts_dataset.rds")

# write a variable: vector "x"
x <- c(1,3,3)
write_rds(x, file = "my_vector.rds")

# read a variable from file and assign to a new variable named "y"
x2 <- read_rds("my_vector.rds")
x2

