### Data Visualization Lab

## you will need the charm city circulator dataset:
library(readr)
circ = read_csv("http://www.aejaffe.com/winterR_2017/data/Charm_City_Circulator_Ridership.csv")

# Using ggplot2:

# 1. plot average ridership  by date. (do not take an average, 
# use the average column for each route/line)
# 	a. Color the points by route (orange, purple, green, banner)
#	b. Color the points by day of the week

# 2. Replot 1a where the colors of the points are the
#	name of the route (with banner --> blue)

# 3. plot average ridership  by date with one panel per route

# 4. plot average ridership by date with separate panels
#		by day of the week, colored by route

# 5. plot average ridership on the orange route versus date
#		as a solid line, and add dashed "error" lines based 
#		on the boardings and alightings. 
#	the line colors should be orange. 
#(hint linetype is an aesthetic for lines) - see also scale_linetype and 
# scale_linetype_manual
