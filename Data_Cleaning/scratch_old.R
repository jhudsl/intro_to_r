nrow(filter(mtcars, mpg < 16 & hp > 100))
filter(df, mpg < 16 & hp > 100)
filter(x, mpg < 16 & hp > 100)
df
df = mtcars
df(0.5, 1, 5)
mtcars %>% filter( mpg > 20 ) %>% nrow()
filter(mtcars, mpg < 16 & hp > 100)
mtcars
filter(mtcars, mpg < 16 & hp > 100)
library(dplyr)
mtcars %>% filter( mpg > 20 ) %>% nrow()
filter(mtcars, mpg < 16 & hp > 100)
carsSub = filter(mtcars, cyl == 8)
carsSub = select(mtcars, wt, qsec, hp)
carsSub = filter(mtcars, cyl == 8)
carsSub = select(carsSub, wt, qsec, hp)
str(carsSub)
nrow(mtcars)
mtcars %>% filter(cyl == 8) %>% select(wt, qsec, hp)
carsSub = mtcars %>% filter(cyl == 8) %>% select(wt, qsec, hp)
nrow(carsSub)
sum(mtcars$cyl== 8)
cn = colnames(carsSub)
cn
toupper(cn)
cn = colnames(carsSub)
colnames(carsSub) = toupper(cn)
carsSub
carsSub %>% rename(WT = wt, QSEC = qsec, HP = hp)
carsSub = mtcars %>% filter(cyl == 8) %>% select(wt, qsec, hp)
carsSub %>% rename(WT = wt, QSEC = qsec, HP = hp)
arrange(carsSub, WT)
cn = colnames(carsSub)
colnames(carsSub) = toupper(cn)
arrange(carsSub, WT)
arrange(carsSub, desc(WT))
arrange(carsSub, -WT)
cars = mtcars
cars$car = rownames(cars)
cars
arrange(cars, -wt)
arrange(cars, -car)
arrange(cars, desc(car))
cars = mtcars
colnames(cars)[ colnames(cars) == "mpg"] = "MPG"
cars
cars = mtcars
rename(cars, MPG = mpg)
head(rename(cars, MPG = mpg))
?one_of
pvars = select(mtcars, ends_with("p"))
colnames(pvars)
pvars = select(mtcars, ends_with("p"), everything())
head(pvars)
summary(pvars)
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
library(readr)
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
?read_csf
?read_csv
library(readr)
library(dplyr)
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
View(bike)
library(readr)
library(dplyr)
bike = read_csv(
"http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
nrow(bike)
dim(bike)
sum(bike$length)
sum(bike$length)/5280
sum(bike$length/5280)
table(bike$type)
unique(bike$type)
?table
?unique
table(bike$type)
unique(bike$type)
table(bike$type, useNA = "ifany")
length(unique(bike$type))
is.na(unique(bike$type))
x != 5
x = 1:5
x != 5
! ( x == 5)
( x != 5)
is.na(unique(bike$type))
!is.na(unique(bike$type))
unique(bike$type)
ub = unique(bike$type)
ub == "CONTRAFLOW"
ub == "CONTRAFLOW" & !is.na(ub)
ub %in% "CONTRAFLOW"
ub
ub %in% c("CONTRAFLOW", "BIKE LANE")
tapply(bike$length, bike$type, mean, na.rm=TRUE)
bike %>%
group_by(type) %>%
summarise(n = n(),
mean = mean(length))
bike %>%
group_by(type) %>%
summarise(n = n(),
mean = mean(length)) %>%
arrange(mean)
library(Hmisc)
?label
system("open .")
library(readr)
suppressPackageStartupMessages(library(dplyr))
circ %>%
mutate(hi_rider = ifelse(daily > 10000,
"high", "low")) %>%
select(hi_rider)
circ = read_csv(
paste0("http://johnmuschelli.com/intro_to_r/data",
"/Charm_City_Circulator_Ridership.csv"))
circ %>%
mutate(hi_rider = ifelse(daily > 10000,
"high", "low")) %>%
select(hi_rider)
headcirc
head(circ)
circ %>%
mutate(hi_rider = ifelse(daily > 10000,
"high", "low")) %>%
select(day, date, daily, hi_rider)
?sclie
?slice
?first
circ %>%
mutate(first_date = first(newDate2))
library(lubridate) # great for dates!
head(circ$newDate2)
range(circ$newDate2) # gives you the range of the data
circ$bannerAlightings
head(circ)
circ = mutate(circ, newDate2 = mdy(date))
head(circ$newDate2)
range(circ$newDate2) # gives you the range of the data
circ %>%
mutate(first_date = first(newDate2))
circ %>%
mutate(first_date = first(newDate2)) %>%
select(day, date) %>% head
circ %>%
mutate(first_date = first(newDate2)) %>%
select(day, date) %>% head(3)
circ %>%
mutate(first_date = first(newDate2),
last_date = last(newDate2),
third_date = nth(newDate2, 3)) %>%
select(day, date, first_date, last_date, third_date) %>% head(3)
circ %>%
group_by(day) %>%
mutate(first_date = first(newDate2),
last_date = last(newDate2),
third_date = nth(newDate2, 3)) %>%
select(day, date, first_date, last_date, third_date) %>% head(3)
library(readr)
library(dplyr)
bike = read_csv(
"http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
head(bike)
View(bike)
bike$dateInstalled[ bike$dateInstalled == 0 ] = NA
bike = read_csv(
"http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
table(bike$dateInstalled)
bike$dateInstalled[ bike$dateInstalled == 0 ] = NA
table(bike$dateInstalled)
table(bike$dateInstalled, useNA = "ifany")
mean(bike$length[ !is.na(bike$dateInstalled)])
bike$dateInstalled == NA
bike %>%
group_by(dateInstalled)
bike %>%
group_by(dateInstalled) %>%
summarise(n = n(),
mean = mean(length))
bike %>%
group_by(dateInstalled) %>%
summarise(n = n(),
mean_of_the_bike = mean(length))
quantile(bike$length)
hist(bike$length)
?hist
hist(bike$length,breaks=100)
hist(log2(bike$length),breaks=100)
hist(log10(bike$length),breaks=100)
boxplot(bike$length~bike$type)
boxplot(bike$length~bike$type,las=3)
boxplot(bike$length~bike$type,las=2)
boxplot(bike$length~bike$type,las=45)
boxplot(bike$length~bike$type,las=4)
boxplot(bike$length~bike$numLanes)
boxplot(log10(bike$length)~bike$type)
log(0)
boxplot(log10(bike$length + 1)~bike$type)
bike$length[1] = NA
boxplot(log10(bike$length)~bike$type)
tapply(bike$length,bike$type,
quantile,na.rm=TRUE)
bike %>%
group_by(type) %>%
summarise(q = quanitle(length))
bike %>%
group_by(type) %>%
summarise(q = quantile(length))
bike %>%
x = c("apple", "umbrella", "boo", "APPLE")


library(stringr)
x = c("apple", "umbrella", "boo", "APPLE")
str_sub(x, 1, 4)
nchar(x)
str_sub(x, 1, 4)
str_sub(x, 2, 4)
nchar(x)
str_sub(x, 2, nchar(x))
str_sub(x, 2, nchar(x)-2)
nchar(x)-2
str_sub(x, 2, 1)
x
str_split(x, "l")
y = c("hey! wher", "are !", "you? ")
str_split(y, " ")
str_split(y, "!")
y = c("hey! wher", "are !", "you? ", "ii have multi spaces")
str_split(y, " ")
names = c("John Doe", "John Muschelli", "Steve Muschelli")
str_detect(names, "John")
str_detect(names, "i$")
names = c("Mr. John Doe", "John Muschelli", "Steve Muschelli")
str_detect(names, "John")
str_detect(names, "^John")
str_detect(names, "li$")
str_subset(names, "li$")
names[str_detect(names, "li$")]
str_extract(names, "John")
str_extract(names, "li$")
names = c(names, "hey li I'm good")
names
str_extract(names, "li$")
str_extract(names, "J*")
str_extract(names, "J.* ")
names
names =c("Joe Doe")
str_extract(names, "J.* ")
names = c("Mr. John Doe", "John Muschelli", "Steve Muschelli")
names =c(names, "Joe Doe")
str_extract(names, "J.* ")
str_subset(names, "J.* ")
str_detect(names, "J.* ")
str_replace(names, "John", "Joe")
names = c(names, "John John Diggle")
str_replace(names, "John", "Joe")
str_replace_all(names, "John", "Joe")
str_replace_all(names, "John|Steve", "Joe")
str_replace_all(names, "John|Steve|Doe", "Joe")
str_replace_all(names, fixed("john", ignore_case = TRUE), "Joe")
