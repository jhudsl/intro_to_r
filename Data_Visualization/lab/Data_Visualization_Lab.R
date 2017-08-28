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

# Part 1 

# 1. plot average ridership (avg) by date. (do not take an average, 
# use the average column for each route/line)
# Try `qplot` and ggplot(aes(x, y, color ), data = avg) + geom_line()
# a. Color the points by route (orange, purple, green, banner)
#	b. Color the points by day of the week
# add geom_smooth(se = FALSE) to the plot (+ geom_smooth(se = FALSE))
# set first_plot equal to the output of plot 1a. Type print(first_plot)
qplot(data = avg, x = date, y = number, 
      color = line, geom = "line")

ggplot(aes(x = date, y = number, 
           color = line), 
       data = avg) + geom_line()

g = ggplot(aes(x = date, y = number ),  data = avg) 
g = g + aes( color = day ) 
g = g + geom_line() 
g = g + geom_smooth(se = FALSE, method = "loess")
g + aes( color = line )

first_plot = ggplot(aes(x = date, y = number, 
           color = line), 
       data = avg) 
first_plot = first_plot + geom_point(size = 0.5) 
first_plot = first_plot + geom_smooth(se = FALSE)

print(first_plot)
# 2. Replot 1a where the colors of the points are the
#	name of the route (with banner --> blue)
# pal = c("blue", "darkgreen","orange","purple")
# use (add + ) 	scale_colour_manual(values = pal)
pal = c("blue", "darkgreen","orange","purple")
first_plot + scale_color_manual(values = pal)

means = avg %>% 
  group_by(line) %>% 
  summarize(mean = mean(number),
            date = median(date))
first_plot + geom_point(aes(x = date, y = mean),
                        data = means, color = "black")
########################
# Part 2
########################
# 3. plot average ridership  by date with one panel per route
# use facet_wrap() or facet_grid() or (qplot): facets = ~line
fac_plot = first_plot + facet_wrap(~ line)
fac_plot 
fac_plot +
  geom_smooth(se = FALSE, color = "black")
first_plot + facet_wrap(~ line, 
                        scales = "free_x")

# 4. plot average ridership by date with separate panels
#		by day of the week, colored by route
# combine facets and color
first_plot + facet_grid(~ day)
first_plot + facet_wrap(~ day, scales = "free_y")

summ = avg %>% 
  group_by(line) %>% 
  slice(1)
first_plot + 
  geom_text(aes(label = line), 
            data  = summ,
            colour = "black")

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
first_plot + 
  xlab("Year") + 
  ylab("Number of People") +
  theme_bw() +
  theme(text = element_text(size = 20)) +
  guides( color = guide_legend(title = "Route"))
  
# 6. plot average ridership on the orange route versus date
#		as a solid line, and add dashed "error" lines based 
#		on the boardings and alightings. 
#	the line colors should be orange. 
# (hint linetype is an aesthetic for lines) - see also scale_linetype and 
# scale_linetype_manual
# Alightings = "dashed", Boardings = "dashed", Average = "solid"
orange = type_wide %>% 
  filter(line == "orange")
p = ggplot(aes(x = date ),  data = orange ) 
p = p + geom_line(aes(y = Alightings), linetype = "dashed")
p = p + geom_line(aes(y = Boardings), linetype = "dashed") 
p = p + geom_line(aes(y = Average), linetype = "solid") 

orange = long %>% 
  filter(line == "orange") %>% 
  filter(  !(day %in% c("Sunday", "Saturday")))
p = ggplot(aes(x = date, y = number,
               linetype = type),  data = orange ) 
p = p + geom_line()
p + scale_linetype_manual(values = c("dashed", "solid", "dashed"))
p + scale_linetype_manual(
  values = c(Boardings = "dashed", 
             Average = "solid", 
             Alightings = "dashed")) + 
  xlim(ymd("2012/01/01"), ymd("2013/01/01"))










