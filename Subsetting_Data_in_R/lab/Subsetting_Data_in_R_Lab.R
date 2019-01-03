####################
# Subsetting Data in R - Lab
####################

## In this lab you can use the interactive console to explore 
## 	  but please record your commands here.  
## Remember anything you type here can be "sent" to the console with 
##    Cmd-Enter (OS-X) or Cntr-Enter (Windows/Linux).
library(dplyr)
library(tidyverse)

##########################
# Part 1
##########################
# 1. Check to see if you have the `mtcars` dataset 
#		(which is included in the `datasets` package)

# 2. What class is `mtcars`?


# 3. How many observations (rows) and variables (columns) are in the `mtcars` dataset?

# 4. Copy mtcars into an object called cars and rename mpg in cars to MPG
# use rename
cars = mtcars


# 5. Convert the column names of `cars` to all upper case
# use rename_all, and the `toupper()` command (or colnames)


##########################
# Part 2
##########################
# 6. Subset the columns from mtcars that end in "p" and call it `pvars`
# use `ends_with()`

# 7. Create a subset of the data that only contains the columns:
#		`wt`, `qsec`, and `hp` and assign this object to `carsSub` - 
#		what are the dimensions of this dataset?
# use `select()`

# 8. Convert the column names of `carsSub` to all upper case
# use `rename_all()`, and the `toupper()` command (or `colnames`)


##########################
# Part 3
##########################
# 9. Subset the rows of cars that get more than 20 miles
# 		 per gallon (mpg) of fuel efficiency - how many are there?
# use `filter()`


# 10. Subset the rows that get less than 16 miles
# 		per gallon (mpg) of fuel efficiency and have more than 
#		100 horsepower (hp) - how many are there?


##########################
# Part 4
##########################
# 11. Create a subset of the data that only contains the columns:
#		wt, qsec, and hp for only the cars with 8 cylinders
#		and reassign this object to `carsSub` - 
#		what are the dimensions of this dataset?
# Convert the column names of `carsSub` to all upper case
# use `rename_all()`, and the `toupper()` command
# use `select()` and `filter()`


# 12. Re-order the rows of `carsSub` by weight in increasing order
# use `arrange()`


# 13. Create a new variable in `carsSub` called wt2, which 
# is equal to WT^2, using `mutate()`.  Use piping

