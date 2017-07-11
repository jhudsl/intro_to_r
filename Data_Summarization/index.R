## ---- echo = FALSE, message=FALSE, error = FALSE-------------------------
library(knitr)
opts_chunk$set(comment = "", message = FALSE)
library(dplyr)
library(readr)

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
smoke = read_csv(
  "http://johnmuschelli.com/intro_to_r/data/Youth_Tobacco_Survey_YTS_Data.csv")
head(smoke)

## ---- message = FALSE----------------------------------------------------
unique(smoke$LocationDesc)[1:10]

## ------------------------------------------------------------------------
length(unique(smoke$LocationDesc))

## ---- message = FALSE----------------------------------------------------
table(smoke$LocationDesc)[1:5]

## ---- message=FALSE------------------------------------------------------
library(dplyr)
sub_smoke = filter(smoke, 
                   MeasureDesc == "Smoking Status",
                   Gender == "Overall",
                   Response == "Current")
sub_smoke = select(sub_smoke, YEAR, LocationDesc, Data_Value)
head(sub_smoke, 4)

## ------------------------------------------------------------------------
summarize(group_by(sub_smoke, YEAR), year_avg = mean(Data_Value, na.rm = TRUE))

## ------------------------------------------------------------------------
smoke_avgs = sub_smoke %>% 
  group_by(YEAR) %>% 
  summarize(year_avg = mean(Data_Value, na.rm = TRUE))
head(smoke_avgs)

## ------------------------------------------------------------------------
sub_smoke %>% 
  group_by(YEAR) %>% 
  summarize(n = n()) %>% 
  head
sub_smoke %>% 
  group_by(YEAR) %>% 
  tally() %>% 
  head

## ----scatter1------------------------------------------------------------
plot(mtcars$mpg, mtcars$disp)

## ----hist1---------------------------------------------------------------
hist(tb$before_2000_avg)

## ----hist_date-----------------------------------------------------------
plot(smoke_avgs$YEAR, smoke_avgs$year_avg, type = "l")

## ----dens1,fig.width=5,fig.height=5--------------------------------------
plot(density(sub_smoke$Data_Value))

## ----box1----------------------------------------------------------------
boxplot(sub_smoke$Data_Value ~ sub_smoke$LocationDesc)

## ----box2----------------------------------------------------------------
boxplot(Data_Value ~ LocationDesc, data = sub_smoke)

## ----matplot1------------------------------------------------------------
pairs(avgs)

