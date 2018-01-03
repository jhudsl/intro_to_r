###########
## Statistics Lab 
############

#############################
# Part 1
#############################
# Read in the following infant mortality data: 
# http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv

# 1. Compute the correlation between the 1980, 1990, 2000, and 2010 mortality data.
#    No need to save this in an object. Just display the result to the screen.

# 2. a. Compute the correlation between the Myanmar, China, and United States mortality data.
#       Store this correlation matrix in an object called country_cor
#    b. Extract the Myanmar-US correlation from the correlation matrix.

# 3. Is there a difference between mortality information from 1990 and 2000?
#    Run a t-test and a Wilcoxon rank sum test to assess this.
#    Hint: to extract the column of information for 1990, use mort[["1990"]]

#################
# Part 2
#############################
# Read in the Kaggle cars auction dataset:
cars = read_csv("http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv")

# 4. Fit a linear regression model with vehicle cost (VehBCost) as the outcome and 
#    vehicle age (VehicleAge) and size (Size) as predictors as well as their interaction.
#    Save the model fit in an object called lmfit_cars and display the summary table.

# 5. Create a variable called "expensive" in the cars data that indicates if the 
#    vehicle cost is over $80,000. Use a chi-squared test to assess if there is a
#    relationship between a car being expensive and it being labeled as a "bad buy."

# 6. Fit a logistic regression model where the outcome is "bad buy" status and predictors
#    are the "expensive" status and vehicle age (VehicleAge).
#    Save the model fit in an object called logfit_cars and display the summary table.

#############################
# Part 3
#############################

# 7. Randomly sample 10,000 observations (rows) with replacement from the cars dataset
#    and store this new dataset in an object called cars_subsample.


# 8. Fit the same logistic regression model as in problem 6 above 
# with this sample and display the 
#    summary table. How do the results compare?
