#################
# Data Cleaning and Plotting
##############
rm( list = ls() ) # clear the workspace
library(stringr)
library(dplyr)
library(readr)
library(lubridate)
library(broom)

####################
# Part 1
####################
# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program. 
# http://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# 	Download as a CSV in your current working directory
# Note its also available at: 
#	http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")


# 1.  Count the number of rows of the `bike` data and 
# count the number of complete cases of the bike data.  
# Use `sum` and `complete.cases`.


# 2.  Create a data set called `namat`` which is equal to `is.na(bike)`.  
# What is the class of `namat`?  Run `rowSums` and `colSums` on `namat`.
# These represent the number of missing values in the rows and columns of
# bike.  Don't print rowSums, but do a table of the rowSums

# 3.  Filter rows of `bike` that are NOT missing the route variable, assign
# this to the object `have_route`.  Do a table of the subType using table, 
# including the missing subTypes.  Get the same frequency distribution
# using `group_by(subType)` and `tally()`

# 4.  Filter rows of bike that have the type SIDEPATH or BIKE LANE
# using %in%.  Call it side_bike.  
# Confirm this gives you the same number of results using the | and 
# ==.


####################
# Part 2
####################
# 5.  Do a cross tab of the bike type and the number of lanes.
# Call it tab.  Do a prop.table on the rows and columns margins. 
# Try `as.data.frame(tab)`, `as_data_frame(tab)`, or broom::tidy(tab)

####################################################
# New Data set
####################################################
####################
# Part 3
####################
## Download the "Real Property Taxes" Data from my website (via OpenBaltimore):
# http://johnmuschelli.com/intro_to_r/data/Real_Property_Taxes.csv.gz
## note you don't need to unzip it to read it into R

# 1. Read the Property Tax data into R and call it the variable `tax`

# 2. How many addresses pay property taxes? 

# 3. What is the total city and state tax paid?  
# You need to remove the $ from the CityTax variable
# then you need to make it numeric.   Try str_replace, but remember
# $ is "special" and you need fixed() around it.

# 4. Using `table()` or group_by and summarize(n()) or tally()
#	a. how many observations/properties are in each ward?

#	b. what is the mean state tax per ward? use group_by and summarize

#	c. what is the maximum amount still due in each ward?  different summarization (max)


# d. What is the 75th percentile of city and state tax paid by Ward? (quantile)


# 6. Make boxplots showing cityTax (y -variable)
#	 	by whether the property	is a principal residence (x) or not.


# 7. Subset the data to only retain those houses that are principal residences. 
# which command subsets rows? Filter or select?
#	a) How many such houses are there?


#	b) Describe the distribution of property taxes on these residences.  Use 
# hist with certain breaks or plot(density(variable))


##########################
# Part 4
##########################
# x = c("This isn't that hard", "hard of a string", 'to "parse"',
#       "BUT WE have HaRD", "Data ThAt", "Wecsw")
################################
## Read in the Salary FY2015 dataset
# http://johnmuschelli.com/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv

# 10. Make an object called health.sal using the salaries data set, 
#		with only agencies of those with "fire" (or any forms), if any, in the name
# remember fixed( ignore_case = TRUE) will ignore cases

# 11. Make a data set called trans which contains only agencies that contain "TRANS".

# 12. What is/are the profession(s) of people who have "abra" in their name for 
# Baltimore's Salaries?  Case should be ignored

# 13. What is the distribution of annual salaries look like? (use hist, 20 breaks) What is the IQR?
#Hint: first convert to numeric. Try str_replace, but remember
# $ is "special" and you need fixed() around it.


# 14. Convert HireDate to the `Date` class - plot Annual Salary vs Hire Date.
# Use AnnualSalary ~ HireDate with a data = sal argument in plot or use 
# x, y notation in scatter.smooth
# Use lubridate package.  Is it mdy(date) or dmy(date) for this data - look at HireDate


# 15. Create a smaller dataset that only includes the
# 	Police Department,  Fire Department and Sheriff's Office.  Use the Agency variable
# with string matching Call this emer
#  a. How many employees are in this new dataset?


# 16. Create a varaible called dept in the emer data set.
# dept = str_extract(Agency, ".*(ment|ice)").  Ee want to extract all characters
# up until ment or ice (we can group in regex using parentheses) and then discard
# the rest.


# Replot annual salary versus hire date, color by dept (not yet - using ggplot)


# BONUS. Convert the 'LotSize' variable to a numeric square feet variable. 
# Using the tax data set
#	Tips: - 1 acre = 43560 square feet
#		    - The hyphens represent inches (not decimals)
# 		  - Don't spend more than 5-10 minutes on this; stop and move on

#   a) Plot your numeric lotSize versus cityTax on principal residences. 
#	b) How many values of lot size were missing?
