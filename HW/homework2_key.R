## 140.886: Intro to R
## Homework 2
## Due Date: Day 3

library(tidyverse)
library(broom)
# Instructions: 
# 1)	Get the dataset: http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv
# 2)	Read the "dictionary": http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary_formatted.txt
# What would you do if the data was formatted like this:
# http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary.txt
# with spaces and tabs and such?
# This is a dataset from the "Kaggle" website, which hosts competitions for prediction and machine learning. 
# More details on this dataset are here: 
# http://www.kaggle.com/c/DontGetKicked/details/Background

# Questions
# 1)	Read in the dataset itself, naming the R object "cars" into R. Use read_csv
# Read in the dictionary and name it key.  Use read_tsv
cars = read_csv(
  "http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv",
  col_types = cols(
    VehBCost = col_double()
  )
  )
key = read_tsv("http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary_formatted.txt")


### Save the key and data in an ".rda" file so you can access the data offline. 
# use the save(cars, key, file = "kaggle.rda")
save(cars, key, file = "HW/kaggle.rda")

# 2)	How many cars are in the dataset? How many variables are recorded for each car?
dim(cars)
nrow(cars)

# 3)	What is the range of the manufacturer's years of the vehicles? Use VehYear
# How many cars were from before 2004, and percent/proportion of these in the population?
range(cars$VehYear)
table(cars$VehYear)
sum(cars$VehYear < 2004)
mean(cars$VehYear < 2004)

# 4)	Drop any vehicles that cost less than or equal to $1500 (VehBCost), 
# or missing - 
# how many vehicles were removed? 
# The rest of the questions expect answers based on this reduced dataset.
sum(cars$VehBCost <= 1500 | is.na(cars$VehBCost))
cars = filter(cars, VehBCost > 1500)
nrow(cars)

# 5)	How many different vehicle a) manufacturers/makes (Make) 
# b) models (Model) and c) sizes (Size) are there?
length(unique(cars$Make)) # a
length(table(cars$Make))
length(unique(cars$Model)) # b
length(unique(cars$Size)) # c

# 6)	Which vehicle a) make, b) model and c) color had the highest average acquisition 
# cost (cars$VehBCost) paid for the vehicle at time of purchase, and what was this cost?
# use group_by and arrange
cars %>% group_by(Make) %>% 
  summarize(mean = mean(VehBCost)) %>% 
  arrange(desc(mean))
cars %>% group_by(Model) %>% 
  summarize(mean = mean(VehBCost)) %>% 
  arrange(desc(mean))

cars %>% group_by(Color) %>% 
  summarize(mean = mean(VehBCost)) %>% 
  arrange(desc(mean))

# Base R Way
makeTab = tapply(cars$VehBCost, cars$Make, mean)
makeTab[which.max(makeTab)] # a

modelTab = tapply(cars$VehBCost, cars$Model, mean)
modelTab[which.max(modelTab)] # b

colorTab = tapply(cars$VehBCost, cars$Color, mean)
colorTab[which.max(colorTab)] # c

# 7)	Which vehicle a) make, b) model and c) color had the highest variability in acquisition cost paid for the vehicle at time of purchase?
cars %>% group_by(Make) %>% 
  summarize(var = var(VehBCost)) %>% 
  arrange(desc(var))
cars %>% group_by(Model) %>% 
  summarize(var = var(VehBCost)) %>% 
  arrange(desc(var))

cars %>% group_by(Color) %>% 
  summarize(var = var(VehBCost)) %>% 
  arrange(desc(var))

makeTab2 = tapply(cars$VehBCost, cars$Make, sd)
makeTab2[which.max(makeTab2)] # a

modelTab2 = tapply(cars$VehBCost, cars$Model, sd)
modelTab2[which.max(modelTab2)] # b

colorTab2 = tapply(cars$VehBCost, cars$Color, sd)
colorTab2[which.max(colorTab2)] # c

# 8)	Display the relationship between acquisition cost and mileage, and \
# describe this relationship using `plot`
plot(VehBCost ~ VehOdo, data = cars)
plot(log2(VehBCost) ~ VehOdo, data=cars)
smoothScatter(cars$VehOdo, log2(cars$VehBCost))

# 9)	Which variables of cost, odometer reading, and/or warranty (if any) visually appear to 
# associate with a car being a "lemon"/bad purchase?  Use boxplots
boxplot(VehBCost ~ cars$IsBadBuy, data=cars,ylab="Cost")
boxplot(VehOdo ~ cars$IsBadBuy, data=cars, ylab= "Odometer")
boxplot(WarrantyCost ~ cars$IsBadBuy, data=cars, ylab="Warranty")

# 10)	 How many vehicles:
# a.	Were red and have fewer than 30,000 miles?
sum(cars$Color == "RED" & cars$VehOdo < 30000)

# b.	Are made by GMC and were purchased in Texas? 
sum(cars$Make == "GMC" & cars$VNST == "TX")

# c.	Are blue or red?
sum(cars$Color == "BLUE" | cars$Color == "RED" )
sum(cars$Color %in% c("BLUE","RED"))

# d.	Are made by Chrysler or Nissan and are white or silver? 
sum((cars$Make == "CHRYSLER" | cars$Make=="NISSAN") & (cars$Color == "WHITE" | cars$Color == "WHITE" ))
sum(cars$Make %in% c("CHRYSLER","NISSAN") & 
	cars$Color %in% c("WHITE","SILVER" ))

# e.	Are automatic, blue, Pontiac cars with under 40,000 miles? 
sum(cars$Transmission == "AUTO" & cars$Color=="BLUE" & 
	cars$Make == "PONTIAC" & cars$VehOdo < 40000)
sum(cars$Transmission == "AUTO" & cars$Color=="BLUE" & 
	cars$Make == "PONTIAC" & cars$VehOdo < 40000)

	
