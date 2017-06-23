#################
# Data Cleaning and Plotting
##############
library(readr)
library(stringr)
library(dplyr)


## Download the "Real Property Taxes" Data from my website (via OpenBaltimore):
# http://johnmuschelli.com/intro_to_r/data/Real_Property_Taxes.csv.gz
## note you don't need to unzip it to read it into R

# 1. Read the Property Tax data into R and call it the variable `tax`
tax = read_csv("http://johnmuschelli.com/intro_to_r/data/Real_Property_Taxes.csv.gz")

# 2. How many addresses pay property taxes? 
dim(tax)
nrow(tax)
length(tax$PropertyID)

sum(is.na(tax$CityTax))
sum(!is.na(tax$CityTax))

# 3. What is the total city and state tax paid?  
# You need to remove the $ from the CityTax variable
# then you need to make it numeric.   Try str_replace, but remember
# $ is "special" and you need fixed() around it.
sum(tax$CityTax)
as.numeric(str_replace(tax$CityTax, fixed("$"), ""))

tax$CityTax %>% str_replace(fixed("$"), "") %>% 
             as.numeric()
tax = tax %>% mutate(
  CityTax = CityTax %>% str_replace(fixed("$"), "") %>% 
    as.numeric()
)

tax = tax %>% mutate(
  CityTax = as.numeric(str_replace(CityTax, fixed("$"), "")),
  StateTax = as.numeric(str_replace(StateTax, fixed("$"), ""))
  
)



sum(as.numeric(tax$CityTax), na.rm = TRUE)

# 4. Using `table()` or group_by and summarize(n()) or tally()
#	a. how many observations/properties are in each ward?
table(tax$Ward)

ward_table = tax %>% 
  group_by(Ward) %>% 
  tally()

ward_table = tax %>% 
  group_by(Ward) %>% 
  summarize(number_of_obs = n())



#	b. what is the mean state tax per ward? use group_by and summarize

ward_table = tax %>% 
  group_by(Ward) %>% 
  summarize(
    number_of_obs = n(),
    mean_state_tax = mean(StateTax, na.rm = TRUE))


#	c. what is the maximum amount still due in each ward?  different summarization (max)
tax = tax %>% mutate(
  AmountDue = as.numeric(str_replace(AmountDue, fixed("$"), ""))
)

ward_table = tax %>% 
  group_by(Ward) %>% 
  summarize(
    number_of_obs = n(),
    mean_state_tax = mean(StateTax, na.rm = TRUE),
    max_amount_due = max(AmountDue, na.rm = TRUE)
    )

# d. What is the 75th percentile of city and state tax paid by Ward? (quantile)
ward_table = tax %>% 
  group_by(Ward) %>% 
  summarize(
    number_of_obs = n(),
    mean_state_tax = mean(StateTax, na.rm = TRUE),
    max_amount_due = max(AmountDue, na.rm = TRUE),
    q75_city = quantile(CityTax, probs = 0.75, na.rm = TRUE),
    q75_state = quantile(StateTax, probs = 0.75, na.rm = TRUE)
  )

# 6. Make boxplots using base graphics showing cityTax (y -variable)
#	 	by whether the property	is a principal residence (x) or not.
boxplot( CityTax ~ ResCode, data = tax)

max_city_tax = max()

tax %>% filter(CityTax == max(CityTax, na.rm = TRUE))
# lm( CityTax ~ ResCode + StateTax, data = tax)

# 7. Subset the data to only retain those houses that are principal residences. 
# which command subsets rows? Filter or select?
#	a) How many such houses are there?


#	b) Describe the distribution of property taxes on these residences.  Use 
# hist with certain breaks or plot(density(variable))

# 8.a) Plot your numeric lotSize versus cityTax on principal residences. 
#	b) How many values of lot size were missing?



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
ggplot(aes(x = HireDate, y = AnnualSalary, 
           colour = dept), data = emer) + 
  geom_point() + theme(legend.position = c(0.5, 0.8))



# BONUS. Convert the 'LotSize' variable to a numeric square feet variable. 
# Using the tax data set
#	Tips: - 1 acre = 43560 square feet
#		    - The hyphens represent inches (not decimals)
# 		  - Don't spend more than 5-10 minutes on this; stop and move on
