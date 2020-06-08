## ----setup, include=FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---------------------------------------------------------------------------------
library(readr)
library(dplyr)
library(tidyverse)
library(jhur)

bike = read_csv(
  "http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")


## ---------------------------------------------------------------------------------
library(jhur)
bike = read_bike()


## ----q1---------------------------------------------------------------------------
nrow(bike)
dim(bike)
bike %>% 
  nrow()


## ----q2---------------------------------------------------------------------------
sum(bike$length)
sum(bike$length)/5280
sum(bike$length/5280)


## ----q3---------------------------------------------------------------------------
table(bike$type, useNA = "ifany")
unique(bike$type)
length(table(bike$type))
length(unique(bike$type))

is.na(unique(bike$type))

counts = bike %>% 
  count(type)

bike %>% 
  group_by(type) %>% 
  summarise(number_of_rows = n(),
            mean = mean(length)) %>% 
  arrange(mean)


## ----q4---------------------------------------------------------------------------
length(unique(bike$project))

bike %>% 
  group_by(project) %>% 
  summarise(n = n(),
            mean = mean(length)) %>% 
  arrange(desc(mean)) 

bike %>% 
  group_by(project, type) %>% 
  summarise(n = n(),
            mean = mean(length)) %>% 
  arrange(desc(mean)) %>% 
  ungroup() %>% 
  slice(1) %>% 
  magrittr::extract("project")

arrange(summarize(group_by(bike, project, type), 
          n = n(), mean = mean(length)),
        desc(mean))

avg = bike %>% 
  group_by(type) %>% 
  summarize(mn = mean(length, na.rm = TRUE)) %>% 
  filter(mn == max(mn))


## ----q5---------------------------------------------------------------------------
bike = bike %>% mutate(
  dateInstalled = ifelse(
    dateInstalled == 0, 
    NA,
    dateInstalled)
)
mean(bike$length[ !is.na(bike$dateInstalled)])

is.na(bike$dateInstalled)
!is.na(bike$dateInstalled)


## ---------------------------------------------------------------------------------
b2 = bike %>% 
  mutate(dateInstalled = ifelse(dateInstalled == "0", NA, 
                                dateInstalled))
b2 = bike %>% 
  mutate(dateInstalled = if_else(dateInstalled == "0", 
                                 NA_real_,
                                 dateInstalled))
bike$dateInstalled[bike$dateInstalled == "0"] = NA

bike %>% 
  mutate(length = ifelse(length == 0, NA, length)) %>% 
  group_by(dateInstalled) %>% 
  summarise(n = n(),
            mean_of_the_bike = mean(length, na.rm = TRUE),
            n_missing = sum(is.na(length)))

            


## ----q6---------------------------------------------------------------------------
quantile(bike$length)

qplot(x = length, data = bike, geom = "histogram")
qplot(x = log10(length), data = bike, geom = "histogram")

hist(bike$length)
hist(bike$length,breaks=100)

hist(log2(bike$length),breaks=100)
hist(log10(bike$length),breaks=100)


## ----q7---------------------------------------------------------------------------
qplot(y = length, x = type, data = bike, geom = "boxplot")
qplot(y = length, x = factor(numLanes), data = bike, geom = "boxplot")


## ---------------------------------------------------------------------------------
boxplot(bike$length~bike$type)
boxplot(bike$length~bike$type, las=3)
boxplot(bike$length~bike$numLanes)

bike$length[1] = NA

boxplot(log10(bike$length)~bike$type)


bike %>% 
  group_by(type) %>% 
  summarise(q0.7 = quantile(length, na.rm = TRUE, probs =0.7))









