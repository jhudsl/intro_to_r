## 140.886: Intro to R
## Homework 2
## Due Date: Day 3

### Please use `knitr` to write up this homework.

# Instructions: 
# 1)	Get the dataset: http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv
# 2)	Read the "dictionary": http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary.txt
# This is a dataset from the "Kaggle" website, which hosts competitions for prediction and machine learning. 
# More details on this dataset are here: 
# http://www.kaggle.com/c/DontGetKicked/details/Background

# Questions
# 1)	Read in the dataset itself, naming the R object "cars" into R (as separate objects).  
# Read in the dictionary and name it key
### Save the key and data in an ".rda" file so you can access the data offline. 
# use the save(cars, key, file = "kaggle.rda")

# 2)	How many cars are in the dataset? How many variables are recorded for each car?

# 3)	What is the range of the manufacturer's years of the vehicles? How many cars were from before 2004, and what percent/proportion of the cars are these older models?

# 4)	Drop any vehicles that cost less than $1500 - how many vehicles were removed, and how much were they? The rest of the questions expect answers based on this reduced dataset.

# 5)	How many different vehicle a) manufacturers/makes b) models and c) sizes are there?

# 6)	Which vehicle a) make, b) model and c) color had the highest average acquisition cost paid for the vehicle at time of purchase, and what was this cost?

# 7)	Which vehicle a) make, b) model and c) color had the highest variability in acquisition cost paid for the vehicle at time of purchase?

# 8)	Display the relationship between acquisition cost and mileage, and describe this relationship

# 9)	Which variables of cost, odometer reading, and/or warranty (if any) visually appear to associate with a car being a "lemon"/bad purchase?

# 10)	 How many vehicles:
	# a.	Were red and have fewer than 30,000 miles?

	# b.	Are made by GMC and were purchased in Texas? 

	# c.	Are blue or red?

	# d.	Are made by Chrysler or Nissan and are white or silver? 

	# e.	Are automatic, blue, Pontiac cars with under 40,000 miles? 

	
