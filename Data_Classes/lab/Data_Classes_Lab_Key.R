####################
# Data Classes - Lab
####################

# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program. 
# http://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# 	Download as a CSV in your current working directory
# Note its also available at: 
#	http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv
library(readr)
library(dplyr)
library(lubridate)

bike = read_csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv")


####################
# Part 1
####################
# 1.  Get all the differet types of bike types from the "type" column.
# Use sort(unique()).  Assign this to an object btypes. Type dput(btypes)
btypes = sort(unique(bike$type))

dput(btypes)
dput(btypes)[c(6,1:5,7)]
dput(btypes[c(6,1:5,7)])
lev = c( "SIDEPATH", "BIKE BOULEVARD", "BIKE LANE", "CONTRAFLOW", "SHARED BUS BIKE", 
        "SHARROW", "SIGNED ROUTE")
# 2. Reorder the output of the dput command so sidepath is first.  
# Recode type as a factor using this vector of levels.  
# Print head(bike$type).  Note what you see.  Run 
# table(bike$type) afterwards and note the order

bike$type = factor(bike$type,
          levels = dput(btypes[c(6,1:5,7)]))

bike = bike %>% mutate(type = factor(type, 
                levels = dput(btypes[c(6,1:5,7)])))
  
table(bike$type)

# 3. Make a column type2, which is a factor of type, with the 
# levels: 
# c( "SIDEPATH", "BIKE BOULEVARD", "BIKE LANE").  Run table(bike$type2),
# with the option useNA = "always".  Note, we do not have to 
# make type a character again before doing this
bike = bike %>% 
  mutate(type2 = factor(type, 
             levels = c( "SIDEPATH", "BIKE BOULEVARD", 
                         "BIKE LANE") ) )
table(bike$type)
table(bike$type2)
table(bike$type2, useNA = "always")

# 4. 
# a) Reassign dateInstalled into a character using as.character.  
# Run head(bike$dateInstalled).
bike = bike %>% 
  mutate(dateInstalled = 
           as.character(dateInstalled)
  )
head(bike$dateInstalled)


# b) Reassign dateInstalled a factor, using the default levels.
# Run head(bike$dateInstalled).
bike = bike %>% 
  mutate(dateInstalled = 
           factor(dateInstalled)
  )
head(bike$dateInstalled)

table(factor(bike$dateInstalled, levels = 2005:2017))
table(factor(bike$dateInstalled, levels = 2005:2017), 
        useNA="ifany")

# c) Do not reassign dateInstalled, but simply run
#  head(as.numeric(bike$dateInstalled)) 
# we are looking to see what happens when we try to go from factor to numeric
head(as.numeric(bike$dateInstalled)) 


# d) Do not reassign dateInstalled, but simply run
# head(as.numeric(as.character(bike$dateInstalled)))
# this is how you get "numeric" values back if they were "incorrectly" 
# factors
head(as.numeric(as.character(
    bike$dateInstalled)))


####################
# Part 2
####################
# 5.  Convert type back to a character.
# Make a column type2 (replacing the old one)
# where if the type is one of these categories:
# c("CONTRAFLOW", "SHARED BUS BIKE", "SHARROW", "SIGNED ROUTE")
# call it "OTHER".  Use %in% and ifelse.  Make type2 a factor
# with the levels c( "SIDEPATH", "BIKE BOULEVARD", "BIKE LANE", "OTHER")
bike = bike %>% mutate(
    type = as.character(type),
    type2 = ifelse(type %in% c("CONTRAFLOW", "SHARED BUS BIKE", 
                               "SHARROW", "SIGNED ROUTE"), "OTHER", type),
    type2 = factor(type2, levels = c( "SIDEPATH", "BIKE BOULEVARD", 
                               "BIKE LANE", "OTHER") ))

table(bike$type2)

bike2 = bike %>% 
  mutate(
    type = factor(type,
                  levels = c( "SIDEPATH", "BIKE BOULEVARD", 
                              "BIKE LANE", "CONTRAFLOW", 
                              "SHARED BUS BIKE", 
                              "SHARROW", "SIGNED ROUTE")
                  ),
    type2 = recode_factor(type, 
                          "CONTRAFLOW" = "OTHER",
                          "SHARED BUS BIKE" = "OTHER",
                          "SHARROW" = "OTHER",
                          "SIGNED ROUTE" = "OTHER")
  )
table(bike2$type2)

#################################
# Part 3
#################################
# 6.  Parse the following dates with the correct lubridate function:
# a) "2014/02-14"
ymd("2014/02-14")
# b) "04/22/14 03:20"
mdy_hm("04/22/14 03:20")
# c) "4/5/2016 03:2:22" # assume mdy
mdy_hms("4/5/2016 03:2:22")










