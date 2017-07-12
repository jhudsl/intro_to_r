####################
# Data Summarization - Lab
####################

# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program. 
# http://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# 	Download as a CSV in your current working directory
# Note its also available at: 
#	http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv
library(readr)
library(dplyr)

bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")
##########################
# Part 1
##########################
# 1. How many bike "lanes" are currently in Baltimore? 
#		You can assume each observation/row is a different bike "lane"
nrow(bike)
dim(bike)

# 2. How many (a) feet and (b) miles of bike "lanes" are currently in Baltimore?
# what is the mean number of feet over all records?
sum(bike$length)
sum(bike$length)/5280
sum(bike$length/5280)
mean(bike$length)

##########################
# Part 2
##########################
# 3. How many types of bike lanes are there? Which type has 
#		(a) the most number of?  Use `table`
table(bike$type)
unique(bike$type)
sort(table(bike$type))
table(bike$type, useNA = "ifany")
# 4. How many different projects do the "bike" lanes fall into? 
# use unique and length
length(unique(bike$project))

##########################
# Part 3
##########################
# 5. Which bike lane type has the longest average bike lane length?
# use group_by
summarize(group_by(bike, type), avg = mean(length, na.rm=TRUE))
bike %>% 
  group_by(type) %>% 
  summarise(avg = mean(length, na.rm = TRUE))
#	6. Which project category has the longest average bike lane? 
# use group_by
bike %>% 
  group_by(project) %>% 
  summarise(avg = mean(length, na.rm = TRUE)) %>% 
  arrange(desc(avg))

# 7. What was the average bike lane length per year that they were installed?
# Set bike$dateInstalled to NA if it is equal to zero.
bike$dateInstalled[ bike$dateInstalled == 0 ] = NA
bike %>% 
  group_by(dateInstalled) %>% 
  summarise(avg = mean(length, na.rm = TRUE)) %>% 
  arrange(desc(avg))

bike = bike %>% 
  mutate(dateInstalled = 
           ifelse(dateInstalled == 0, NA, 
                  dateInstalled))

##########################
# Part 4
##########################
# 8. (a) Numerically [hint: `quantile()`] and 
#		(b) graphically [hint: `hist()` or `plot(density())`]
#		 describe the distribution of bike "lane" lengths.
quantile(bike$length)

hist(bike$length)
hist(bike$length,breaks=100)

hist(log2(bike$length),breaks=100)
hist(log10(bike$length + 1),breaks=100)


# 9. Then describe as above, after stratifying by 
#		i) type then ii) number of lanes
bike %>% 
  group_by(type) %>% 
  summarize(quant = quantile(length))

bike %>% 
  group_by(type) %>% 
  summarize(min = min(length),
            q25 = quantile(length, probs = 0.25),
            q50 = quantile(length, probs = 0.5),
            q75 = quantile(length, probs = 0.75),
            max = max(length)
  )

  
# 10. Then describe as above, after stratifying by i) type then 
# ii) number of lanes
boxplot(data = bike, length ~ type)
boxplot(data = bike, log10(length) ~ type)


ggplot(bike, aes(y = length, x = type)) + 
  geom_boxplot()




