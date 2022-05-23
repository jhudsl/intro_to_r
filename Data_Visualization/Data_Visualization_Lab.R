## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- message=FALSE-----------------------------------------------------------
library(readr)
library(ggplot2)
library(dplyr)
library(jhur)


## -----------------------------------------------------------------------------
bike = read_bike()

bike_agg <- 
  bike %>%
  # filter data to keep only these observations for which year is non-0
  filter(dateInstalled != 0) %>%
  group_by(dateInstalled) %>%
  summarise(lane_avg_length = mean(length)) 

bike_agg



## -----------------------------------------------------------------------------
##ggplot(???, aes(x = ???, y = ???)) + 
  #??? + 
  #???



## -----------------------------------------------------------------------------





## -----------------------------------------------------------------------------
##  my_plot + 
  # scale_x_continuous(?????) + 
  # scale_y_continuous(????)  # force y-axis to start from 0, do not force upper bound 
  



## -----------------------------------------------------------------------------
#my_plot + theme_bw()



## -----------------------------------------------------------------------------
bike_agg_2 <- 
  bike %>%
  filter(dateInstalled != 0) %>%
  group_by(dateInstalled, type) %>%
  summarise(lane_count = n())

bike_agg_2


## -----------------------------------------------------------------------------






## -----------------------------------------------------------------------------




