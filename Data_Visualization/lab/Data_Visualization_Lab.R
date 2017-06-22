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
              -daily, -day, -date)
head(long)

# separate
long = separate(long, var, into = c("line", "type"), 
                sep = "[.]")
head(long)

## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))

# separate
type_wide = spread(long, type, value = number)
head(type_wide)

# Using ggplot2:

# Part 1 

# 1. plot average ridership (avg) by date. (do not take an average, 
# use the average column for each route/line)
# Try `qplot` and ggplot(aes(x, y, color ), data = avg) + geom_line()
# a. Color the points by route (orange, purple, green, banner)
#	b. Color the points by day of the week
# add geom_smooth(se = FALSE) to the plot (+ geom_smooth(se = FALSE))
# set first_plot equal to the output of plot 1a. Type print(first_plot)


print(first_plot)
# 2. Replot 1a where the colors of the points are the
#	name of the route (with banner --> blue)
# pal = c("blue", "darkgreen","orange","purple")
# use (add + ) 	scale_colour_manual(values = pal)

########################
# Part 2
########################
# 3. plot average ridership  by date with one panel per route
# use facet_wrap() or facet_grid() or (qplot): facets = ~line

# 4. plot average ridership by date with separate panels
#		by day of the week, colored by route
# combine facets and color

########################
# Part 3
########################
# 5.  plot average ridership (avg) by date, colored by line (same as 1a). 
# (do not take an average, 
# use the average column for each route/line)
# Make the x-label "Year"
# Make the y-label "Number of People"
# Use the black and white theme theme_bw()
# Change the text_size to (text = element_text(size = 20))
# in theme

# 6. plot average ridership on the orange route versus date
#		as a solid line, and add dashed "error" lines based 
#		on the boardings and alightings. 
#	the line colors should be orange. 
# (hint linetype is an aesthetic for lines) - see also scale_linetype and 
# scale_linetype_manual
# Alightings = "dashed", Boardings = "dashed", Average = "solid"
