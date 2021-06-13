## ---------------------------------------------------------------------------------
library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)
library(jhur)
library(tidyverse)
library(broom)

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
side_bike = bike %>% filter(type %in% c("SIDEPATH", "BIKE LANE"))
side_bike2 = bike %>% filter(type == "SIDEPATH" | type == "BIKE LANE")
identical(side_bike, side_bike2)
nrow(side_bike)
nrow(side_bike2)

side_bike = filter(bike,type %in% c("SIDEPATH", "BIKE LANE"))
side_bike2 = filter(bike, type == "SIDEPATH" | type == "BIKE LANE")
identical(side_bike, side_bike2)


## ---------------------------------------------------------------------------------
tab = table(type=bike$type, numLanes=bike$numLanes)
prop.table(tab, 1)
prop.table(tab, 2)
as.data.frame(tab)
tidy(tab)




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
## useing parse_numbers()
options(digits=12) # so no rounding
tax = tax %>% mutate(StateTax = parse_number(StateTax))
                     
sum(tax$CityTax)
sum(tax$CityTax, na.rm = TRUE)
sum(tax$CityTax, na.rm = TRUE)/1e6

sum(tax$StateTax, na.rm = TRUE)
sum(tax$StateTax, na.rm = TRUE)/1e6



## ---------------------------------------------------------------------------------
table(tax$Ward)

ward_table = tax %>% 
  group_by(Ward) %>% 
  tally()

ward_table = tax %>% 
  group_by(Ward) %>% 
  summarize(number_of_obs = n(),
            mean(StateTax, na.rm = TRUE))




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
tax %>% group_by(Ward) %>% 
  summarize(Percentile = quantile(StateTax, prob = 0.75,na.rm = TRUE))


ward_table = tax %>% 
  group_by(Ward) %>% 
  summarize(
    number_of_obs = n(),
    mean_state_tax = mean(StateTax, na.rm = TRUE),
    max_amount_due = max(AmountDue, na.rm = TRUE),
    q75_city = quantile(CityTax, probs = 0.75, na.rm = TRUE),
    q75_state = quantile(StateTax, probs = 0.75, na.rm = TRUE)
  )


## ---------------------------------------------------------------------------------
tax = tax %>% 
  mutate(ResCode = str_trim(ResCode))

qplot(y = log10(CityTax+1), x = ResCode, data = tax, geom = "boxplot")
qplot(y = CityTax, x = ResCode, data = tax, geom = "boxplot")

boxplot(log10(CityTax+1) ~ ResCode, data = tax)
boxplot(CityTax ~ ResCode, data = tax)

tax %>% filter(CityTax == max(CityTax, na.rm = TRUE))



## ---------------------------------------------------------------------------------
pres = tax %>% filter( ResCode %in% "PRINCIPAL RESIDENCE")
pres = tax %>% filter( ResCode == "PRINCIPAL RESIDENCE")
dim(pres)


## ---------------------------------------------------------------------------------
qplot(x = log10(CityTax+1),data = pres, geom = "histogram")
qplot(x = CityTax, data = pres, geom = "density")

hist(log2(pres$CityTax+1))
hist(pres$CityTax)
head(pres$CityTax)
plot(density(pres$CityTax,  na.rm = TRUE))


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
sal = sal %>% mutate(AnnualSalary = str_replace(AnnualSalary, fixed("$"), ""))
sal = sal %>% mutate(AnnualSalary = as.numeric(AnnualSalary))
qplot(x = AnnualSalary, data = sal, geom = "histogram", bins = 20)

hist(sal$AnnualSalary, breaks = 20)
quantile(sal$AnnualSalary)


## ---------------------------------------------------------------------------------
sal = sal %>% mutate(HireDate = lubridate::mdy(HireDate))

q = qplot(y = AnnualSalary, x = HireDate, 
      data = sal, geom = "point")
q + geom_smooth(colour = "red", se = FALSE)
q + geom_smooth(colour = "red", se = FALSE, method = "loess")
q + geom_smooth(colour = "red", se = FALSE, method = "loess", span = 2/3)

plot(AnnualSalary ~ HireDate, data = sal)
scatter.smooth(sal$AnnualSalary, x = sal$HireDate, col = "red")



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
emer = emer %>% 
  mutate(
    dept = str_extract(Agency, ".*(ment|ice)")
  )
# Replot annual salary versus hire date, color by dept (not yet - using ggplot)
ggplot(aes(x = HireDate, y = AnnualSalary, 
           colour = dept), data = emer) + 
  geom_point() + theme(legend.position = c(0.5, 0.8))


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

