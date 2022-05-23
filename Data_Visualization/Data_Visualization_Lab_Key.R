## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- message=FALSE-----------------------------------------------------------
library(readr)
library(ggplot2)
library(dplyr)
library(jhur)


## -----------------------------------------------------------------------------
bike = read_bike()

bike_agg <- 
  bike %>%
  # filter data to keep only these observations for which year is non-0
  filter(dateInstalled != 0) %>%
  group_by(dateInstalled) %>%
  summarise(lane_avg_length = mean(length)) 

bike_agg



## -----------------------------------------------------------------------------
ggplot(bike_agg, aes(x = dateInstalled, y = lane_avg_length)) + 
  geom_line() + 
  geom_point()

my_plot <- 
  ggplot(bike_agg, aes(x = dateInstalled, y = lane_avg_length)) + 
  geom_line() + 
  geom_point()

my_plot


## -----------------------------------------------------------------------------
my_plot <- 
  my_plot + 
  labs(x = "Year of bike lane installation",
       y = "Average bike lane length",
       title = "Average bike lane length 2006-2013")

my_plot


## -----------------------------------------------------------------------------
my_plot <- 
  my_plot + 
  scale_x_continuous(breaks = c(2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013)) + 
  scale_y_continuous(limits = c(0, NA))  # force y-axis to start from 0, do not force upper bound 
  
my_plot


## -----------------------------------------------------------------------------
my_plot + theme_bw()
my_plot + theme_classic()
my_plot + theme_dark()
my_plot + theme_gray()
my_plot + theme_void()


## -----------------------------------------------------------------------------
bike_agg_2 <- 
  bike %>%
  filter(dateInstalled != 0) %>%
  group_by(dateInstalled, type) %>%
  summarise(lane_count = n())

bike_agg_2


## -----------------------------------------------------------------------------
ggplot(bike_agg_2, aes(x = dateInstalled, y = lane_count, group = type, color = type)) + 
  geom_line() + 
  geom_point()


## -----------------------------------------------------------------------------
ggplot(bike_agg_2, aes(x = dateInstalled, y = lane_count, group = type, color = type)) + 
  geom_line() +
  geom_point() +
  facet_wrap(~ type, ncol = 3)

