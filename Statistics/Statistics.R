## ----knit-setup, echo=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, 
               message = FALSE, 
               warning = FALSE,
               fig.height = 4,
               fig.width = 7, 
               comment = "")

## ----cor1, comment="", message = FALSE-----------------------------------
library(readr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
cor(circ$orangeAverage, circ$purpleAverage, use="complete.obs")

## ----cor2, comment=""----------------------------------------------------
library(dplyr)
avgs = circ %>% select(ends_with("Average"))
avgs_cor = cor(avgs, use = "complete.obs")
signif(avgs_cor,3)

## ----cor3, comment=""----------------------------------------------------
op = avgs %>% select(orangeAverage, purpleAverage)
gb = avgs %>% select(greenAverage, bannerAverage)
signif(cor(op, gb, use = "complete.obs"), 3)

## ----cor4, comment=""----------------------------------------------------
ct = cor.test(circ$orangeAverage, circ$purpleAverage, 
              use = "complete.obs")
ct

## ----cor5, comment=""----------------------------------------------------
# str(ct)
names(ct)
ct$statistic
ct$p.value

## ----broom, comment=""---------------------------------------------------
library(broom)
tidy_ct = tidy(ct)
tidy_ct

## ----cor_ggplot, comment="",  fig.height=4,fig.width=4-------------------
library(ggplot2)
txt = paste0("r=", signif(ct$estimate,3))
q = qplot(data = circ, x = orangeAverage, y = purpleAverage)
q + annotate("text", x = 4000, y = 8000, label = txt, size = 5)

## ----tt1, comment=""-----------------------------------------------------
tt = t.test(circ$orangeAverage, circ$purpleAverage)
tt

## ----tt1_1, comment=""---------------------------------------------------
names(tt)

## ----tt1_broom, comment=""-----------------------------------------------
tidy(tt)

## ----long_tt-------------------------------------------------------------
library(tidyr)
long = circ %>% 
  select(date, orangeAverage, purpleAverage) %>% 
  gather(key = line, value = avg, -date)
tt = t.test(avg ~ line, data = long)
tidy(tt)

## ----wt, comment=""------------------------------------------------------
tidy(wilcox.test(avg ~ line, data = long))

## ----regress1, comment=""------------------------------------------------
fit = lm(avg ~ line, data = long)
fit

## ----regress2, comment=""------------------------------------------------
sfit = summary(fit)
print(sfit)

## ----regress3, comment=""------------------------------------------------
names(sfit)
sfit$coef

## ----tidy_lm, comment=""-------------------------------------------------
tidy(fit)

## ----tt2, comment="", message = FALSE------------------------------------
http_data_dir = "http://johnmuschelli.com/intro_to_r/data/"
cars = read_csv(
  paste0(http_data_dir, "kaggleCarAuction.csv"),   
  col_types = cols(VehBCost = col_double()))

## ------------------------------------------------------------------------
fit = lm(VehOdo~VehicleAge, data = cars)
print(fit)

## ------------------------------------------------------------------------
cars %>% 
  ggplot(aes(x = VehicleAge, y = VehOdo)) + geom_point() + 
  geom_smooth(method = "lm")

## ----gg_regress, comment="", fig.height=4,fig.width=8--------------------
ggplot(aes(x = VehicleAge, y = VehOdo), data = cars) + 
  geom_jitter(alpha = 0.05, height = 0) + 
  geom_smooth(se = FALSE, method = "lm")

## ----regress5, comment="", fig.height=4,fig.width=8----------------------
fit2 = lm(VehOdo ~ IsBadBuy + VehicleAge, data = cars)
summary(fit2)  

## ----regress9, comment="", fig.height=4,fig.width=8----------------------
fit3 = lm(VehOdo ~ IsBadBuy * VehicleAge, data = cars)
summary(fit3)  

## ----regress10, comment="", fig.height=4,fig.width=8---------------------
fit4 = lm(VehOdo ~ IsBadBuy * VehicleAge -IsBadBuy , data = cars)
summary(fit4)  

## ----avplot, comment="", fig.height=4,fig.width=8------------------------
library(car)
avPlots(fit2)

## ----plot_lm, comment="", fig.height=4,fig.width=8-----------------------
par(mfrow=c(2,2))
plot(fit2, ask = FALSE)

## ----regress6, comment="", fig.height=4,fig.width=8----------------------
fit3 = lm(VehOdo ~ factor(TopThreeAmericanName), data = cars)
summary(fit3)  

## ----regress7, comment="", fig.height=4,fig.width=8----------------------
glmfit = glm(IsBadBuy ~ VehOdo + VehicleAge, data=cars, family = binomial())
summary(glmfit)  

## ----tidy_glmfit, comment="", fig.height=4,fig.width=8-------------------
tidy(glmfit, conf.int = TRUE)

## ----tidy_glm_exp, comment="", fig.height=4,fig.width=8------------------
tidy(glmfit, conf.int = TRUE, exponentiate = TRUE)

## ----regress8, comment="", fig.height=4,fig.width=8----------------------
exp(coef(glmfit))

## ----prop1, comment=""---------------------------------------------------
prop.test(x = 15, n =32)

## ----chisq1, comment=""--------------------------------------------------
tab = table(cars$IsBadBuy, cars$IsOnlineSale)
tab

## ----chisq2, comment=""--------------------------------------------------
cq = chisq.test(tab)
cq
names(cq)
cq$p.value

## ----chisq3, comment=""--------------------------------------------------
chisq.test(tab)
prop.test(tab)

## ----fish.test, comment=""-----------------------------------------------
fisher.test(tab)

## ----rnorm, comment=""---------------------------------------------------
rnorm(5)

## ----sample, comment=""--------------------------------------------------
sample(1:10, 5, replace=FALSE)

## ----samp_plot, comment="", fig.height=4,fig.width=7---------------------
samp.cars <- cars[ sample(nrow(cars), 10000), ]
samp.cars = dplyr::sample_n(cars, size = 10000)
samp.cars = dplyr::sample_frac(cars, size = 0.2)
ggplot(aes(x = VehBCost, y = VehOdo), 
       data = samp.cars) + geom_point() 

