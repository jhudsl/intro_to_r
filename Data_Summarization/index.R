## ---- echo = FALSE, message=FALSE, error = FALSE-------------------------
library(knitr)
opts_chunk$set(comment = "", message = FALSE)
suppressWarnings({library(dplyr)})
library(readr)
library(tidyverse)

## ------------------------------------------------------------------------
head(mtcars)

## ------------------------------------------------------------------------
mean(mtcars$hp)
quantile(mtcars$hp)

## ------------------------------------------------------------------------
median(mtcars$wt)
quantile(mtcars$wt, probs = 0.6)

## ------------------------------------------------------------------------
t.test(mtcars$wt) 

## ------------------------------------------------------------------------
x = c(1,5,7,NA,4,2, 8,10,45,42)
mean(x)
mean(x, na.rm = TRUE)
quantile(x, na.rm = TRUE)

## ------------------------------------------------------------------------
library(readxl)
tb <- read_excel("../data/tb_incidence.xlsx")
head(tb)

## ------------------------------------------------------------------------
library(dplyr)
tb = rename(tb, 
            country = `TB incidence, all forms (per 100 000 population per year)`)

## ------------------------------------------------------------------------
colnames(tb)

## ----colMeans------------------------------------------------------------
avgs = select(tb, starts_with("1"))
colMeans(avgs, na.rm = TRUE)
tb$before_2000_avg = rowMeans(avgs, na.rm = TRUE)
head(tb[, c("country", "before_2000_avg")])

## ----summary1------------------------------------------------------------
summary(tb)

## ----apply1--------------------------------------------------------------
apply(avgs,2,mean,na.rm=TRUE) # column means
apply(avgs,2,sd,na.rm=TRUE) # columns sds
apply(avgs,2,max,na.rm=TRUE) # column maxs

## ---- message = FALSE----------------------------------------------------
library(readr)
yts = read_csv(
  "http://johnmuschelli.com/intro_to_r/data/Youth_Tobacco_Survey_YTS_Data.csv")
head(yts)

## ---- message = FALSE----------------------------------------------------
unique(yts$LocationDesc)[1:10]

## ------------------------------------------------------------------------
length(unique(yts$LocationDesc))

## ---- message = FALSE----------------------------------------------------
table(yts$LocationDesc)[1:5]

## ---- message=FALSE------------------------------------------------------
library(dplyr)
sub_yts = filter(yts, 
                   MeasureDesc == "Smoking Status",
                   Gender == "Overall",
                   Response == "Current")
sub_yts = select(sub_yts, YEAR, LocationDesc, Data_Value)
head(sub_yts, 4)

## ------------------------------------------------------------------------
summarize(group_by(sub_yts, YEAR), year_avg = mean(Data_Value, na.rm = TRUE))

## ------------------------------------------------------------------------
yts_avgs = sub_yts %>% 
  group_by(YEAR) %>% 
  summarize(year_avg = mean(Data_Value, na.rm = TRUE))
head(yts_avgs)

## ------------------------------------------------------------------------
sub_yts %>% 
  group_by(YEAR) %>% 
  summarize(n = n()) %>% 
  head
sub_yts %>% 
  group_by(YEAR) %>% 
  tally() %>% 
  head

## ------------------------------------------------------------------------
qplot

## ------------------------------------------------------------------------
library(ggplot2)
qplot(x = disp, y = mpg, data = mtcars)

## ------------------------------------------------------------------------
qplot(x = before_2000_avg, data = tb, geom = "histogram")

## ------------------------------------------------------------------------
qplot(x = YEAR, y = year_avg, data = yts_avgs, geom = "line")

## ------------------------------------------------------------------------
qplot(x = Data_Value, data = sub_yts, geom = "density")

## ------------------------------------------------------------------------
qplot(x = LocationDesc, y = Data_Value, data = sub_yts, geom = "boxplot")

## ----ggally_pairs--------------------------------------------------------
library(GGally)
ggpairs(avgs)

## ----matplot1------------------------------------------------------------
pairs(avgs)

## ----scatter1------------------------------------------------------------
plot(mtcars$mpg, mtcars$disp)

## ----hist1---------------------------------------------------------------
hist(tb$before_2000_avg)

## ----hist_date-----------------------------------------------------------
plot(yts_avgs$YEAR, yts_avgs$year_avg, type = "l")

## ----dens1,fig.width=5,fig.height=5--------------------------------------
plot(density(sub_yts$Data_Value))

## ----box1----------------------------------------------------------------
boxplot(sub_yts$Data_Value ~ sub_yts$LocationDesc)

## ----box2----------------------------------------------------------------
boxplot(Data_Value ~ LocationDesc, data = sub_yts)

## ----matplot2------------------------------------------------------------
pairs(avgs)

