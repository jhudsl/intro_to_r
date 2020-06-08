## ----setup, include=FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- message=FALSE---------------------------------------------------------------
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
library(jhur)


## ---------------------------------------------------------------------------------
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
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


## ---------------------------------------------------------------------------------
long = read_circulator_long()


## ---------------------------------------------------------------------------------
## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))

# separate
type_wide = spread(long, type, value = number)
head(type_wide)


## ---------------------------------------------------------------------------------
q = qplot(x = date, y = number, data = avg)
q + xlim(ymd("2011/05/03", "2012/06/04"))

g = ggplot(avg, aes(x = date, y = number))
g + geom_point()
g + geom_point() + xlim(ymd("2011/05/03", "2012/06/04"))




## ---------------------------------------------------------------------------------
qplot(x = date, y = number, data = avg, colour = line)

first_plot = qplot(x = date, y = number, data = avg, colour = line)
print(first_plot)


g = ggplot(avg, aes(x = date, y = number, color = line))
g + geom_point()



## ---------------------------------------------------------------------------------
qplot(x = date, y = number, data = avg, colour = line) + geom_smooth(aes(group = line), colour= "black")

qplot(x = date, y = number, data = avg, colour = line) + geom_smooth()

g + geom_point() + geom_smooth(color="black")

g + geom_point() + geom_smooth()




## ---------------------------------------------------------------------------------
qplot(x = date, y = number, data = avg, colour = day)
qplot(x = date, y = number, data = avg, colour = line) + geom_smooth()

avg = avg %>% mutate(dayFactor = factor(day, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")))
g = ggplot(avg, aes(x = date, y = number, color = dayFactor))
g + geom_point()



## ---------------------------------------------------------------------------------
pal = c(banner = "blue", purple = "purple", green=  "darkgreen", orange = "orange")
qplot(x = date, y = number, data = avg, colour = line) +
	  scale_colour_manual(values = pal)

g = ggplot(avg, aes(x = date, y = number, color = line))
g + geom_point() + scale_colour_manual(values = pal)



## ---------------------------------------------------------------------------------
qplot(x = date, y = number, data= avg, facets = ~line) 
qplot(x = date, y = number, data= avg) +
  facet_wrap( ~ line)

qplot(x = date, y = number, data= avg) +
  facet_wrap( ~ line, ncol =4)

qplot(x = date, y = number, data= avg, facets = ~line,	colour = line) +  scale_colour_manual(values=pal)

g = ggplot(avg, aes(x = date, y = number, color = line))
g + geom_point() +  facet_wrap( ~ line) + scale_colour_manual(values=pal)



## ---------------------------------------------------------------------------------
qplot(x = date, y = number, data= avg, facets = ~day,
	colour = line) +  scale_colour_manual(values=pal)

ggplot(aes(x = date, y = number, colour = line), data= avg) + 
  geom_point() + 
  facet_wrap( ~day) +  scale_colour_manual(values=pal)


## ---------------------------------------------------------------------------------
first_plot = ggplot(avg, aes(x = date, y = number, color = line)) + geom_point() + scale_colour_manual(values=pal)


first_plot  +
  xlab("Year") + ylab("Number of People") + theme_bw() + 
  theme(text = element_text(size = 20))


## ---------------------------------------------------------------------------------
orange = long %>% filter(line == "orange")


## ---------------------------------------------------------------------------------
ggplot(orange, aes(x = date, y = number)) + 
  geom_line(linetype = "dashed", colour ="orange")


## ---------------------------------------------------------------------------------
ggplot(orange, aes(x = date, y = number)) + 
  geom_line(linetype = "dashed", aes(colour="orange"))


## ---------------------------------------------------------------------------------
ggplot(orange, aes(x = date, y = number)) + 
  geom_line(aes(linetype = type), colour = "orange")


## ---------------------------------------------------------------------------------
qplot(data = orange, x = date, y = number,
      linetype = type, geom = "line", colour = "orange")

ggplot(orange, aes(x = date, y = number)) + 
  geom_line(aes(linetype = type), colour = "orange") + 
  scale_linetype_manual(values = c("dashed",
              "dashed", "solid"))


## ---------------------------------------------------------------------------------
ggplot(orange, aes(x = date, y = number)) + 
  geom_line(aes(linetype = type), colour = "orange") + 
  scale_linetype_manual(
      values = c(Alightings = "dashed",
             Boardings = "dashed", 
             Average = "solid"))

