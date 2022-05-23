## -----------------------------------------------------------------------------
library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)
library(jhur)


## -----------------------------------------------------------------------------
int_vect <- rep(seq(1, 10), 3)


## -----------------------------------------------------------------------------
set.seed(1234)
rand_vect <- sample( 1:30, size = 30, replace = TRUE)


## -----------------------------------------------------------------------------
TF_vect <- rep(c(TRUE, TRUE, FALSE), times = 10)
TF_vect2 <- rep(c("TRUE", "TRUE", "FALSE"), times = 10)


## -----------------------------------------------------------------------------
vect_data <- tibble(int_vect, rand_vect, TF_vect, TF_vect2)


## -----------------------------------------------------------------------------
slice_sample(vect_data, n = 5)
slice_sample(vect_data, n = 5)
slice_sample(vect_data, n = 5)


## -----------------------------------------------------------------------------
is.logical(TF_vect)
is.logical(TF_vect2)


## -----------------------------------------------------------------------------
vect_data <- mutate(vect_data, type_fact = factor(int_vect))
vect_data


## -----------------------------------------------------------------------------
circ = read_circulator()
str(circ)


## -----------------------------------------------------------------------------
circ <- mutate(circ, date_formatted = mdy(date))


## -----------------------------------------------------------------------------
circ <- circ %>% relocate(date_formatted, .before = date)
glimpse(circ)


## -----------------------------------------------------------------------------
classes_data <-list(vect_data, circ)
glimpse(classes_data)


## -----------------------------------------------------------------------------
range(circ$date_formatted)
range(circ$date)


## -----------------------------------------------------------------------------
circ  %>%
  group_by(day) %>% 
  summarize(n = sum(orangeBoardings, na.rm = TRUE))

circ  %>%
  group_by(day) %>% 
  summarize(n = sum(purpleBoardings, na.rm = TRUE))

circ  %>%
  group_by(day) %>% 
  summarize(n = sum(greenBoardings, na.rm = TRUE))

circ  %>%
  group_by(day) %>% 
  summarize(n = sum(bannerBoardings, na.rm = TRUE))

