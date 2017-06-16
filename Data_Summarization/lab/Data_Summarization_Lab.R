####################
# Data Summarization - Lab
####################

# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program. 
# http://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# 	Download as a CSV in your current working directory
# Note its also available at: 
#	http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv

# 1. How many bike "lanes" are currently in Baltimore? 
#		You can assume each observation/row is a different bike "lane"
library(readr)
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
nrow(bike)

# 2. How many (a) feet and (b) miles of bike "lanes" are currently in Baltimore?
sum(bike$length)
sum(bike$length) / 5280

# 3. How many types of bike lanes are there? Which type has 
#		(a) the most number of and (b) longest average bike lane length?
length(unique(bike$type))
table(bike$type)

table(bike$type, useNA = "ifany")
table(bike$type, useNA = "always")

length(table(bike$type, useNA = "ifany"))
sort(table(bike$type, useNA = "ifany"))
sort(table(bike$type, useNA = "ifany"), decreasing = TRUE)[1]
library(dplyr)
bike %>% 
  group_by(type) %>% 
  summarize(avg_len = mean(length)) %>% 
  arrange(desc(avg_len))


# 4. How many different projects do the "bike" lanes fall into? 
#		Which project category has the longest average bike lane? 

# 5. What was the average bike lane length per year that they were installed?
# Set bike$dateInstalled to NA if it is equal to zero.

# 6. (a) Numerically [hint: `quantile()`] and 
#		(b) graphically [hint: `hist()` or `plot(density())`]
#		 describe the distribution of bike "lane" lengths.

# 7. Then describe as above, after stratifying by i) type then ii) number of lanes

