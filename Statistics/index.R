## ----knit-setup, echo=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, 
               message = FALSE, 
               warning = FALSE,
               fig.height = 4,
               fig.width = 7, 
               comment = "")

## ----cor1, comment="",prompt=TRUE, message = FALSE-----------------------
library(readr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
cor(circ$orangeAverage, circ$purpleAverage, use="complete.obs")

## ----cor2, comment="",prompt=TRUE----------------------------------------
library(dplyr)
avgs = circ %>% select(ends_with("Average"))
avgs_cor = cor(avgs, use = "complete.obs")
signif(avgs_cor,3)

## ----cor3, comment="",prompt=TRUE----------------------------------------
op = avgs %>% select(orangeAverage, purpleAverage)
gb = avgs %>% select(greenAverage, bannerAverage)
signif(cor(op, gb, use = "complete.obs"), 3)

## ----cor4, comment="",prompt=TRUE----------------------------------------
ct = cor.test(circ$orangeAverage, circ$purpleAverage, 
              use = "complete.obs")
ct

## ----cor5, comment="",prompt=TRUE----------------------------------------
# str(ct)
names(ct)
ct$statistic
ct$p.value

## ----broom, comment="",prompt=TRUE---------------------------------------
library(broom)
tidy_ct = tidy(ct)
tidy_ct

## ----cor4a, comment="", prompt=TRUE, fig.height=4,fig.width=4------------
txt = paste0("r=", signif(ct$estimate,3))
plot(circ$orangeAverage, circ$purpleAverage,
     xlab="Orange Line", ylab="Purple Line",
     main="Average Ridership",cex.axis=1.5,
     cex.lab=1.5,cex.main=2)
legend("topleft", txt, bty="n",cex=1.5)

## ----cor_ggplot, comment="", prompt=TRUE, fig.height=4,fig.width=4-------
library(ggplot2)
q = qplot(data = circ, x = orangeAverage, y = purpleAverage)
q + annotate("text", x = 4000, y = 8000, label = txt, size = 5)

## ----tt1, comment="",prompt=TRUE-----------------------------------------
tt = t.test(circ$orangeAverage, circ$purpleAverage)
tt

## ----tt1_1, comment="", prompt=TRUE--------------------------------------
names(tt)

## ----tt1_broom, comment="", prompt=TRUE----------------------------------
tidy(tt)

## ----long_tt-------------------------------------------------------------
library(tidyr)
long = circ %>% 
  select(date, orangeAverage, purpleAverage) %>% 
  gather(key = line, value = avg, -date)
tt = t.test(avg ~ line, data = long)
tidy(tt)

## ----wt, comment="",prompt=TRUE------------------------------------------
tidy(wilcox.test(avg ~ line, data = long))

## ----regress1, comment="",prompt=TRUE------------------------------------
fit = lm(avg ~ line, data = long)
fit

## ----regress2, comment="",prompt=TRUE------------------------------------
sfit = summary(fit)
print(sfit)

## ----regress3, comment="",prompt=TRUE------------------------------------
names(sfit)
sfit$coef

## ----tidy_lm, comment="",prompt=TRUE-------------------------------------
tidy(fit)

## ----tt2, comment="",prompt=TRUE, message = FALSE------------------------
http_data_dir = "http://johnmuschelli.com/intro_to_r/data/"
cars = read_csv(paste0(http_data_dir, "kaggleCarAuction.csv"))

## ------------------------------------------------------------------------
fit = lm(VehOdo~VehicleAge, data = cars)
print(fit)

## ----regress4, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
par(mfrow=c(1,2))
plot(VehOdo ~ jitter(VehicleAge,amount=0.2), data=cars, pch = 19,
     col = scales::alpha("black",0.05), xlab = "Vehicle Age (Yrs)")
abline(fit, col = "red",lwd=2)
legend("topleft", paste("p =",summary(fit)$coef[2,4]))
boxplot(VehOdo ~ VehicleAge, data=cars, varwidth=TRUE)
abline(fit, col="red",lwd=2)

## ----gg_regress, comment="",prompt=TRUE, fig.height=4,fig.width=8--------
g = ggplot(aes(x = VehicleAge, y = VehOdo), data = cars) + 
  geom_jitter(alpha = 0.05, height = 0) + 
  geom_smooth(se = FALSE, method = "lm")
print(g)

## ----regress5, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
fit2 = lm(VehOdo ~ IsBadBuy + VehicleAge, data = cars)
summary(fit2)  

## ----avplot, comment="",prompt=TRUE, fig.height=4,fig.width=8------------
library(car)
avPlots(fit2)

## ----plot_lm, comment="",prompt=TRUE, fig.height=4,fig.width=8-----------
par(mfrow=c(2,2))
plot(fit2, ask = FALSE)

## ----regress6, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
fit3 = lm(VehOdo ~ factor(TopThreeAmericanName), data = cars)
summary(fit3)  

## ----regress7, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
glmfit = glm(IsBadBuy ~ VehOdo + VehicleAge, data=cars, family = binomial())
summary(glmfit)  

## ----tidy_glm, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
tidy(glmfit)

## ----regress8, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
exp(coef(glmfit))

## ----prop1, comment="",prompt=TRUE---------------------------------------
prop.test(x = 15, n =32)

## ----chisq1, comment="",prompt=TRUE--------------------------------------
tab = table(cars$IsBadBuy, cars$IsOnlineSale)
tab

## ----chisq2, comment="",prompt=TRUE--------------------------------------
cq = chisq.test(tab)
cq
names(cq)
cq$p.value

## ----chisq3, comment="",prompt=TRUE--------------------------------------
chisq.test(tab)
prop.test(tab)

## ----fish.test, comment="",prompt=TRUE-----------------------------------
fisher.test(tab)

## ----rnorm, comment="",prompt=TRUE---------------------------------------
rnorm(5)

## ----sample, comment="",prompt=TRUE--------------------------------------
sample(1:10, 5, replace=FALSE)

## ----samp_plot, comment="",prompt=TRUE, fig.height=4,fig.width=4---------
samp.cars <- cars[ sample(nrow(cars), 10000), ]
samp.cars = dplyr::sample_n(cars, size = 10000)
samp.cars = dplyr::sample_frac(cars, size = 0.2)
ggplot(aes(x = VehBCost, y = VehOdo), 
       data = samp.cars) + geom_point() 

