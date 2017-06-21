#################
# Data Cleaning and Plotting
##############

## Download the "Real Property Taxes" Data from my website (via OpenBaltimore):
# http://johnmuschelli.com/intro_to_r/data/Real_Property_Taxes.csv.gz
## note you don't need to unzip it to read it into R
rm( list = ls() ) # clear the workspace
library(stringr)
library(dplyr)
library(readr)
library(lubridate)

# 1. Read the Property Tax data into R and call it the variable `tax`
tax = read_csv( "http://johnmuschelli.com/intro_to_r/data/Real_Property_Taxes.csv.gz")

# 2. How many addresses pay property taxes? 
nrow(tax)
dim(tax)

# 3. What is the total city and state tax paid?  
# You need to remove the $ from the CityTax variable
# then you need to make it numeric.   Try str_replace, but remember
# $ is "special" and you need fixed() around it.

head(tax$CityTax)
tax$CityTax = tax$CityTax %>% 
  str_replace(fixed("$"), "") %>%
  as.numeric
tax$StateTax = tax$StateTax %>% 
  str_replace(fixed("$"), "") %>%
  as.numeric

sum(tax$CityTax)
sum(tax$CityTax, na.rm = TRUE)
sum(tax$CityTax, na.rm = TRUE)/1e6

sum(tax$StateTax, na.rm = TRUE)
sum(tax$StateTax, na.rm = TRUE)/1e6


# 4. Using `table()` or group_by and summarize(n()) or tally()
#	a. how many observations/properties are in each ward?
### sapply(tax_list, nrow)
table(tax$Ward)



#	b. what is the mean state tax per ward? use group_by and summarize
tax %>%   group_by(Ward) %>% 
  summarize(mean_state = mean(StateTax, na.rm = TRUE))

tapply(tax$StateTax, tax$Ward, mean, na.rm=TRUE)


#	c. what is the maximum amount still due in each ward?  different summarization (max)
tax$AmountDue = tax$AmountDue %>% 
  str_replace(fixed("$"), "") %>%
  as.numeric

tax %>% group_by(Ward) %>% 
  summarize(maxDue = max(AmountDue, na.rm = TRUE))

# d. What is the 75th percentile of city and state tax paid by Ward? (quantile)
tax %>% group_by(Ward) %>% 
  summarize(Percentile = quantile(StateTax, prob = 0.75,na.rm = TRUE))

tapply(tax$StateTax, tax$Ward,
       quantile, prob = 0.75, na.rm=TRUE)
tapply(tax$StateTax, tax$Ward,
       quantile, na.rm=TRUE)

# 6. Make boxplots using base graphics showing cityTax (y -variable)
#	 	by whether the property	is a principal residence (x) or not.
tax$ResCode = str_trim(tax$ResCode)
boxplot(log(CityTax+1) ~ ResCode, data = tax)

# 7. Subset the data to only retain those houses that are principal residences. 
# which command subsets rows? Filter or select?
#	a) How many such houses are there?
pres = tax %>% filter( ResCode %in% "PRINCIPAL RESIDENCE")
pres = tax %>% filter( ResCode == "PRINCIPAL RESIDENCE")

#	a) How many such houses are there?
dim(pres)

#	b) Describe the distribution of property taxes on these residences.  Use 
# hist with certain breaks or plot(density(variable))
hist(log2(pres$CityTax+1))
hist(pres$CityTax)
plot(density(pres$CityTax))



################################
## Read in the Salary FY2015 dataset
# http://johnmuschelli.com/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv

# 10. Make an object called health.sal using the salaries data set, 
#		with only agencies of those with "fire" (or any forms), if any, in the name
# remember fixed( ignore_case = TRUE) will ignore cases
sal = read_csv("http://johnmuschelli.com/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv")
health.sal = sal %>% filter(str_detect(JobTitle, fixed("fire", ignore_case = TRUE)))

# 11. Make a data set called trans which contains only agencies that contain "TRANS".
trans = sal %>% filter(str_detect(JobTitle, "TRANS"))

# 12. What is/are the profession(s) of people who have "abra" in their name for 
# Baltimore's Salaries?  Case should be ignored
sal %>% filter(str_detect(name, fixed("abra", ignore_case = TRUE)))

# 13. What is the distribution of annual salaries look like? (use hist, 20 breaks) What is the IQR?
#Hint: first convert to numeric. Try str_replace, but remember
# $ is "special" and you need fixed() around it.
sal = sal %>% mutate(AnnualSalary = str_replace(AnnualSalary, fixed("$"), ""))
sal = sal %>% mutate(AnnualSalary = as.numeric(AnnualSalary))
hist(sal$AnnualSalary, breaks = 20)

# 14. Convert HireDate to the `Date` class - plot Annual Salary vs Hire Date.
# Use AnnualSalary ~ HireDate with a data = sal argument in plot or use 
# x, y notation in scatter.smooth
# Use lubridate package.  Is it mdy(date) or dmy(date) for this data - look at HireDate
sal = sal %>% mutate(HireDate = lubridate::mdy(HireDate))
plot(AnnualSalary ~ HireDate, data = sal)
scatter.smooth(sal$AnnualSalary, x = sal$HireDate, col = "red")

