####################
# Subsetting Data in R - Lab
####################


## In this lab you can use the interactive console to explore 
## 	  but please record your commands here.  
## Remember anything you type here can be "sent" to the console with 
##    Cmd-Enter (OS-X) or Cntr-Enter (Windows/Linux).

library(dplyr)
# 1. Check to see if you have the `mtcars` dataset 
#		(which is included in the `datasets` package)
head(mtcars)

# 2. What class is `mtcars`?
class(mtcars)
tbl = as.tbl(mtcars)
tbl$car = rownames(tbl)
tbl = select(tbl, car, everything())

# 3. How many observations (rows) and variables (columns) are in the `mtcars` dataset?
dim(mtcars)
nrow(mtcars)
ncol(mtcars)
str(mtcars)

# 4. Select the subset of rows that get more than 20 miles
# 		 per gallon (mpg) of fuel efficiency - how many are there?
nrow(filter(mtcars, mpg > 20))
mtcars %>% filter(mpg > 20) %>% nrow
nrow(mtcars[ mtcars$mpg > 20, ])
sum(mtcars$mpg > 20)
length(which(mtcars$mpg > 20))

# 5. Select the subset of rows that get less than 16 miles
# 		per gallon (mpg) of fuel efficiency and have more than 
#		100 horsepower (hp) - how many are there?
mtcars %>% filter(mpg < 16 & hp > 100) %>% nrow
mtcars %>% filter(mpg < 16,  hp > 100) %>% nrow
sum(mtcars$mpg < 16 & mtcars$hp > 100)


# 6. Create a subset of the data that only contains the columns:
#		wt, qsec, and hp for only the cars that have 8 cylinders 
#		and assign this object to `carsSub` - 
#		what are the dimensions of this dataset?
carsSub = tbl %>% 
  filter(cyl == 8) %>% 
  select(car, wt, qsec, hp)
carsSub = mtcars[mtcars$cyl == 8, c("wt", "qsec", "hp")]

# 7. Convert the column names of `carsSub` to all upper case
colnames(carsSub) = colnames(carsSub) %>% toupper
colnames(carsSub) = toupper(colnames(carsSub))

# 8. Re-order the rows of `carsSub` by weight in increasing order
arrange(carsSub, WT)
carsSub[ order(carsSub$WT),]


# 9. Copy mtcars into a variable called cars and rename mpg in cars to MPG
cars = mtcars
# cars$MPG = cars$mpg
cars = rename(cars, MPG = mpg)

# 10. Subset the columns from mtcars that end in "p" and call it pvars
pvars = select(tbl, car, ends_with("p"))
