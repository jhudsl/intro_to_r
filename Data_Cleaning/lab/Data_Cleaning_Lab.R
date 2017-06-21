#################
# Data Cleaning and Plotting
##############

## Download the "Real Property Taxes" Data from my website (via OpenBaltimore):
# http://johnmuschelli.com/intro_to_r/data/Real_Property_Taxes.csv.gz
## note you don't need to unzip it to read it into R

# 1. Read the Property Tax data into R and call it the variable `tax`

# 2. How many addresses pay property taxes? 

# 3. What is the total city and state tax paid?

# 4. Using `table()` or group_by and summarize(n())
#	a. how many observations/properties are in each ward?

#	b. what is the mean state tax per ward? use group_by

#	c. what is the maximum amount still due in each ward?

# d. What is the 75th percentile of city and state tax paid by Ward? (quantile)

# 6. Make boxplots using base graphics showing cityTax 
#	 	by whether the property	is a principal residence or not.

# 7. Subset the data to only retain those houses that are principal residences. 
#	a) How many such houses are there?

#	b) Describe the distribution of property taxes on these residences.

# 8. Convert the 'lotSize' variable to a numeric square feet variable. 
#	Tips: - Assume hyphens represent decimal places within measurements. 
#		  - 1 acre = 43560 square feet
#		  - The hyphens represent inches (not decimals)
# 		  - Don't spend more than 5-10 minutes on this; stop and move on

# 9.a) Plot your numeric lotSize versus cityTax on principal residences. 
#	b) How many values of lot size were missing?


################################
## Read in the Salary FY2015 dataset

# http://johnmuschelli.com/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv

# 10. Make an object called health.sal using the salaries data set, 
#		with only agencies of those with "fire" (or any forms), if any, in the name

# 11. Make a data set called trans which contains only agencies that contain "TRANS".

# 12. What is/are the profession(s) of people who have "abra" in their name for Baltimore's Salaries?

# 13. What is the distribution of annual salaries look like? What is the IQR?

# 14. Convert HireDate to the `Date` class - plot Annual Salary vs Hire Date

# 15. Plot annual salary versus hire date. 
#		Hint: first convert to numeric and date respectively

# 16. Create a smaller dataset that only includes the
# 	Police Department,  Fire Department and Sheriff's Office.
#  a. How many employees are in this new dataset?

# 17. Replot annual salary versus hire date, color by Agency using base plotting 
