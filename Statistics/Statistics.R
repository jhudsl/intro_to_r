## ----knit-setup, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, 
               message = FALSE, 
               warning = FALSE,
               fig.height = 4,
               fig.width = 7, 
               comment = "")
library(dplyr)


## ----cor1, comment="", message = FALSE----------------------------------------
library(readr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
cor(circ$orangeAverage, circ$purpleAverage, use="complete.obs")


## ----cor2, comment="", message = TRUE-----------------------------------------
library(corrr); library(dplyr)
circ %>% 
  select(orangeAverage, purpleAverage) %>% 
  correlate()


## ----cor3, comment=""---------------------------------------------------------
avgs = circ %>% select(ends_with("Average"))
cobj = avgs %>% correlate(use = "complete.obs", diagonal = 1)
cobj %>% fashion(decimals = 3)


## ----corplot, comment=""------------------------------------------------------
cobj %>% rplot()


## ----cor4, comment=""---------------------------------------------------------
ct = cor.test(circ$orangeAverage, circ$purpleAverage, 
              use = "complete.obs")
ct


## ----cor5, comment=""---------------------------------------------------------
# str(ct)
names(ct)
ct$statistic
ct$p.value


## ----broom, comment=""--------------------------------------------------------
library(broom)
tidy_ct = tidy(ct)
tidy_ct


## ----cor_ggplot, comment="",  fig.height=4,fig.width=4------------------------
library(ggplot2)
txt = paste0("r=", signif(ct$estimate,3))
q = qplot(data = circ, x = orangeAverage, y = purpleAverage)
q + annotate("text", x = 4000, y = 8000, label = txt, size = 5)


## ----tt1, comment=""----------------------------------------------------------
tt = t.test(circ$orangeAverage, circ$purpleAverage)
tt


## ----tt1_paired, comment=""---------------------------------------------------
t.test(circ$orangeAverage, circ$purpleAverage, paired = TRUE)


## ----tt1_1, comment=""--------------------------------------------------------
names(tt)


## ----tt1_broom, comment=""----------------------------------------------------
tidy(tt)


## ----long_tt------------------------------------------------------------------
library(tidyr)
long = circ %>% 
  select(date, orangeAverage, purpleAverage) %>% 
  gather(key = line, value = avg, -date)
tt = t.test(avg ~ line, data = long)
tidy(tt)


## ----wt, comment=""-----------------------------------------------------------
tidy(wilcox.test(avg ~ line, data = long))


## ----aov, comment=""----------------------------------------------------------
long3 = circ %>% 
  select(date, orangeAverage, purpleAverage, bannerAverage) %>% 
  gather(key = line, value = avg, -date)
anova_res = aov(avg ~ line, data = long3)
anova_res


## ----regress1, comment=""-----------------------------------------------------
fit = lm(avg ~ line, data = long)
fit


## ----regress1000, comment=""--------------------------------------------------
fit = lm(avg ~ line, data = long3)
fit


## ----regress2, comment=""-----------------------------------------------------
sfit = summary(fit)
print(sfit)


## ----tidy_lm, comment=""------------------------------------------------------
tidy(fit)


## ----tidy_lm_onf, comment=""--------------------------------------------------
tidy(fit, conf.int = TRUE)


## ----tt2, comment="", message = FALSE-----------------------------------------
http_data_dir = "http://johnmuschelli.com/intro_to_r/data/"
cars = read_csv(
  paste0(http_data_dir, "kaggleCarAuction.csv"),   
  col_types = cols(VehBCost = col_double()))
head(cars)


## -----------------------------------------------------------------------------
fit = lm(VehOdo~VehicleAge, data = cars)
print(fit)


## ----regress5, comment="", fig.height=4,fig.width=8---------------------------
fit2 = lm(VehOdo ~ IsBadBuy + VehicleAge, data = cars)
tidy(fit2)  


## ----regress9, comment="", fig.height=4,fig.width=8---------------------------
fit3 = lm(VehOdo ~ IsBadBuy * VehicleAge, data = cars)
tidy(fit3)  


## ----regress10, comment="", fig.height=4,fig.width=8--------------------------
fit4 = lm(VehOdo ~ IsBadBuy * VehicleAge -IsBadBuy , data = cars)
tidy(fit4)  


## ----regress6, comment="", fig.height=4,fig.width=8---------------------------
fit3 = lm(VehOdo ~ factor(TopThreeAmericanName), data = cars)
tidy(fit3)  


## ----regress7, comment="", fig.height=4,fig.width=8---------------------------
glmfit = glm(IsBadBuy ~ VehOdo + VehicleAge, data=cars, family = binomial())
tidy(glmfit)  


## ----tidy_glmfit, comment="", fig.height=4,fig.width=8------------------------
tidy(glmfit, conf.int = TRUE)


## ----tidy_glm_exp, comment="", fig.height=4,fig.width=8-----------------------
tidy(glmfit, conf.int = TRUE, exponentiate = TRUE)


## ----regress8, comment="", fig.height=4,fig.width=8---------------------------
exp(coef(glmfit))


## ----chisq1, comment=""-------------------------------------------------------
tab = table(cars$IsBadBuy, cars$IsOnlineSale)
tab


## ----chisq2, comment=""-------------------------------------------------------
cq = chisq.test(tab)
cq
names(cq)
cq$p.value


## ----chisq3, comment=""-------------------------------------------------------
chisq.test(tab)
prop.test(tab)


## ----fish.test, comment=""----------------------------------------------------
fisher.test(tab)


## ----samp_plot, comment="", fig.height=4,fig.width=7--------------------------
samp.cars = sample_n(cars, size = 10000)
samp.cars = sample_frac(cars, size = 0.2)
ggplot(aes(x = VehBCost, y = VehOdo), 
       data = samp.cars) + geom_point() 

