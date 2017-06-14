####################
# 140.886: Intro to R
# Homework 3
# Assigned Date: Day 2
# Due Date: Day 4 

# Instructions: 
# A)	Use this dataset on infant mortality for the following questions:
# http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv

# B) Use Knitr to write up this homework. 

# Questions
# 1.	Create a integer ‘year’ variable using the column names, 
#			and print the head() and class() of this new vector

# 2.	Transpose the dataset such that countries are the columns 
#			and years are the rows. Append the ‘year’ vector from above.
#			Show [1:5,1:5] of this transposed data frame. 

# 3.	Read in this the tab-delim file:
#		http://johnmuschelli.com/intro_to_r/data/country_pop.txt
#		which contains population information on each country

library(readr)
res = read.delimtsv("http://johnmuschelli.com/intro_to_r/data/country_pop.txt")
no_bad_char = read_tsv("http://johnmuschelli.com/intro_to_r/data/country_pop.txt", 
                       locale = locale(encoding = "Latin1"))

with_base = read.delim("http://johnmuschelli.com/intro_to_r/data/country_pop.txt",
                       fileEncoding = "Latin1")

# 4.	Determine the population of each country in our dataset, 
#			and then sort the columns of our dataset by that
#			population, from smallest to largest. 
#			Show [1:5,1:5] of this sorted data frame. 

# 5.	Plotting: we talked about lattice::levelplot() but R has 
#			two similar plots called image() and heatmap(). 
#			Create the following levelplots using 
#			lattice::levelplot() and image():
# 		a.	Years 1840-1900 for countries that start 
#				with the letter ‘A’
# 		b.	Years 1950-1975 for the 10 largest countries 
#				and the 10 smallest countries 

# 6.	Plotting: create “spaghetti”/line plots 
#		(one line per country) using lattice for 
#		Years 1975-2010 for countries that have between 
#		7 and 10 characters (including spaces) in their names.
