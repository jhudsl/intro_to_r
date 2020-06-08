## ----setup, include=FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- message=FALSE---------------------------------------------------------------
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
library(jhur)


## ---------------------------------------------------------------------------------
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
# covert dates
circ = mutate(circ, date = mdy(date))
# change colnames for reshaping
colnames(circ) =  colnames(circ) %>% 
  str_replace("Board", ".Board") %>% 
  str_replace("Alight", ".Alight") %>% 
  str_replace("Average", ".Average") 

# make long
long = gather(circ, "var", "number", 
              starts_with("orange"),
              starts_with("purple"), starts_with("green"),
              starts_with("banner"))
# separate
long = separate(long, var, into = c("line", "type"), 
	sep = "[.]")


## ---------------------------------------------------------------------------------
long = read_circulator_long()


## ---------------------------------------------------------------------------------
## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))

# separate
type_wide = spread(long, type, value = number)
head(type_wide)


## ---------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------





## ---------------------------------------------------------------------------------
pal = c("blue", "darkgreen","orange","purple")




## ---------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------




## ---------------------------------------------------------------------------------



## ---------------------------------------------------------------------------------


