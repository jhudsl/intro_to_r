### Data Visualization Lab

## you will need the charm city circulator dataset:
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)

circ = read_csv("http://www.aejaffe.com/winterR_2017/data/Charm_City_Circulator_Ridership.csv")

# read in data

# covert dates
circ = mutate(circ, date = mdy(date))
# change colnames for reshaping
colnames(circ) =  colnames(circ) %>% 
  str_replace("Board", ".Board") %>% 
  str_replace("Alight", ".Alight") %>% 
  str_replace("Average", ".Average") 
circ$daily = NULL # remove

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

# Using ggplot2:

# 1. plot average ridership  by date.
# 	a. Color the points by route (orange, purple, green, banner)
qplot(x = date, y = number, data = avg, colour = line)

#	b. Color the points by day of the week
qplot(x = date, y = number, data = avg, colour = day)
		 
# 2. Replot 1a where the colors of the points are the
#	name of the route (with banner --> blue)
pal = c("blue", "darkgreen","orange","purple")
qplot(x = date, y = number, data = avg, colour = line) +
	  scale_colour_manual(values = pal)

# 3. plot average ridership by date with one panel per route
qplot(x = date, y = number, data= avg, facets = ~line) 
qplot(x = date, y = number, data= avg) +
  facet_wrap( ~ line)

qplot(x = date, y = number, data= avg, facets = ~line,
	colour = line) +  scale_colour_manual(values=pal)
	  
# 4. plot average ridership by date with separate panels
#		by day of the week, colored by route
qplot(x = date, y = number, data= avg, facets = ~day,
	colour = line) +  scale_colour_manual(values=pal)
	  
# 5. plot average ridership on the orange route versus date
#		as a solid line, and add dashed "error" lines based 
#		on the boardings and alightings. 
#	the line colors should be orange.
orange = long %>% filter(line == "orange")
g = ggplot(orange, aes(x = date, y = number)) + 
  geom_line(aes(linetype = type))
g
qplot(data = orange, x = date, y = number,
      linetype = type, geom = "line")

g + scale_linetype_manual(
  values = c(Alightings = "dashed",
             Boardings = "dashed", 
             Average = "solid"))

g + scale_linetype_manual(
  values = c("dashed", "dashed", "solid"))


orange = circ[,c(1:2, grep("orange", colnames(circ)))]
plot(orange.Average ~ date, data =orange,
	col="orange", type="l", subset=1:100)
lines(orange.Alightings ~ date, data =orange,
	col="orange", type="l", lty=2)
lines(orange.Boardings ~ date, data =orange,
	col="orange", type="l", lty=2)