# 15. Create a smaller dataset that only includes the
# 	Police Department,  Fire Department and Sheriff's Office.  Use the Agency variable
# with string matching Call this emer
#  a. How many employees are in this new dataset?
emer = sal %>% filter(
  str_detect(Agency, "Sheriff's Office|Police Department|Fire Department")
)

emer = sal %>% filter(
  str_detect(Agency, "Sheriff's Office") |
    str_detect(Agency, "Police Department") |
    str_detect(Agency, "Fire Department")
)

# 16. Create a varaible called dept in the emer data set.
# dept = str_extract(Agency, ".*(ment|ice)").  Ee want to extract all characters
# up until ment or ice (we can group in regex using parentheses) and then discard
# the rest.
emer = emer %>% 
  mutate(
    dept = str_extract(Agency, ".*(ment|ice)")
  )
# Replot annual salary versus hire date, color by dept (not yet - using ggplot)
ggplot(aes(x = HireDate, y = AnnualSalary, 
           colour = dept), data = emer) + 
  geom_point() + theme(legend.position = c(0.5, 0.8))





# BONUS. Convert the 'LotSize' variable to a numeric square feet variable. 
# Using the tax data set
#	Tips: - 1 acre = 43560 square feet
#		    - The hyphens represent inches (not decimals)
# 		  - Don't spend more than 5-10 minutes on this; stop and move on

tax$LotSize = str_trim(tax$LotSize) # trim to be safe
lot = tax$LotSize # for checking later

# first lets take care of acres
aIndex= c(grep("ACRE.*", tax$LotSize, ignore.case = TRUE),
          grep(" %", tax$LotSize, fixed=TRUE))
head(aIndex)
head(lot[aIndex])

acre = tax$LotSize[aIndex] # temporary variable
## find and replace character strings
acre = gsub(" ACRE.*","",acre)
acre = gsub(" %","",acre)
table(!is.na(as.numeric(acre)))

head(acre[is.na(as.numeric(acre))],50)

## lets clean the rest
acre = gsub("-",".",acre,fixed=TRUE) # hyphen instead of decimal
head(acre[is.na(as.numeric(acre))])
table(!is.na(as.numeric(acre)))

acre = gsub("ACRES","", acre, fixed=TRUE)
head(acre[is.na(as.numeric(acre))])

# take care of individual mistakes
acre = gsub("O","0", acre, fixed=TRUE) # 0 vs O
acre = gsub("Q","", acre, fixed=TRUE) # Q, oops
acre = gsub(",.",".", acre, fixed=TRUE) # extra ,
acre = gsub(",","", acre, fixed=TRUE) # extra ,
acre = gsub("L","0", acre, fixed=TRUE) # leading L
acre[is.na(as.numeric(acre))]

acre2 = as.numeric(acre)*43560 
sum(is.na(acre2)) # all but one

#######################
## now square feet:
fIndex = grep("X", tax$LotSize)
ft = tax$LotSize[fIndex]

ft = gsub("&", "-", ft, fixed=TRUE)
ft = gsub("IMP ONLY ", "", ft, fixed=TRUE)
ft = gsub("`","1",ft,fixed=TRUE)

ft= sapply(str_split(ft, " "), first)

# wrapper for string split and sapply
#### ss = function(x, pattern, slot=1,...) sapply(strsplit(x,pattern,...), "[", slot)

width = sapply(str_split(ft,"X"), first)
length = sapply(str_split(ft,"X"), nth, 2) 

## width
widthFeet = as.numeric(sapply(str_split(width, "-"), first))
widthInch = as.numeric(sapply(str_split(width, "-"),nth,2))/12
widthInch[is.na(widthInch)] = 0 # when no inches present
totalWidth = widthFeet + widthInch # add together

# length
lengthFeet = as.numeric(sapply(str_split(length, "-"),first))
lengthInch = as.numeric(sapply(str_split(length, "-",2),nth,2))/12
lengthInch[is.na(lengthInch)] = 0 # when no inches present
totalLength = lengthFeet + lengthInch

# combine together for square feet
sqrtFt = totalWidth*totalLength 
ft[is.na(sqrtFt)] # what is left?

### combine together
tax$sqft = NA
tax$sqft[aIndex] = acre2
tax$sqft[fIndex] = sqrtFt
mean(!is.na(tax$sqft))

# already in square feet, easy!!
sIndex=c(grep("FT", tax$LotSize), 
         grep("S.*F.", tax$LotSize))
sf = tax$LotSize[sIndex] # subset temporary variable

sqft2 = sapply(str_split(sf,"( |SQ|SF)"),first)
sqft2 = as.numeric(gsub(",", "", sqft2)) # remove , and convert
tax$sqft[sIndex] = sqft2
table(is.na(tax$sqft)) 
## progress!

#what remains?
lot[is.na(tax$sqft)]
