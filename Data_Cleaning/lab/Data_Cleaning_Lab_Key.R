## -----------------------------------------------------------------------------
library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)
library(jhur)
library(tidyverse)
library(broom)
library(naniar)

bike <- jhur::read_bike()



## -----------------------------------------------------------------------------
any(is.na(bike$dateInstalled))
#or
bike %>% pull(dateInstalled) %>% is.na() %>% any()


## -----------------------------------------------------------------------------
bike %>%  drop_na(route)


## -----------------------------------------------------------------------------
naniar::gg_miss_var(bike)



## -----------------------------------------------------------------------------
naniar::pct_complete(bike$subType) #this or..
pull(bike, subType) %>% pct_complete() # this


## -----------------------------------------------------------------------------
BloodType <- tibble(gender = 
                    c("M", "Male", "Female", "F", "M", 
                      "Male", "Other", "M", "F", "Other", 
                      "F", "Male", NA, "Male", "Female"), 
                    type = c("A.-", "AB.+", "O.-", "O.+", "AB.-",
                               "B.+", "B.-", "o.-", "O.+", "A.-",
                              "A.+", "O.-", "B.-", "o.+", "AB.-"),
                    infection = c("Yes", "No", "Yes", "No", "No",
                                  "No", "Yes", "No", "Yes", "No",
                                  "No", "Yes", "Yes", "Yes", "NotSure"))

BloodType


## -----------------------------------------------------------------------------
count(BloodType, gender)
sum(is.na(pull(BloodType, gender)))
BloodType %>% pull(gender) %>% is.na() %>% sum()


## -----------------------------------------------------------------------------

BloodType <- BloodType %>%
  mutate(gender = case_when(gender %in% c("M", "m", "Male") ~ "Male", 
                            gender %in% c("F", "female", "Female") ~ "Female",
                            gender %in% c("Other") ~ "Other"))

count(BloodType, gender)



## -----------------------------------------------------------------------------
BloodType %>% count(gender)


## -----------------------------------------------------------------------------
BloodType <- BloodType %>%
  mutate(type = recode(type, "o.-" = "O.-", 
                             "o.+" = "O.+"))
BloodType


## -----------------------------------------------------------------------------
BloodType %>% pull(type) %>% table(useNA = "ifany")
 #or
BloodType %>% count(type)


## -----------------------------------------------------------------------------
##______________ <- ________ %>% 
#________(____, ____ = c(__________, __________), sep = "\\.")

BloodType_split  <- BloodType %>% separate(type, into = c("blood_type", "Rhfactor"), sep = "\\.")


## -----------------------------------------------------------------------------
table(BloodType_split$Rhfactor) # base R
count(BloodType_split,Rhfactor)


## -----------------------------------------------------------------------------
BloodType_split %>%
  filter(blood_type == "O") %>%
  count(infection)


