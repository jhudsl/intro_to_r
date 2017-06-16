###########
## Data Manipulation
## Lab 
## 1/12/2017
############

## Exercise motivated by 
## https://www.r-bloggers.com/manipulating-data-frames-using-sqldf-a-brief-overview/
library(readr)
library(dplyr)

## 1. read in the roads and crashes CSVs
# crashes: http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/crashes.csv
# roads: http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv
crash = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/crashes.csv")
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")

## 2. How many observations are in each dataset?
dim(crash)
dim(road)

## 3. Which and how many years were data collected?
unique(crash$Year)
length(unique(crash$Year))

## 4. Join data to retain only complete data, 
##	e.g. those observations with road lengths and districts
dat = inner_join(crash, road,by="Road")
dat = merge(crash, road, by="Road") %>% as.tbl

## 5. Which district had the largest volume of traffic, 
##		per mile/unit length over the provided years?
dat$VolPerMile = dat$Volume/dat$Length
dat = dat %>% mutate(VolPerMile = Volume/Length)

dat %>% group_by(District) %>% 
	summarize(Total = sum(VolPerMile))

# all in one shot
dat %>% mutate(VolPerMile = Volume/Length) %>% 
	group_by(District) %>% summarize(Total = sum(VolPerMile))


## 6. Which district had the largest number of crashes, 
##		accounting for road length and volume 
## 		over the provided years?

dat %>% mutate(CrashAdj = N_Crashes/(Volume/1000)/Length) %>% 
	group_by(District) %>% summarize(Total = sum(CrashAdj))
## per thousand cars and mile


dat %>% group_by(District) %>%
    summarize(Total = sum(N_Crashes))
