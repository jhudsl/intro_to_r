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
wide = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes_Wide.csv")

# 2. Reshape wide using gather.  Call this data long.  Make the key
# lanetype, and the value the_length.  Make sure we gather all columns **but**
# name, using -name.
long = wide %>% 
  gather(key = "lanetype", value = "the_length", -name)

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

# 4.  Replace (using str_replace) any hyphens (-) with a space in crash$Road.
# Table the road variable.  Call this data crash2
crash2 = crash %>% mutate(Road = str_replace(Road, "-", " "))

## 5. How many observations are in each dataset?
dim(crash)
dim(road)

# 6.  Separate the Road column (using `separate`) into (type and number) in
# crash2.  Reassign this to crash2. Table crash2$type
crash2 = separate(crash2, col = "Road", into = c("type", "number"))
table( crash2$type)

# Create a new variable calling it road_hyphen usin the unite function.  Unite the
# type and number columns using a hyphen (-) and then table road_hyphen
crash2 = unite(crash2, col = "road_hyphen", type, number ,sep = "-")
table( crash2$road_hyphen)


## 7. Which and how many years were data collected?
unique(crash$Year)
length(unique(crash$Year))

#############################
# Part 3
#############################
# 8.  Read in the Bike lanes data: http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv 
# Name the data set bike
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")

# 9.  Filter any rows that have a missing value in the "type" column or missing 
# name and re-assign the output to bike
bike = filter(bike, !is.na(type), !is.na(name))

# 10.  Select only the type, length, and name.  Summarize group the data by grouping
# name 
# and take the sum of the length (reassign length variable).  Call this data set sub
sub = bike %>% 
  select(type, length, name) %>% 
  group_by(name, type) %>% 
  summarize(length = sum(length))

# 11. Reshape sub using spread.  Spread the data where the key is type
# and we want the value in the new columns to be "length" - the bike lane length.  
# Call this "wide".  
wide = spread(sub, key = type, value = length)

# look at the column names of wide - what are they? (they also have spaces)

#############################
# Part 4
#############################
## 12. Join data to retain only complete data, (using an inner join)
##	e.g. those observations with road lengths and districts.
# Merge without using `by` argument, then merge using `by = "Road"`.
# call the output merged.  How many observations are there?
merged = inner_join(crash, road)
merged = inner_join(crash, road, by = "Road")
dim(merged)

## 13. Join data using a full_join.  Call the output full. 
# How many observations are there?
full = full_join(crash, road)
nrow(full)

## 14. Do a left join of the road and crash.  ORDER matters here!  How many obersvrations
left = left_join(road, crash)
nrow(left)

right = right_join(road, crash)
nrow(right)

