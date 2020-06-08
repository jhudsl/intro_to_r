## ---------------------------------------------------------------------------------
library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)
library(jhur)

bike = read_csv(
  "http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")


## ---------------------------------------------------------------------------------
library(jhur)
bike = read_bike()


## ----q1---------------------------------------------------------------------------
head(factor(bike$type))

btypes = sort(unique(bike$type))
x = c("SIDEPATH","BIKE BOULEVARD", "BIKE LANE", "CONTRAFLOW",
        "SHARED BUS BIKE",  "SHARROW",  "SIGNED ROUTE")
dput(btypes)
dput(btypes)[c(6,1:5,7)]
dput(btypes[c(6,1:5,7)])

lev = c( "SIDEPATH", "BIKE BOULEVARD", "BIKE LANE", "CONTRAFLOW", "SHARED BUS BIKE", 
        "SHARROW", "SIGNED ROUTE")


## ----q2---------------------------------------------------------------------------
bike$type = factor(bike$type)
bike$type = relevel(bike$type, "SIDEPATH")
bike$type = factor(bike$type,
          levels = dput(btypes[c(6,1:5,7)]))
bike = bike %>% mutate(type = factor(type, 
                levels = dput(btypes[c(6,1:5,7)])))

table(bike$type)


## ----q3---------------------------------------------------------------------------
bike = bike %>% 
  mutate(type2 = factor(type, 
             levels = c( "SIDEPATH", "BIKE BOULEVARD", 
                         "BIKE LANE") ) )
table(bike$type)
table(bike$type2)
table(bike$type2, useNA = "always")


## ----q4a--------------------------------------------------------------------------
bike = bike %>% 
  mutate(dateInstalled = 
           as.character(dateInstalled)
  )
head(bike$dateInstalled)


## ----q4b--------------------------------------------------------------------------
bike = bike %>% 
  mutate(dateInstalled = 
           factor(dateInstalled)
  )
head(bike$dateInstalled)

table(factor(bike$dateInstalled, levels = 2005:2017))
table(factor(bike$dateInstalled, levels = 2005:2017), 
        useNA="ifany")


## ----q4c--------------------------------------------------------------------------
head(as.numeric(bike$dateInstalled)) 


## ----q4d--------------------------------------------------------------------------
head(as.numeric(as.character(
    bike$dateInstalled)))


## ----q5---------------------------------------------------------------------------
 
bike = bike %>% mutate(
    type = as.character(type),
    type2 = ifelse(type %in% c("CONTRAFLOW", "SHARED BUS BIKE", 
                               "SHARROW", "SIGNED ROUTE"), "OTHER", type),
    type2 = factor(type2, levels = c( "SIDEPATH", "BIKE BOULEVARD", 
                               "BIKE LANE", "OTHER") ))

table(bike$type2)

bike2 = bike %>% 
  mutate(
    type = factor(type,
                  levels = c( "SIDEPATH", "BIKE BOULEVARD", 
                              "BIKE LANE", "CONTRAFLOW", 
                              "SHARED BUS BIKE", 
                              "SHARROW", "SIGNED ROUTE")
                  ),
    type2 = recode_factor(type, 
                          "CONTRAFLOW" = "OTHER",
                          "SHARED BUS BIKE" = "OTHER",
                          "SHARROW" = "OTHER",
                          "SIGNED ROUTE" = "OTHER")
  )
table(bike2$type2)


## ----q6a--------------------------------------------------------------------------
ymd("2014/02-14")


## ----q6b--------------------------------------------------------------------------
mdy_hm("04/22/14 03:20")


## ----q6c--------------------------------------------------------------------------
mdy_hms("4/5/2016 03:2:22")

