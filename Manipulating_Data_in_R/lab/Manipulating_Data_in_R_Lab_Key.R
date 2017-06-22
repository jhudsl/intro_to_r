###########
## Data Manipulation Lab 
############

library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)


# 1.  Read in the Bike lanes data: http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv 
# Name the data set bike

# 2.  Filter any rows that have a missing value in the "type" column or missing 
# name and re-assign the output to bike

# 3.  Select only the type, length, and name.  Summarize group the data by grouping
# name 
# and take the sum of the length (reassign length variable).  Call this data set sub


# 4. Reshape sub using spread.  Spread the data where the key is type
# and we want the value in the new columns to be "length" - the bike lane length.  
# Call this "wide".  

# look at the column names of wide - what are they? (they also have spaces)

# 5. Reshape wide using gather.  Call this data long.  Make the key
# lanetype, and the value the_length.  Make sure we gather all columns **but**
# name, using -name.

# note the NAs here

## Exercise motivated by 
## http://www.r-bloggers.com/manipulating-data-frames-using-sqldf-a-brief-overview/

## 6. read in the roads and crashes CSVs.  Call them crash and road
# crash: http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/crashes.csv
# road: http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv
crash = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/crashes.csv")
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")

# run head(crash), head(road)

# 7.  Replace (using str_replace) any hyphens (-) with a space in crash$Road.
# Table the road variable.  Call this data crash2

## 8. How many observations are in each dataset?


# 9.  Separate the Road column (using `separate`) into (type and number) in
# crash2.  Reassign this to crash2. Table crash2$type

# Create a new variable calling it road_hyphen usin the unite function.  Unite the
# type and number columns using a hyphen (-) and then table road_hyphen


## 10. Which and how many years were data collected?

## 11. Join data to retain only complete data, (using an inner join)
##	e.g. those observations with road lengths and districts.
# Merge without using `by` argument, then merge using `by = "Road"`.
# call the output merged.  How many observations are there?


## 12. Join data using a full_join.  Call the output full. 
# How many observations are there?


## 13. Do a left join of the road and crash.  ORDER matters here!  How many obersvrations


