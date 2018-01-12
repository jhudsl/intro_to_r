###########
## Statistics Lab 
############

library(tidyverse)
library(broom)

#############################
# Part 1
#############################
# Read in the following infant mortality data: 
# http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv
mort = read_csv("http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv",)
colnames(mort)[1] = "country"

# 1. Compute the correlation between the 1980, 1990, 2000, and 2010 mortality data.
#    No need to save this in an object. Just display the result to the screen.
cor(mort[,c("1980", "1990", "2000", "2010")])
## What's going on?! Seems we have NAs in the 2010 column
summary(mort[,c("1980", "1990", "2000", "2010")])

## Both are equivalent
cor(mort[,c("1980", "1990", "2000", "2010")], use = "complete.obs")
cor(mort %>% select("1980", "1990", "2000", "2010"), use = "complete.obs")


# 2. a. Compute the correlation between the Myanmar, China, and United States mortality data.
#       Store this correlation matrix in an object called country_cor
#    b. Extract the Myanmar-US correlation from the correlation matrix.
mort_subs = mort %>% 
  filter(country %in% c("Myanmar", "China", "United States")) %>% 
  select(-country)
country_cor = cor(t(mort_subs), 
                  use = "complete.obs")
## Run the following to see that the order is China, Myanmar, US:
mort %>% filter(country %in% c("Myanmar", "China", "United States"))
## Extract the Myanmar-US correlation
country_cor[1,3]

# 3. Is there a difference between mortality information from 1990 and 2000?
#    Run a t-test and a Wilcoxon rank sum test to assess this.
#    Hint: to extract the column of information for 1990, use mort[["1990"]]
t.test(mort[["1990"]], mort[["2000"]])
t.test(mort$`1990`, mort$`2000`)
t.test(mort$`1990`, mort$`2000`, paired = TRUE)

wilcox.test(mort[["1990"]], mort[["2000"]])



#############################
# Part 2
#############################
# Read in the Kaggle cars auction dataset:
cars = read_csv("http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv",
                col_types = cols(VehBCost = col_double()))

# 4. Fit a linear regression model with vehicle cost (VehBCost) as the outcome and 
#    vehicle age (VehicleAge) and size (Size) as predictors as well as their interaction.
#    Save the model fit in an object called lmfit_cars and display the summary table.
## The following two lines are equivalent
lmfit_cars = lm(VehBCost ~ VehicleAge + Size + VehicleAge*Size, data = cars)
lmfit_cars = lm(VehBCost ~ VehicleAge*Size, data = cars)
summary(lmfit_cars)

# 5. Create a variable called "expensive" in the cars data that indicates if the 
#    vehicle cost is over $10,000. Use a chi-squared test to assess if there is a
#    relationship between a car being expensive and it being labeled as a "bad buy."
cars = cars %>%
	mutate(expensive = VehBCost > 10000)
tab = table(cars$expensive, cars$IsBadBuy)
chisq.test(tab)
fisher.test(tab)
prop.test(tab)

# 6. Fit a logistic regression model where the outcome is "bad buy" status and predictors
#    are the "expensive" status and vehicle age (VehicleAge).
#    Save the model fit in an object called `logfit_cars` and display the summary table.
# Use summary or tidy(logfit_cars, conf.int = TRUE, exponentiate = TRUE) 
# or tidy(logfit_cars, conf.int = TRUE, exponentiate = FALSE) # log odds ratios 
logfit_cars = glm(IsBadBuy ~ expensive + VehicleAge, data = cars, family = binomial)
logfit_cars = glm(IsBadBuy ~ expensive + VehicleAge, data = cars, family = binomial())
logfit_cars = glm(IsBadBuy ~ expensive + VehicleAge, data = cars, family = "binomial")
summary(logfit_cars)
tidy(logfit_cars, conf.int = TRUE, exponentiate = TRUE)
tidy(logfit_cars, conf.int = TRUE, exponentiate = FALSE)


#############################
# Part 3
#############################

# 7. Randomly sample 10,000 observations (rows) with replacement from the cars dataset
#    and store this new dataset in an object called cars_subsample.
set.seed(1)
cars_subsample = cars %>% 
  sample_n(size = 10000)
# another way
# rows = sample(nrow(cars), size = 10000, replace = TRUE)
# cars_subsample = cars[rows,]


  
# 8. Fit the same logistic regression model as in problem 6 above 
# with this sample and display the 
#    summary table using the tidy function. How do the results compare?
# Call this model logfit_cars_sub
logfit_cars_sub = glm(IsBadBuy ~ expensive + VehicleAge, data = cars, family = binomial)
summary(logfit_cars_sub)
tidy(logfit_cars_sub, conf.int = TRUE, exponentiate = TRUE)
