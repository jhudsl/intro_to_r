lhs %in% c("x" ,"z", "r")
lhs == "x" | lhs == "z" | lhs == "r"
"x" %in% lhd
"x" %in% lhs
c("x", "r") %in% lhs
lhx
lhs
hist(log2(pres$CityTax+1))
pres = tax %>% filter( ResCode %in% "PRINCIPAL RESIDENCE")
pres = tax %>% filter( ResCode == "PRINCIPAL RESIDENCE")
#	a) How many such houses are there?
dim(pres)
#	b) Describe the distribution of property taxes on these residences.  Use
# hist with certain breaks or plot(density(variable))
hist(log2(pres$CityTax+1))
plot(density(pres$CityTax))
?density
plot(density(pres$CityTax,  na.rm = TRUE))
duplicated(c(1:5, 1))
wide = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes_Wide.csv")
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
long = gather(wide, key = lanetype, value = the_length, -name)
long = gather(wide, key = "lanetype", value = "the_length", -name)
head(long)
View(long)
View(wide)
?starts_with
long = gather(wide, key = "lanetype", value = "the_length"
)
head(long)
tail(long)
long = filter(long, !is.na(lanetype))
tail(long)
long = filter(long, lanetype != "<NA>"
)
tail(long)
head(long)
crash = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/crashes.csv")
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")
head(crash)
head(road)
head(crash)
crash2 = crash %>% mutate(
Road = Road %>% str_replace("-", " ")
)
table(crash2$Road)
table(crash$Road)
count(crash)
nrow(crash)
dim(raod)
dim(road)
raos
raod
road
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")
dim(road)
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")
dim(road)
raod
road
crash2 = crash2 %>% separate(col = "Road", into = c("type", "number"))
colnames(crash2)
head(crash2)
?separate
crash2 = crash2 %>% separate(
col = "Road",
into = c("type", "number"), sep = "[ ]")
crash2 = crash2 %>% separate(
col = "Road",
into = c("type", "number"), sep = " ")
crash2 = crash %>% mutate(
Road = Road %>% str_replace("-", " ")
)
crash2 = crash2 %>% separate(
col = "Road",
into = c("type", "number"), sep = "[ ]")
head(crash2)
table(crash2$type)
crash3 = crash %>% separate(
col = "Road",
into = c("type", "number"), sep = " ")
head(crash3)
table(crash3$type)
crash2 = crash2 %>% unite(col = "road_hyphen", number, type)
head(crash2)
?unite
crash2 = crash %>% mutate(
Road = Road %>% str_replace("-", " ")
)
crash2 = crash2 %>% separate(
col = "Road",
into = c("type", "number"), sep = "[ ]")
crash2 = crash2 %>% unite(col = "road_hyphen",
type, number, sep = "-")
head(crash2)
table(crash2$Year)
unique(crash2$Year)
length(unique(crash2$Year))
circ = read_csv(
paste0("http://johnmuschelli.com/intro_to_r/",
"data/Charm_City_Circulator_Ridership.csv")
)
View(circ)
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
source('~/.active-rstudio-document', echo=TRUE)
df
source('~/.active-rstudio-document', echo=TRUE)
df[5]
df[5,]
df[6,]
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
bike = bike %>% filter(!is.na(type), !is.na(name))
sub = sub %>% select(type, length, name) %>%
group_by(name) %>%
summarize(length = sum(length))
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
# 9.  Filter any rows that have a missing value in the "type" column or missing
# name and re-assign the output to bike
bike = bike %>% filter(!is.na(type), !is.na(name))
# 10.  Select only the type, length, and name.  Summarize group the data by grouping
# name
# and take the sum of the length (reassign length variable).  Call this data set sub
sub = sub %>% select(type, length, name) %>%
group_by(name) %>%
summarize(length = sum(length))
sub = bike %>% select(type, length, name) %>%
group_by(name) %>%
summarize(length = sum(length))
head(sub)
sub = bike %>% select(type, length, type) %>%
group_by(type) %>%
summarize(length = sum(length))
head(sub)
sub = bike %>% select(type, length, name) %>%
group_by(name, type) %>%
summarize(length = sum(length))
sub
wide = sub %>% spread(key = type, value = length)
head(wide)
View(wide)
?join
merged = inner_join(road, crash)
merged = inner_join(road, crash, by = "Road")
head(merged)
dim(merged)
nrow(crash)
nrow(road)
anti = anti_join(road, crash, by = "Road")
dim(anti)
head(anti)
road
anti2 = anti_join(crash, road, by = "Road")
anti2
anti = anti_join(road, crash, by = "Road")
anti
anti2 = anti_join(crash, road, by = "Road")
anti2
unique(anti2$Road)
full = inner_join(road, crash)
full
full = inner_join(crash, crash)
full
crash2 = crash
crash2$Volume[1] = 20
full = inner_join(crash, crash2)
full
arrange(full, Year, Volume)
crash =arrange(crash, Year, Volume)
crash2 = crash
crash2$Volume[1] = 20
full = inner_join(crash, crash2)
head(full)
crash =arrange(crash, Year, Road, Volume)
crash2 = crash
crash2$Volume[1] = 20
full = inner_join(crash, crash2)
arrange(full, Year, Road, Volume)
tail(full)
head(crash)
head(crash2)
crash =arrange(crash, Year, Road, Volume)
full = inner_join(crash, crash)
arrange(full, Year, Road, Volume)
crash =arrange(crash, Year, Road, Volume)
# crash2 = crash
# crash2$Volume[1] = 20
full = inner_join(crash, crash)
crash =arrange(crash, Year, Road, Volume)
crash2 = crash
crash2$Volume[1] = 20
crash == crash2
head(crash == crash2)
head(crash != crash2)
colSums(crash != crash2)
rowSums(crash != crash2)
all.equal(crash, crash)
all.equal(crash, crash2)
identical(crash, crash2)
head(crash2)
crash =arrange(crash, Year, Road, Volume)
crash2 = crash
crash2$Volume[1] = 20L
all.equal(crash, crash2)
identical(crash, crash2)
crash = arrange(crash, Year, Road, Volume)
crash2 = crash
crash2$Volume[1] = 20
all.equal(crash, crash2)
head(crash)
lhs %in% c("x" ,"z", "r")
lhs == "x" | lhs == "z" | lhs == "r"
"x" %in% lhd
"x" %in% lhs
c("x", "r") %in% lhs
lhx
lhs
hist(log2(pres$CityTax+1))
pres = tax %>% filter( ResCode %in% "PRINCIPAL RESIDENCE")
pres = tax %>% filter( ResCode == "PRINCIPAL RESIDENCE")
#	a) How many such houses are there?
dim(pres)
#	b) Describe the distribution of property taxes on these residences.  Use
# hist with certain breaks or plot(density(variable))
hist(log2(pres$CityTax+1))
plot(density(pres$CityTax))
?density
plot(density(pres$CityTax,  na.rm = TRUE))
duplicated(c(1:5, 1))
wide = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes_Wide.csv")
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
long = gather(wide, key = lanetype, value = the_length, -name)
long = gather(wide, key = "lanetype", value = "the_length", -name)
head(long)
View(long)
View(wide)
?starts_with
long = gather(wide, key = "lanetype", value = "the_length"
)
head(long)
tail(long)
long = filter(long, !is.na(lanetype))
tail(long)
long = filter(long, lanetype != "<NA>"
)
tail(long)
head(long)
crash = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/crashes.csv")
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")
head(crash)
head(road)
head(crash)
crash2 = crash %>% mutate(
Road = Road %>% str_replace("-", " ")
)
table(crash2$Road)
table(crash$Road)
count(crash)
nrow(crash)
dim(raod)
dim(road)
raos
raod
road
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")
dim(road)
road = read_csv("http://johnmuschelli.com/intro_to_r/Manipulating_Data_in_R/lab/roads.csv")
dim(road)
raod
road
crash2 = crash2 %>% separate(col = "Road", into = c("type", "number"))
colnames(crash2)
head(crash2)
?separate
crash2 = crash2 %>% separate(
col = "Road",
into = c("type", "number"), sep = "[ ]")
crash2 = crash2 %>% separate(
col = "Road",
into = c("type", "number"), sep = " ")
crash2 = crash %>% mutate(
Road = Road %>% str_replace("-", " ")
)
crash2 = crash2 %>% separate(
col = "Road",
into = c("type", "number"), sep = "[ ]")
head(crash2)
table(crash2$type)
crash3 = crash %>% separate(
col = "Road",
into = c("type", "number"), sep = " ")
head(crash3)
table(crash3$type)
crash2 = crash2 %>% unite(col = "road_hyphen", number, type)
head(crash2)
?unite
crash2 = crash %>% mutate(
Road = Road %>% str_replace("-", " ")
)
crash2 = crash2 %>% separate(
col = "Road",
into = c("type", "number"), sep = "[ ]")
crash2 = crash2 %>% unite(col = "road_hyphen",
type, number, sep = "-")
head(crash2)
table(crash2$Year)
unique(crash2$Year)
length(unique(crash2$Year))
circ = read_csv(
paste0("http://johnmuschelli.com/intro_to_r/",
"data/Charm_City_Circulator_Ridership.csv")
)
View(circ)
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
source('~/.active-rstudio-document', echo=TRUE)
df
source('~/.active-rstudio-document', echo=TRUE)
df[5]
df[5,]
df[6,]
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
bike = bike %>% filter(!is.na(type), !is.na(name))
sub = sub %>% select(type, length, name) %>%
group_by(name) %>%
summarize(length = sum(length))
bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
# 9.  Filter any rows that have a missing value in the "type" column or missing
# name and re-assign the output to bike
bike = bike %>% filter(!is.na(type), !is.na(name))
# 10.  Select only the type, length, and name.  Summarize group the data by grouping
# name
# and take the sum of the length (reassign length variable).  Call this data set sub
sub = sub %>% select(type, length, name) %>%
group_by(name) %>%
summarize(length = sum(length))
sub = bike %>% select(type, length, name) %>%
group_by(name) %>%
summarize(length = sum(length))
head(sub)
sub = bike %>% select(type, length, type) %>%
group_by(type) %>%
summarize(length = sum(length))
head(sub)
sub = bike %>% select(type, length, name) %>%
group_by(name, type) %>%
summarize(length = sum(length))
sub
wide = sub %>% spread(key = type, value = length)
head(wide)
View(wide)
?join
merged = inner_join(road, crash)
merged = inner_join(road, crash, by = "Road")
head(merged)
dim(merged)
nrow(crash)
nrow(road)
anti = anti_join(road, crash, by = "Road")
dim(anti)
head(anti)
road
anti2 = anti_join(crash, road, by = "Road")
anti2
anti = anti_join(road, crash, by = "Road")
anti
anti2 = anti_join(crash, road, by = "Road")
anti2
unique(anti2$Road)
full = inner_join(road, crash)
full
full = inner_join(crash, crash)
full
crash2 = crash
crash2$Volume[1] = 20
full = inner_join(crash, crash2)
full
arrange(full, Year, Volume)
crash =arrange(crash, Year, Volume)
crash2 = crash
crash2$Volume[1] = 20
full = inner_join(crash, crash2)
head(full)
crash =arrange(crash, Year, Road, Volume)
crash2 = crash
crash2$Volume[1] = 20
full = inner_join(crash, crash2)
arrange(full, Year, Road, Volume)
tail(full)
head(crash)
head(crash2)
crash =arrange(crash, Year, Road, Volume)
full = inner_join(crash, crash)
arrange(full, Year, Road, Volume)
crash =arrange(crash, Year, Road, Volume)
# crash2 = crash
# crash2$Volume[1] = 20
full = inner_join(crash, crash)
crash =arrange(crash, Year, Road, Volume)
crash2 = crash
crash2$Volume[1] = 20
crash == crash2
head(crash == crash2)
head(crash != crash2)
colSums(crash != crash2)
rowSums(crash != crash2)
all.equal(crash, crash)
all.equal(crash, crash2)
identical(crash, crash2)
head(crash2)
crash =arrange(crash, Year, Road, Volume)
crash2 = crash
crash2$Volume[1] = 20L
all.equal(crash, crash2)
identical(crash, crash2)
crash = arrange(crash, Year, Road, Volume)
crash2 = crash
crash2$Volume[1] = 20
all.equal(crash, crash2)
head(crash)
crash$Road = factor(crash$Road)
crash2 = crash
crash2$Road = factor(crash2$Road, levels = unique(crash2$Road))
all.equal(crash, crash2)
unique(crash2$Road)
crash2$Road = factor(crash2$Road, levels = sample(unique(crash2$Road)))
all.equal(crash, crash2)
crash2$Volume[1] = 20
all.equal(crash, crash2)
nrow(full_join(crash, road))
left = left_join(road, crash)
nrow(left)
## ----knit-setup, echo=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE,
message = FALSE,
warning = FALSE,
fig.height = 4,
fig.width = 7,
comment = "")
## ----seed, comment="",echo=FALSE-----------------------------------------
set.seed(3)
## ----plotEx,  fig.align='center',cache=FALSE-----------------------------
library(readr)
death = read_csv(
"http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv")
death[1:2, 1:5]
## ------------------------------------------------------------------------
colnames(death)[1] = "country"
death[1:2, 1:5]
## ----plot1, comment="",  fig.align='center',cache = FALSE----------------
library(dplyr)
sweden = death %>%
filter(country == "Sweden") %>%
select(-country)
year = as.numeric(colnames(sweden))
plot(as.numeric(sweden) ~ year)
## ----plotEx2, comment="",  fig.align='center',cache = FALSE--------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden", type = "l")
## ----plotEx3, fig.align='center', cache = FALSE--------------------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden",
xlim = c(1760,2012), pch = 19, cex=1.2,col="blue")
## ----plotEx_sub, fig.align='center', cache = FALSE-----------------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden",
subset = year < 2015, pch = 19, cex=1.2,col="blue")
## ----makelong_swede, fig.align='center', cache = FALSE-------------------
library(tidyr)
long = gather(death, key = year, value = deaths, -country)
long = long %>% filter(!is.na(deaths))
head(long)
class(long$year)
long$year = as.numeric(long$year)
## ----plot_long_swede, fig.align='center'---------------------------------
swede_long = long %>% filter(country == "Sweden")
plot(deaths ~ year, data = swede_long)
## ------------------------------------------------------------------------
library(ggplot2)
qplot(x = year, y = deaths, data = swede_long)
## ----generic_gg, comment="",  fig.align='center', cache=FALSE------------
g = ggplot(data = swede_long, aes(x = year, y = deaths))
## ----gprint_point--------------------------------------------------------
gpoints = g + geom_point(); print(gpoints) # one line for slides
## ----geom_line-----------------------------------------------------------
g + geom_line()
## ----geom_line_point-----------------------------------------------------
g + geom_line() + geom_point()
g + geom_line(color = "green") + geom_point()
g + geom_point() + geom_line(color = "green")
### Data Visualization Lab
## you will need the charm city circulator dataset:
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
# read in data
# covert dates
circ = mutate(circ, date = mdy(date))
# change colnames for reshaping
colnames(circ) =  colnames(circ) %>%
str_replace("Board", ".Board") %>%
str_replace("Alight", ".Alight") %>%
str_replace("Average", ".Average")
# make long
long = gather(circ, "var", "number",
starts_with("orange"),
starts_with("purple"), starts_with("green"),
starts_with("banner"))
# separate
long = separate(long, var, into = c("line", "type"),
sep = "[.]")
## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))
# separate
type_wide = spread(long, type, value = number)
head(type_wide)
### Data Visualization Lab
## you will need the charm city circulator dataset:
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
# read in data
# covert dates
circ = mutate(circ, date = mdy(date))
# change colnames for reshaping
colnames(circ) =  colnames(circ) %>%
str_replace("Board", ".Board") %>%
str_replace("Alight", ".Alight") %>%
str_replace("Average", ".Average")
# make long
long = gather(circ, "var", "number",
starts_with("orange"),
starts_with("purple"), starts_with("green"),
starts_with("banner"))
# separate
long = separate(long, var, into = c("line", "type"),
sep = "[.]")
## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))
# separate
type_wide = spread(long, type, value = number)
head(type_wide)
?gplot
??gplot
### Data Visualization Lab
## you will need the charm city circulator dataset:
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
# read in data
# covert dates
circ = mutate(circ, date = mdy(date))
# change colnames for reshaping
colnames(circ) =  colnames(circ) %>%
str_replace("Board", ".Board") %>%
str_replace("Alight", ".Alight") %>%
str_replace("Average", ".Average")
# make long
long = gather(circ, "var", "number",
starts_with("orange"),
starts_with("purple"), starts_with("green"),
starts_with("banner"))
# separate
long = separate(long, var, into = c("line", "type"),
sep = "[.]")
## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))
# separate
type_wide = spread(long, type, value = number)
head(type_wide)
# Using ggplot2:
qplot(x = date, y = number, data = avg, colour = line)
first_plot = qplot(x = date, y = number, data = avg, colour = line)
print(first_plot)
pal = c("blue", "darkgreen","orange","purple")
qplot(x = date, y = number, data = avg, colour = line) +
scale_colour_manual(values = pal)
qplot(x = date, y = number, data= avg, facets = ~line)
first_plot + geom_smooth(se = FALSE)
first_plot + geom_smooth(se = FALSE) + facet_wrap(~ line)
cars = read_csv("http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv")
key = read_tsv("http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary_formatted.txt")
x = readLines("data/Carvana_Data_Dictionary.txt")
x
save(cars, key, file = "HW/kaggle.rda")
range(cars$VehYear)
source('~/Dropbox/Teaching/intro_to_r/HW/homework2_key.R', echo=TRUE)
mean(cars$VehYear < 2004)
## 140.886: Intro to R
## Homework 2
## Due Date: Day 3
# Instructions:
# 1)	Get the dataset: http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv
# 2)	Read the "dictionary": http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary_formatted.txt
# What would you do if the data was formatted like this:
# http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary.txt
# with spaces and tabs and such?
# This is a dataset from the "Kaggle" website, which hosts competitions for prediction and machine learning.
# More details on this dataset are here:
# http://www.kaggle.com/c/DontGetKicked/details/Background
# Questions
# 1)	Read in the dataset itself, naming the R object "cars" into R. Use read_csv
# Read in the dictionary and name it key.  Use read_tsv
cars = read_csv("http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv")
key = read_tsv("http://johnmuschelli.com/intro_to_r/data/Carvana_Data_Dictionary_formatted.txt")
### Save the key and data in an ".rda" file so you can access the data offline.
# use the save(cars, key, file = "kaggle.rda")
save(cars, key, file = "HW/kaggle.rda")
# 2)	How many cars are in the dataset? How many variables are recorded for each car?
dim(cars)
nrow(cars)
# 3)	What is the range of the manufacturer's years of the vehicles? Use VehYear
# How many cars were from before 2004, and percent/proportion of these in the population?
range(cars$VehYear)
table(cars$VehYear)
sum(cars$VehYear < 2004)
mean(cars$VehYear < 2004)
sum(cars$VehBCost <= 1500 | is.na(cars$VehBCost))
cars = filter(cars, cars$VehBCost > 1500)
nrow(cars)
length(unique(cars$Make)) # a
length(table(cars$Make))
length(unique(cars$Model)) # b
length(unique(cars$Size)) # c
cars %>% group_by(Make) %>%
summarize(mean = mean(VehBCost)) %>%
arrange(desc(mean))
cars %>% group_by(Model) %>%
summarize(mean = mean(VehBCost)) %>%
arrange(desc(mean))
cars %>% group_by(Color) %>%
summarize(mean = mean(VehBCost)) %>%
arrange(desc(mean))
cars %>% group_by(Make) %>%
summarize(var = var(VehBCost)) %>%
arrange(desc(var))
cars %>% group_by(Model) %>%
summarize(var = var(VehBCost)) %>%
arrange(desc(var))
cars %>% group_by(Color) %>%
summarize(var = var(VehBCost)) %>%
arrange(desc(var))
plot(VehBCost ~ VehOdo, data = cars)
boxplot(VehBCost ~ cars$IsBadBuy, data=cars,ylab="Cost")
## ----knit-setup, echo=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE,
message = FALSE,
warning = FALSE,
fig.height = 4,
fig.width = 7,
comment = "")
## ----seed, comment="",echo=FALSE-----------------------------------------
set.seed(3)
## ----plotEx,  fig.align='center',cache=FALSE-----------------------------
library(readr)
death = read_csv(
"http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv")
death[1:2, 1:5]
## ------------------------------------------------------------------------
colnames(death)[1] = "country"
death[1:2, 1:5]
## ----plot1, comment="",  fig.align='center',cache = FALSE----------------
library(dplyr)
sweden = death %>%
filter(country == "Sweden") %>%
select(-country)
year = as.numeric(colnames(sweden))
plot(as.numeric(sweden) ~ year)
## ----plotEx2, comment="",  fig.align='center',cache = FALSE--------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden", type = "l")
## ----plotEx3, fig.align='center', cache = FALSE--------------------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden",
xlim = c(1760,2012), pch = 19, cex=1.2,col="blue")
## ----plotEx_sub, fig.align='center', cache = FALSE-----------------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden",
subset = year < 2015, pch = 19, cex=1.2,col="blue")
## ----makelong_swede, fig.align='center', cache = FALSE-------------------
library(tidyr)
long = gather(death, key = year, value = deaths, -country)
long = long %>% filter(!is.na(deaths))
head(long)
class(long$year)
long$year = as.numeric(long$year)
## ----plot_long_swede, fig.align='center'---------------------------------
swede_long = long %>% filter(country == "Sweden")
plot(deaths ~ year, data = swede_long)
## ------------------------------------------------------------------------
library(ggplot2)
qplot(x = year, y = deaths, data = swede_long)
## ----generic_gg, comment="",  fig.align='center', cache=FALSE------------
g = ggplot(data = swede_long, aes(x = year, y = deaths))
## ----gprint_point--------------------------------------------------------
gpoints = g + geom_point(); print(gpoints) # one line for slides
## ----geom_line-----------------------------------------------------------
g + geom_line()
## ----geom_line_point-----------------------------------------------------
g + geom_line() + geom_point()
g + geom_line(color = "green") + geom_point()
g + geom_point() + geom_line(color = "green")
g + geom_line(color = "green") + geom_point()
