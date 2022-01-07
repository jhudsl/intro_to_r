## ----knit-setup, include=FALSE------------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, 
               message = FALSE, 
               warning = FALSE,
               fig.height = 4,
               fig.width = 7, 
               comment = "")
library(dplyr)
options(scipen=999)



## ----cor1, comment="", message = FALSE----------------------------------------
library(readr)
circ = read_csv(paste0("https://jhudatascience.org/intro_to_R_class/data",
                       "/Charm_City_Circulator_Ridership.csv"))
head(circ)


## -----------------------------------------------------------------------------
cor(circ$orangeAverage, circ$purpleAverage)
cor(circ$orangeAverage, circ$purpleAverage, use = "complete.obs")


## ---- fig.width=3, fig.height=3-----------------------------------------------
cor_val = cor(circ$orangeAverage, circ$purpleAverage, use = "complete.obs")
cor_val_label <- paste0("r = ", round(cor_val, 3))

library(ggplot2)
ggplot(circ, aes(x = orangeAverage, y = purpleAverage)) + 
  geom_point(size = 0.3) + 
  annotate("text", x = 2000, y = 7500, label = cor_val_label, size = 5)


## -----------------------------------------------------------------------------
circ_subset_Average <- circ %>% select(ends_with("Average"))
dim(circ_subset_Average)

cor_mat <- cor(circ_subset_Average, use = "complete.obs")
cor_mat


## ---- fig.width=4, fig.height=4-----------------------------------------------
library(corrplot)
corrplot(cor_mat, type = "upper", order = "hclust")


## -----------------------------------------------------------------------------
t.test(circ$orangeAverage)


## -----------------------------------------------------------------------------
t.test(circ$orangeAverage, circ$purpleAverage)


## -----------------------------------------------------------------------------
result <- t.test(circ$orangeAverage, circ$purpleAverage)
is.list(result)
names(result)
result$statistic
result$p.value


## ----broom, comment=""--------------------------------------------------------
library(broom)
result_tidy = tidy(result)
result_tidy


## -----------------------------------------------------------------------------
cars = read_csv(
  paste0("https://jhudatascience.org/intro_to_R_class/data/", 
         "kaggleCarAuction.csv"),   
  col_types = cols(VehBCost = col_double()))
head(cars)


## -----------------------------------------------------------------------------
fit = lm(VehOdo ~ VehicleAge, data = cars)
print(fit)


## -----------------------------------------------------------------------------
sfit = summary(fit)
print(sfit)


## -----------------------------------------------------------------------------
sfit$coefficients
sfit$r.squared


## -----------------------------------------------------------------------------
fit_2 = lm(VehOdo ~ VehicleAge + WarrantyCost, data = cars)
summary(fit_2)


## -----------------------------------------------------------------------------
table(cars$TopThreeAmericanName)


## ----regress6, comment="", fig.height=4,fig.width=8---------------------------
fit_3 = lm(VehOdo ~ factor(TopThreeAmericanName), data = cars)
summary(fit_3)


## ---- comment="", fig.height=4,fig.width=8------------------------------------
# tidy() is a function from broom package
fit_3_tidy = tidy(fit_3)
fit_3_tidy


## ----regress7, comment="", fig.height=4,fig.width=8---------------------------
glm_fit = glm(IsBadBuy ~ VehOdo + VehicleAge, data = cars, family = binomial())
summary(glm_fit)  

