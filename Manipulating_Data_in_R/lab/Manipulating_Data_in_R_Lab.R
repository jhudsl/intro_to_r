###########
## Data Manipulation Lab 
############

library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)

#############################
# Part 1
#############################
# 1.  Read in the Wide Bike lanes data: 
# http://johnmuschelli.com/intro_to_r/data/Bike_Lanes_Wide.csv 
# Name the data set wide
wide = 

# 2. Reshape wide using gather.  Call this data long.  Make the key
# lanetype, and the value the_length.  Make sure we gather all columns **but**
# name, using -name.
long = 

# note the NAs here


#############################
# Part 2
#############################

## Exercise motivated by 
## http://www.r-bloggers.com/manipulating-data-frames-using-sqldf-a-brief-overview/

## 3. read in the roads and crashes CSVs.  Call them crash and road
# crash: http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/crashes.csv
# road: http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv
crash = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/crashes.csv")
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")

# run head(crash), head(road)
head(crash)

head(road)

# 4.  Replace (using str_replace) any hyphens (-) with a space in crash$Road.
# Table the road variable.  Call this data crash2
crash2 = 
## 5. How many observations are in each dataset?


# 6.  Separate the Road column (using `separate`) into (type and number) in
# crash2.  Reassign this to crash2. Table crash2$type
crash2 = 
table()

# Create a new variable calling it road_hyphen usin the unite function.  Unite the
# type and number columns using a hyphen (-) and then table road_hyphen
crash2 = 


## 7. Which and how many years were data collected?


#############################
# Part 3
#############################
# 8.  Read in the Bike lanes data: http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv 
# Name the data set bike
bike = 
  
# 9.  Filter any rows that have a missing value in the "type" column or missing 
# name and re-assign the output to bike
bike = 
  
# 10.  Select only the type, length, and name.  Summarize group the data by grouping
# name 
# and take the sum of the length (reassign length variable).  Call this data set sub
sub = 

# 11. Reshape sub using spread.  Spread the data where the key is type
# and we want the value in the new columns to be "length" - the bike lane length.  
# Call this "wide".  
wide = 
# look at the column names of wide - what are they? (they also have spaces)

#############################
# Part 4
#############################
## 12. Join road and crash to retain only complete data, (using an inner join)
##	e.g. those observations with road lengths and districts.
# Merge without using `by` argument, then merge using `by = "Road"`.
# call the output merged.  How many observations are there?
merged = 

## 13. Join data using a full_join.  Call the output full. 
# How many observations are there?
full = 

## 14. Do a left join of the road and crash.  ORDER matters here!  How many obersvrations
left = 


