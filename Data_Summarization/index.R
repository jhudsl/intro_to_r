## ---- echo = FALSE, message=FALSE, error = FALSE-------------------------
library(knitr)
opts_chunk$set(comment = "", message = FALSE)
suppressWarnings({library(dplyr)})
library(readr)
library(tidyverse)
library(jhur)


## ------------------------------------------------------------------------
library(jhur)
head(jhu_cars)


## ------------------------------------------------------------------------
mean(jhu_cars$hp)
quantile(jhu_cars$hp)


## ------------------------------------------------------------------------
median(jhu_cars$wt)
quantile(jhu_cars$wt, probs = 0.6)


## ------------------------------------------------------------------------
t.test(jhu_cars$wt) 
broom::tidy(t.test(jhu_cars$wt))


## ------------------------------------------------------------------------
x = c(1,5,7,NA,4,2, 8,10,45,42)
mean(x)
mean(x, na.rm = TRUE)
quantile(x, na.rm = TRUE)


## ------------------------------------------------------------------------
library(readxl)
# tb <- read_excel("http://johnmuschelli.com/intro_to_r/data/tb_incidence.xlsx")
tb = jhur::read_tb()
colnames(tb)


## ------------------------------------------------------------------------
tb = jhur::read_tb()


## ------------------------------------------------------------------------
library(dplyr)
tb = rename(tb, 
            country = `TB incidence, all forms (per 100 000 population per year)`)


## ------------------------------------------------------------------------
colnames(tb)


## ----colMeans------------------------------------------------------------
avgs = select(tb, starts_with("1"))
colMeans(avgs, na.rm = TRUE)


## ------------------------------------------------------------------------
tb$before_2000_avg = rowMeans(avgs, na.rm = TRUE)
head(tb[, c("country", "before_2000_avg")])


## ------------------------------------------------------------------------
summarize_all(avgs, mean, na.rm = TRUE)


## ----summary1------------------------------------------------------------
summary(tb)


## ------------------------------------------------------------------------
yts = jhur::read_yts()
head(yts)


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


## ---- message = FALSE----------------------------------------------------
yts %>% count(LocationDesc)


## ---- message = FALSE----------------------------------------------------
yts %>% count(LocationDesc, Age)


## ---- message=FALSE------------------------------------------------------
library(dplyr)
sub_yts = filter(yts, MeasureDesc == "Smoking Status",
                 Gender == "Overall", Response == "Current",
                 Education == "Middle School")
sub_yts = select(sub_yts, YEAR, LocationDesc, Data_Value)
head(sub_yts, 4)


## ------------------------------------------------------------------------
sub_yts = group_by(sub_yts, YEAR)
head(sub_yts)


## ------------------------------------------------------------------------
summarize(sub_yts, year_avg = mean(Data_Value, na.rm = TRUE))


## ------------------------------------------------------------------------
sub_yts = ungroup(sub_yts)
sub_yts


## ------------------------------------------------------------------------
yts_avgs = sub_yts %>% 
  group_by(YEAR) %>% 
  summarize(year_avg = mean(Data_Value, na.rm = TRUE))
head(yts_avgs)


## ------------------------------------------------------------------------
sub_yts %>% 
  group_by(YEAR) %>% 
  mutate(year_avg = mean(Data_Value, na.rm = TRUE)) %>% 
  arrange(LocationDesc, YEAR)


## ------------------------------------------------------------------------
sub_yts %>% 
  group_by(YEAR) %>% 
  summarize(n = n()) %>% 
  head


## ------------------------------------------------------------------------
sub_yts %>% 
  group_by(YEAR) %>% 
  tally() %>% 
  head


## ---- eval = FALSE-------------------------------------------------------
## qplot

## ---- echo = FALSE-------------------------------------------------------
args(qplot)


## ------------------------------------------------------------------------
library(ggplot2)
qplot(x = disp, y = mpg, data = jhu_cars)


## ------------------------------------------------------------------------
qplot(x = before_2000_avg, data = tb, geom = "histogram")


## ------------------------------------------------------------------------
qplot(x = YEAR, y = year_avg, data = yts_avgs, geom = "line")


## ------------------------------------------------------------------------
qplot(x = Data_Value, data = sub_yts, geom = "density")


## ------------------------------------------------------------------------
qplot(x = LocationDesc, y = Data_Value, data = sub_yts, geom = "boxplot") 


## ------------------------------------------------------------------------
qplot(x = LocationDesc, y = Data_Value, 
      data = sub_yts, geom = "boxplot") + coord_flip()


## ----ggally_pairs, warning=FALSE, echo = FALSE---------------------------
library(GGally)
# ggpairs(avgs)


## ----matplot1------------------------------------------------------------
pairs(avgs)


## ----scatter1------------------------------------------------------------
plot(jhu_cars$mpg, jhu_cars$disp)


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


## ----apply1--------------------------------------------------------------
apply(avgs,2,mean, na.rm=TRUE) # column means
head(apply(avgs,1,mean, na.rm=TRUE)) # row means
apply(avgs,2,sd, na.rm=TRUE) # columns sds
apply(avgs,2,max, na.rm=TRUE) # column maxs

