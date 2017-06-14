## ---- echo = FALSE-------------------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")

## ----workingDirectory,eval=FALSE-----------------------------------------
## ## get the working directory
## getwd()
## setwd("~/Lectures")

## ----directoryNav--------------------------------------------------------
dir("./") # shows directory contents
dir("..")

## ---- eval = FALSE-------------------------------------------------------
## setwd("~/Lectures/Data_IO/lecture")

## ---- eval = FALSE-------------------------------------------------------
## ?dir
## help("dir")

## ----readCSV-------------------------------------------------------------
read_csv

## ----readCSV2------------------------------------------------------------
dat = read_csv("../data/Youth_Tobacco_Survey_YTS_Data.csv")

## ----readCSV_readr, message=FALSE----------------------------------------
library(readr)
head(dat)
class(dat)

## ---- viewTibble---------------------------------------------------------
dat

## ---- readingCSV---------------------------------------------------------
dat2 = read.csv("../data/Youth_Tobacco_Survey_YTS_Data.csv", as.is=TRUE)
head(dat2)

## ----names1--------------------------------------------------------------
names(dat)[1] = "year"
names(dat)

## ----writecsv,eval=FALSE-------------------------------------------------
## names(dat)[1] = "Year"
## write_csv(dat, path="YouthTobacco_newNames.csv")

