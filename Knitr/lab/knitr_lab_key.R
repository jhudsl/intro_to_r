## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----reading-------------------------------------------------------------
library(readr)
smoke = read_csv("http://www.aejaffe.com/winterR_2017/data/Youth_Tobacco_Survey_YTS_Data.csv")

## ------------------------------------------------------------------------
table(smoke$MeasureDesc)

## ------------------------------------------------------------------------
library(dplyr)
sub_smoke = smoke %>% 
  filter(MeasureDesc == "Smoking Status",
         Gender == "Overall", 
         Response == "Frequent")

## ------------------------------------------------------------------------
nrow(sub_smoke)

## ------------------------------------------------------------------------
hist(sub_smoke$Data_Value)
boxplot(Data_Value ~ YEAR, data = sub_smoke)
plot(Data_Value ~ YEAR, data = sub_smoke)

## ------------------------------------------------------------------------
library(ggplot2)
g = ggplot(sub_smoke, aes(y = Data_Value, x = YEAR, colour = LocationDesc)) + 
  geom_line()
print(g)
g = g + guides(colour = FALSE)
print(g)

