## ---------------------------------------------------------------------------------
library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)
library(jhur)
library(tidyverse)
library(broom)
library(naniar)

bike = read_csv(
  "http://jhudatascience.org/intro_to_r/data/Bike_Lanes.csv")


## ---------------------------------------------------------------------------------
nrow(bike)
sum(complete.cases(bike))


## ---------------------------------------------------------------------------------
namat = is.na(bike)
colSums(namat)
table(rowSums(namat))



## ---------------------------------------------------------------------------------
have_route = bike %>%  filter(!is.na(route))
dim(have_route)

table(have_route$subType, useNA = "always")
have_route %>%  group_by(subType) %>%  tally()
have_route %>%  count(subType)

have_route %>% group_by(subType) %>% 
  summarize(n_obs = n())

tally(   group_by(have_route, subType) )
have_route = group_by(have_route, subType)
tally(have_route)

## ---------------------------------------------------------------------------------
naniar::gg_miss_var(bike)

## ---------------------------------------------------------------------------------
tax = read_csv( "http://jhudatascience.org/intro_to_r/data/Real_Property_Taxes.csv.gz")


## ---------------------------------------------------------------------------------
dim(tax)
nrow(tax)
length(tax$PropertyID)

sum(is.na(tax$CityTax))
sum(!is.na(tax$CityTax))



## ---------------------------------------------------------------------------------
head(tax$CityTax)
tax = tax %>% 
  mutate(
    CityTax = str_replace(CityTax, 
      fixed("$"), "") ,
    CityTax = as.numeric(CityTax)
  )

# no piping
tax$CityTax = str_replace(tax$CityTax, fixed("$"), "")
tax$CityTax = as.numeric(tax$CityTax)



## ---------------------------------------------------------------------------------
table(tax$Ward)



## ---------------------------------------------------------------------------------
tax %>%   group_by(Ward) %>% 
  summarize(mean_state = mean(StateTax, na.rm = TRUE))




## ---------------------------------------------------------------------------------
tax$AmountDue = tax$AmountDue %>% 
  str_replace(fixed("$"), "") %>%
  as.numeric

tax = tax %>% mutate(
  AmountDue = as.numeric(str_replace(AmountDue, fixed("$"), ""))
)

tax %>% group_by(Ward) %>% 
  summarize(maxDue = max(AmountDue, na.rm = TRUE))




## ---------------------------------------------------------------------------------
pres = tax %>% filter( ResCode %in% "PRINCIPAL RESIDENCE")
pres = tax %>% filter( ResCode == "PRINCIPAL RESIDENCE")
dim(pres)


## ---------------------------------------------------------------------------------

sal = read_csv("http://jhudatascience.org/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv")


## ---------------------------------------------------------------------------------
health.sal = sal %>% 
  filter(str_detect(JobTitle, 
                    fixed("fire", ignore_case = TRUE)))


## ---------------------------------------------------------------------------------
trans = sal %>% 
  filter(str_detect(JobTitle, "TRANS"))


## ---------------------------------------------------------------------------------
sal %>% 
  filter(str_detect(name, fixed("abra", ignore_case = TRUE)))



## ---------------------------------------------------------------------------------
emer = sal %>% filter(
  str_detect(Agency, "Sheriff's Office|Police Department|Fire Department")
)

emer = sal %>% filter(
  str_detect(Agency, "Sheriff's Office") |
    str_detect(Agency, "Police Department") |
    str_detect(Agency, "Fire Department")
)




## ---------------------------------------------------------------------------------
tax$LotSize = str_trim(tax$LotSize) # trim to be safe
lot = tax$LotSize # for checking later


## ---------------------------------------------------------------------------------
aIndex= which(str_detect(tax$LotSize, "AC.*") | 
            str_detect(tax$LotSize, fixed(" %")))
head(aIndex)
head(lot[aIndex])

acre = tax$LotSize[aIndex] # temporary variable
## find and replace character strings
acre = str_replace_all(acre, " AC.*","")
acre = str_replace_all(acre, " %","")
table(!is.na(as.numeric(acre)))

head(acre[is.na(as.numeric(acre))],50)

## lets clean the rest
acre = str_replace_all(acre, "-",".") # hyphen instead of decimal
head(acre[is.na(as.numeric(acre))])
table(!is.na(as.numeric(acre)))

acre = str_replace_all(acre, "ACRES","")
head(acre[is.na(as.numeric(acre))])

# take care of individual mistakes
acre = str_replace_all(acre, "O","0") # 0 vs O
acre = str_replace_all(acre, "Q","") # Q, oops
acre = str_replace_all(acre, ",.",".") # extra ,
acre = str_replace_all(acre, ",","") # extra ,
acre = str_replace_all(acre, "L","0") # leading L
acre = str_replace_all(acre, "-",".") # hyphen to period
acre[is.na(as.numeric(acre))]

acre2 = as.numeric(acre)*43560 
sum(is.na(acre2)) # all but 3


## ---------------------------------------------------------------------------------
library(purrr)
fIndex = which(str_detect(tax$LotSize, "X"))

ft = tax$LotSize[fIndex]

ft = str_replace_all(ft, fixed("&"), "-")
ft = str_replace_all(ft, "IMP ONLY ", "")
ft = str_replace_all(ft, "`","1")

ft= map_chr(str_split(ft, " "), first)

## now get the widths and lengths
width = map_chr(str_split(ft,"X"), first)
length = map_chr(str_split(ft,"X"), nth, 2) 

## width
widthFeet = as.numeric(map_chr(str_split(width, "-"), first))
widthInch = as.numeric(map_chr(str_split(width, "-"),nth,2))/12
widthInch[is.na(widthInch)] = 0 # when no inches present
totalWidth = widthFeet + widthInch # add together

# length
lengthFeet = as.numeric(map_chr(str_split(length, "-"),first))
lengthInch = as.numeric(map_chr(str_split(length, "-",2),nth,2))/12
lengthInch[is.na(lengthInch)] = 0 # when no inches present
totalLength = lengthFeet + lengthInch

# combine together for square feet
sqrtFt = totalWidth*totalLength 
ft[is.na(sqrtFt)] # what is left?


## ---------------------------------------------------------------------------------
tax$sqft = rep(NA)
tax$sqft[aIndex] = acre2
tax$sqft[fIndex] = sqrtFt
mean(!is.na(tax$sqft))

# already in square feet, easy!!
sIndex=which(str_detect(tax$LotSize, "FT") | str_detect(tax$LotSize, "S.*F."))
sf = tax$LotSize[sIndex] # subset temporary variable

sqft2 = map_chr(str_split(sf,"( |SQ|SF)"),first)
sqft2 = as.numeric(str_replace_all(sqft2, ",", "")) # remove , and convert
tax$sqft[sIndex] = sqft2
table(is.na(tax$sqft)) 
## progress!

#what remains?
lot[is.na(tax$sqft)]

