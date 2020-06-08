## ----setup, include=FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(jhur)
library(ggplot2)
library(dplyr)

long = read_circulator_long()
## take just average ridership per day
avg = long %>% 
  filter(type == "Average")
# keep non-missing data
avg = avg %>% 
  filter(!is.na(number))


## ----plot_circ, out.width = "100%"------------------------------------------------
# keep only some days
avg = avg %>% 
  filter(day %in% c("Monday", "Tuesday", "Friday", "Saturday"))

palette = c(
  banner = "blue", 
  green = "darkgreen",
  orange = "orange",
  purple = "purple")

ggplot(aes(x = date, y = number, colour = line), data= avg) + 
  geom_line() + 
  facet_wrap( ~day) + 
  scale_colour_manual(values = palette)

