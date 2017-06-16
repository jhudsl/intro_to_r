####################
# Data Summarization - Lab
####################

# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program. 
# http://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# Download as a CSV in your current working directory
# Note its also available at: 
#	http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv
library(readr)
library(dplyr)

bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
bike$type[bike$type==" "] = NA # OR do this

# 1. How many bike "lanes" are currently in Baltimore? 
#		You can assume each observation/row is a different bike "lane"
nrow(bike)
dim(bike)

# 2. How many (a) feet and (b) miles of bike "lanes" are currently in Baltimore?
sum(bike$length)
sum(bike$length)/5280
sum(bike$length/5280)

# 3. How many types of bike lanes are there? Which type has 
#		(a) the most number of and (b) longest average bike lane length?
table(bike$type)
length(table(bike$type))
length(unique(bike$type))

tapply(bike$length, bike$type, mean, na.rm=TRUE)
bike %>% 
  group_by(type) %>% 
  summarise(n = n(),
            mean = mean(length))

# 4. How many different projects do the "bike" lanes fall into? 
#		Which project category has the longest average bike lane? 
length(unique(bike$project))
tapply(bike$length,bike$project, mean,na.rm=TRUE)
bike %>% 
  group_by(project, type) %>% 
  summarise(n = n(),
            mean = mean(length)) %>% 
  arrange(desc(mean))

arrange(summarize(group_by(bike, project, type), 
          n = n(), mean = mean(length)),
        desc(mean))
# bike %>% summarize(subType = mean() )

			  
# 5. What was the average bike lane length per year that they were installed? 
# Set bike$dateInstalled to NA if it is equal to zero.
b2 = bike %>% 
  mutate(dateInstalled = ifelse(dateInstalled == "0", NA, 
                                dateInstalled))
# b2 = bike %>% 
#   mutate(dateInstalled = if_else(dateInstalled == "0", 
#                                  NA_integer_, 
#                                 dateInstalled))
bike$dateInstalled[bike$dateInstalled == "0"] = NA
tapply(bike$length,bike$dateInstalled, mean,na.rm=TRUE)
bike %>% 
  group_by(dateInstalled) %>% 
  summarise(n = n(),
            mean = mean(length))
# 6. (a) Numerically [hint: `quantile()`] and 
#		(b) graphically [hint: `hist()` or `plot(density())`]
#		 describe the distribution of bike "lane" lengths.
quantile(bike$length)

hist(bike$length)
hist(bike$length,breaks=100)

hist(log2(bike$length),breaks=100)


# 7. Then describe as above, after stratifying by 
#		i) type then ii) number of lanes
boxplot(bike$length~bike$type)
boxplot(bike$length~bike$type,las=3)
boxplot(bike$length~bike$numLanes)

tapply(bike$length,bike$type, 
       quantile,na.rm=TRUE)
tapply(bike$length,bike$numLanes, 
       quantile,na.rm=TRUE)

