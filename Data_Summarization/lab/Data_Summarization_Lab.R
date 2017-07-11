####################
# Data Summarization - Lab
####################

# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program. 
# http://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# 	Download as a CSV in your current working directory
# Note its also available at: 
#	http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv
library(readr)
library(dplyr)

##########################
# Part 1
##########################
# 1. How many bike "lanes" are currently in Baltimore? 
#		You can assume each observation/row is a different bike "lane"

# 2. How many (a) feet and (b) miles of bike "lanes" are currently in Baltimore?
# what is the mean number of feet over all records?

##########################
# Part 2
##########################
# 3. How many types of bike lanes are there? Which type has 
#		(a) the most number of?  Use `table`

# 4. How many different projects do the "bike" lanes fall into? 
# use unique and length

##########################
# Part 3
##########################
# 5. Which bike lane type has the longest average bike lane length?
# use group_by

#	6. Which project category has the longest average bike lane? 
# use group_by

# 7. What was the average bike lane length per year that they were installed?
# Set bike$dateInstalled to NA if it is equal to zero.

##########################
# Part 4
##########################
# 8. (a) Numerically [hint: `quantile()`] and 
#		(b) graphically [hint: `hist()` or `plot(density())`]
#		 describe the distribution of bike "lane" lengths.

# 9. Then describe as above, after stratifying by i) type then ii) number of lanes

