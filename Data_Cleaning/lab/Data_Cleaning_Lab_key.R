#################
# Data Cleaning and Plotting
##############
# 1/12/2017

## Download the "Real Property Taxes" Data from my website (via OpenBaltimore):
# www.aejaffe.com/winterR_2017/data/Real_Property_Taxes.csv.gz
## note you don't need to unzip it to read it into R
rm( list = ls() ) # clear the workspace
library(stringr)
library(dplyr)
library(readr)

# 1. Read the Property Tax data into R and call it the variable `tax`
tax = read_csv( "~/GitHub/winterR_2017/data/Real_Property_Taxes.csv.gz")

# 2. How many addresses pay property taxes? 
nrow(tax)
dim(tax)

# 3. What is the total city and state tax paid?
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


# Using `tapply()` and/or `table()`
#	a. how many observations are in each ward?
### sapply(tax_list, nrow)

table(tax$Ward)


#	b. what is the mean state tax per ward?
tax %>%   group_by(Ward) %>% 
  summarize(mean_state = mean(StateTax, na.rm = TRUE))

tapply(tax$StateTax, tax$Ward, mean, na.rm=TRUE)

#	c. what is the maximum amount still due in each ward?
tax$AmountDue = tax$AmountDue %>% 
  str_replace(fixed("$"), "") %>%
  as.numeric

tax %>% group_by(Ward) %>% 
  summarize(maxDue = max(AmountDue, na.rm = TRUE))

## 75th percentile
tax %>% group_by(Ward) %>% 
  summarize(Percentile = quantile(StateTax, prob = 0.75,na.rm = TRUE))

tapply(tax$StateTax, tax$Ward,
       quantile, prob = 0.75, na.rm=TRUE)
tapply(tax$StateTax, tax$Ward,
       quantile, na.rm=TRUE)

# 6. Make boxplots using base graphics showing CityTax 
#	 	by whether the property	is a principal residence or not.
tax$ResCode = str_trim(tax$ResCode)
boxplot(log(CityTax+1) ~ ResCode, data = tax)

# 7. Subset the data to only retain those houses that are principal residences. 
pres = tax %>% filter( ResCode %in% "PRINCIPAL RESIDENCE")
pres = tax %>% filter( ResCode == "PRINCIPAL RESIDENCE")

#	a) How many such houses are there?
dim(pres)

#	b) Describe the distribution of property taxes on these residences.
hist(log2(pres$CityTax+1))

# 8. Convert the 'LotSize' variable to a numeric square feet variable. 
#	Tips: - 1 acre = 43560 square feet
#		    - The hyphens represent inches (not decimals)
# 		  - Don't spend more than 5-10 minutes on this; stop and move on

tax$LotSize = str_trim(tax$LotSize) # trim to be safe
lot = tax$LotSize # for checking later

# first lets take care of acres
aIndex= c(grep("ACRE.*", tax$LotSize,ignore.case),
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

