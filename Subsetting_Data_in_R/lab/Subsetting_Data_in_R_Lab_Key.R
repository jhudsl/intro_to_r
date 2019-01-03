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
class(mtcars)

# 3. How many observations (rows) and variables (columns) are in the `mtcars` dataset?
dim(mtcars)
nrow(mtcars)
ncol(mtcars)
glimpse(mtcars)

# 4. Copy mtcars into an object called cars and rename mpg in cars to MPG
# use rename
cars = mtcars
cars = rename(cars, MPG = mpg)

cars2 = dplyr::rename(cars, 
  MPG = mpg, 
  carbs = carb, 
  DRaT = drat)

# 5. Convert the column names of `cars` to all upper case
# use rename_all, and the toupper command
cars = rename_all(cars, toupper)
cn = colnames(cars) # extract column names
cn = toupper(cn) # make them uppercase
colnames(cars) = cn # reassign

# base R, one shot
colnames(cars) = toupper(colnames(cars))

# dplyr
cars = rename_all(cars, toupper)

##########################
# Part 2
##########################
# 6. Subset the columns from mtcars that end in "p" and call it pvars
# use ends_with

pvars = select(mtcars, ends_with("p"))

# adding column of former row names
library(tidyverse)
tbl = rownames_to_column(tbl, var = "cars")

## you can do this too
# tbl$cars = rownames(cars)
pvars_tbl = select(tbl, cars, ends_with("P"))
pvars_tbl

# 7. Create a subset of the data that only contains the columns:
#		wt, qsec, and hp for only the cars  
#		and assign this object to `carsSub` - 
#		what are the dimensions of this dataset?
# use select
carsSub = select(mtcars, wt, qsec, hp)
dim(carsSub)

# 8. Convert the column names of `carsSub` to all upper case
# use colnames, and the toupper command
colnames(carsSub) = toupper(colnames(carsSub))
head(carsSub)

##########################
# Part 3
##########################
# 9. Subset the rows of cars that get more than 20 miles
# 		 per gallon (mpg) of fuel efficiency - how many are there?
# use filter
cars = filter(cars, MPG > 20)
filter(mtcars, mpg > 20)

# 10. Subset the rows that get less than 16 miles
# 		per gallon (mpg) of fuel efficiency and have more than 
#		100 horsepower (hp) - how many are there?
mtcars2 =filter(mtcars, mpg < 16 & hp > 100)
filter(mtcars, mpg < 16, hp > 100)

df = mtcars
df %>% 
  filter(mpg > 20 & cyl == 4) %>% 
  select(cyl, hp)


##########################
# Part 4
##########################
# 7. Create a subset of the data that only contains the columns:
#		wt, qsec, and hp for only the cars with 8 cylinders
#		and reassign this object to `carsSub` - 
#		what are the dimensions of this dataset?
# Convert the column names of `carsSub` to all upper case
# use colnames, and the toupper command
# use select and filter
cars2 = mtcars
cars2 = rownames_to_column(tbl, var = "car")
carsSub = cars2 %>% 
  filter(cyl == 8) %>% 
  select(wt, qsec, hp, car)

# carsSub = cars2 %>% 
#   select(wt, qsec, hp, car) %>% 
#   filter(cyl == 8)

colnames(carsSub) = toupper(colnames(carsSub))

# 11. Re-order the rows of `carsSub` by weight in increasing order
# use arrange
carsSub = arrange(carsSub, WT)


# 12. Create a new variable in `carsSub` called wt2, which 
# is equal to WT^2, using mutate.  Use piping
carsSub %>% mutate(wt2 = WT^2)
mutate(carsSub, wt2 = WT^2)

df %>% 
  mutate(cat = NA,
         cat = ifelse(wt2 > 5 & is.na(cat), 1, cat),
         cat = ifelse(wt2 > 6 & is.na(cat), 2, cat),
         age_log2 = age^2,
         age_log2 = log(age_log2)
         
  )
  
  
  
  
  
  
  
