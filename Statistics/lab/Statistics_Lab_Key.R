## ----setup, include=FALSE---------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- include = FALSE-------------------------------------------------
library(tidyverse)
library(broom)
library(jhur)
library(psych)


## ---------------------------------------------------------------------
mort = read_csv("https://jhudatascience.org/intro_to_r/data/infant_mortality.csv")


## ---------------------------------------------------------------------
mort = read_mortality()


## ---------------------------------------------------------------------
mort = mort %>% 
  rename(country = X1)


## ---------------------------------------------------------------------
colnames(mort)[1] = "country"


## ---------------------------------------------------------------------
sub = mort %>% 
  select(`1980`, `1990`, `2000`, `2010`)
cor(sub)
cor(sub, use = "complete.obs")
psych::corr.test(sub, use = "complete.obs")
psych::corr.test(sub)
cor(mort[,c("1980", "1990", "2000", "2010")])


## ---------------------------------------------------------------------
summary(mort[,c("1980", "1990", "2000", "2010")])


## ---------------------------------------------------------------------
cor(mort[,c("1980", "1990", "2000", "2010")], use = "complete.obs")
cor(mort %>% select("1980", "1990", "2000", "2010"), use = "complete.obs")


## ---------------------------------------------------------------------
mort_subs = mort %>% 
  filter(country %in% c( "China", "Myanmar","United States")) %>% 
  arrange(country)
long = mort_subs %>% 
  pivot_longer(!country, names_to = "year", values_to = "death") %>% 
  filter(!is.na(death))
long = long %>% 
  pivot_wider(names_from = "country", values_from = "death")
sub = long %>% 
  select(Myanmar, China, `United States`)
cor(sub)
mort_subs = mort_subs %>% 
  select(-country)
mort_subs = t(mort_subs)
country_cor = cor(mort_subs, 
                  use = "complete.obs")


## ---------------------------------------------------------------------
mort %>% filter(country %in% c("Myanmar", "China", "United States"))


## ---------------------------------------------------------------------
country_cor[1,3]


## ---------------------------------------------------------------------
t.test(mort$"1990", mort$"2000")
t.test(mort$`1990`, mort$`2000`)
t.test(mort$`1990`, mort$`2000`, paired = TRUE)
wilcox.test(mort$"1990", mort$"2000")
wilcox.test(mort$"1990", mort$"2000", paired = TRUE)


## ---------------------------------------------------------------------
cars = read_csv("http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv",
col_types = cols(VehBCost = col_double()))


## ---------------------------------------------------------------------
lmfit_cars = lm(VehBCost ~ VehicleAge + IsOnlineSale + VehicleAge*IsOnlineSale, data = cars)
lmfit_cars = lm(VehBCost ~ VehicleAge*IsOnlineSale, data = cars)
tidy(lmfit_cars)


## ---------------------------------------------------------------------
cars = cars %>%
mutate(expensive = VehBCost > 10000)
tab = table(cars$expensive, cars$IsBadBuy)
chisq.test(tab)
fisher.test(tab)
prop.test(tab)


## ---------------------------------------------------------------------
logfit_cars = glm(IsBadBuy ~ expensive + VehicleAge, data = cars, family = binomial)
logfit_cars = glm(IsBadBuy ~ expensive + VehicleAge, data = cars, family = binomial())
logfit_cars = glm(IsBadBuy ~ expensive + VehicleAge, data = cars, family = "binomial")
summary(logfit_cars)
tidy(logfit_cars, conf.int = TRUE, exponentiate = TRUE)
tidy(logfit_cars, conf.int = TRUE, exponentiate = FALSE)


## ---------------------------------------------------------------------
set.seed(1)
cars_subsample = cars %>% 
  sample_n(size = 10000)


## ---------------------------------------------------------------------
rows = sample(nrow(cars), size = 10000, replace = TRUE)
cars_subsample = cars[rows,]


## ---------------------------------------------------------------------
logfit_cars_sub = glm(IsBadBuy ~ expensive + VehicleAge, data = cars, family = binomial)
summary(logfit_cars_sub)
tidy(logfit_cars_sub, conf.int = TRUE, exponentiate = TRUE)

