## 140.886: Intro to R
## Homework 2
## Due Date: Day 3

# Instructions: 
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
# This is a dataset from the "Kaggle" website, which hosts competitions for prediction and machine learning. 
# More details on this dataset are here: 
# http://www.kaggle.com/c/DontGetKicked/details/Background

# 1)	Get the dataset: http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv
# read the data set in using read_csv, name the dataset cars.

# 2)	Read the "dictionary": http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary_formatted.txt
# use the read_tsv function
# Read in the dictionary and name it key.  Use read_tsv

# What would you do if the data was formatted like this:
# http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary.txt
# with spaces and tabs and such?

# Questions
# 1)	Read in the dataset itself, naming the R object "cars" into R. Use read_csv
# Read in the dictionary and name it key.  Use read_tsv

### Save the key and data in an ".rda" file so you can access the data offline. 
# use the save(cars, key, file = "kaggle.rda")

# 2)	How many cars are in the dataset? How many variables are recorded for each car?
# nrow counts what?  ncol counts what?  what does dim do?  
# what does length(cars) give you?


# 3)	What is the range of the manufacturer's years of the vehicles? Use VehYear
# use the $ notation to extract VehYear
# How many cars were from before 2004, 
# and percent/proportion of these in the population?
# use summarize/filter or sum

# 4)	Drop any vehicles that cost less than or equal to $1500 (VehBCost), 
# or missing - (filter removes missing values !)
# how many vehicles were removed? 
# The rest of the questions expect answers based on this reduced dataset.


# 5)	How many different vehicle a) manufacturers/makes (Make) 
# b) models (Model) and c) sizes (Size) are there?
# use table or group_by with tally/summarize


# 6)	Which vehicle a) make, b) model and c) color had the highest average 
# acquisition cost paid for the vehicle at time of purchase, and what was 
# this cost?
# use  group_by with summarize

# 7)	Which vehicle a) make, b) model and c) color had the highest variability 
# in acquisition cost paid for the vehicle at time of purchase?

# 8)	Display the relationship between acquisition cost and mileage, 
# and describe this relationship
# maybe see if you can do a plot, see the cor function

# 9)	Which variables of cost, odometer reading, and/or 
# warranty (if any) visually appear to associate with a car 
# being a "lemon"/bad purchase?  Do a scatterplot matrix or 
# series of scatterplots

# 10)	 How many vehicles (using filter or sum):
	# a.	Were red and have fewer than 30,000 miles?

	# b.	Are made by GMC and were purchased in Texas? 

	# c.	Are blue or red?

	# d.	Are made by Chrysler or Nissan and are white or silver? 

	# e.	Are automatic, blue, Pontiac cars with under 40,000 miles? 

	
