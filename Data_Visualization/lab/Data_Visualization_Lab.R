## ----setup, include=FALSE---------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- message=FALSE---------------------------------------------------
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
library(jhur)


## ---------------------------------------------------------------------
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
# covert dates
circ = mutate(circ, date = mdy(date))
# change colnames for reshaping
colnames(circ) =  colnames(circ) %>% 
  str_replace("Board", ".Board") %>% 
  str_replace("Alight", ".Alight") %>% 
  str_replace("Average", ".Average") 

# make long
long = pivot_longer(circ, 
                    starts_with(c("orange","purple","green","banner")),
                    names_to = "var", values_to = "number")
# separate
long = separate(long, var, into = c("route", "type"), 
	sep = "[.]")


## ---------------------------------------------------------------------
long = read_circulator_long() %>% 
  rename(route = line)


## ---------------------------------------------------------------------
## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))

# separate
type_wide = pivot_wider(long, 
                        names_from = "type", values_from = "number")
head(type_wide)


## ---------------------------------------------------------------------



## ---------------------------------------------------------------------




## ---------------------------------------------------------------------



## ---------------------------------------------------------------------





## ---------------------------------------------------------------------
pal = c("blue", "darkgreen","orange","purple")




## ---------------------------------------------------------------------




## ---------------------------------------------------------------------




## ---------------------------------------------------------------------



## ---------------------------------------------------------------------


