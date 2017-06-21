####################
# 140.886: Intro to R
# Homework 3
# Assigned Date: Day 4
# Due Date: week after class

# Instructions: 
# A)	Use this dataset on infant mortality for the following questions:
# http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv

# Read the data in using read_csv
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
# Questions
# 1.	Read the data using read_csv and name it mort
#    Create a integer ‘year’ variable using the column names (using colnames), 
#  (as.integer), excluding the first column.   Rename the first column to 
# "country" using use the rename command in dplyr.
mort = read_csv("http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv")
colnames(mort)[1] = "country"
year = colnames(mort)
year = year[-1]
year = as.integer(year)
head(year)


# 2.	Reshape the data so that there is a variable named "year" corresponding to year
# (key) and a column of the mortalities named mortality (value) .  
# Use the tidyr package and use the gather command.
# Remember that -COLUMN_NAME removes that column, gather all the columns but
# country.  Name the output long. Make `year` a numeric variable. 
long = tidyr::gather(mort, key = year, value = mortality, -country)
long$year = as.numeric(long$year  )

# 3.	Read in this the tab-delim file:
#		http://johnmuschelli.com/intro_to_r/data/country_pop.txt
# call it pop, which contains population information on each country
# use read_tsv.  Rename the second column country using colnames(pop) functionality.
# Rename the column "% of world population", to "percent"
pop = read_tsv("http://johnmuschelli.com/intro_to_r/data/country_pop.txt")
cn = colnames(pop)
cn[2] = "country"
cn[ cn == "% of world population"] = "percent"
colnames(pop) = cn




# 4.	Determine the population of each country in "pop" using "arrange".
# Get the order of the countries based on this (first is the highest population), 
# then make a variable in the long data 
# set named "sorted" that is the country variable 
# coded as a factor based on this sorted population level from "pop"
pop = arrange(pop, desc(Population))
long$sorted = factor(long$country, levels = pop$country)


# 5.	Subset `long` based on years 1975-2010, including 1975 and 2010
# call this long_sub.  Subset the following countries using dplyr::filter
# and the %in% operator on the sorted country factor ("sorted") for long_sub.  # 
# c("Venezuela", "Bahrain", "Estonia", "Iran", "Thailand", "Chile", 
#  "Western Sahara", "Azerbaijan", "Argentina", "Haiti")
# Remove missing rows for mortality
# using filter and is.na.
long_sub = filter(long, year >= 1975 & year <= 2010)
long_sub = filter(long_sub, 
                  sorted %in% c("Venezuela", "Bahrain", "Estonia", 
                                "Iran", "Thailand", "Chile", 
                                "Western Sahara", "Azerbaijan", 
                                "Argentina", "Haiti"))


# 6.  Plotting: create “spaghetti”/line plots for
# the countries, using different colors for different coutnries.
# The x-variable should be year, the y-variable should be mortality
ggplot(aes(x = year, y = mortality, color = sorted), 
       data = long_sub)  + geom_line()
