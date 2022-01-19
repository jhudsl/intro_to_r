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
library(readr)
library(ggplot2)


## ----cor1, comment="", message = FALSE----------------------------------------
circ <- jhur::read_circulator()
head(circ)


## -----------------------------------------------------------------------------
x <- pull(circ, orangeAverage)
y <- pull(circ, purpleAverage)


## -----------------------------------------------------------------------------
cor(x, y)
cor(x, y, use = "complete.obs")


## ---- fig.width=3, fig.height=3-----------------------------------------------
cor_val <- cor(x, y, use = "complete.obs")
cor_val_label <- paste0("r = ", round(cor_val, 3))

circ %>%
  ggplot(aes(x = orangeAverage, y = purpleAverage)) +
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
x <- pull(circ, orangeAverage)
t.test(x)


## -----------------------------------------------------------------------------
x <- pull(circ, orangeAverage)
y <- pull(circ, purpleAverage)
t.test(x, y)


## -----------------------------------------------------------------------------
result <- t.test(x, y)
is.list(result)
names(result)
result$statistic
result$p.value


## ----broom, comment=""--------------------------------------------------------
library(broom)

result <- t.test(x, y)
result_tidy <- tidy(result)
result_tidy


## -----------------------------------------------------------------------------
cars <- jhur::read_kaggle()
head(cars)


## -----------------------------------------------------------------------------
fit <- lm(VehOdo ~ VehicleAge, data = cars)
print(fit)


## -----------------------------------------------------------------------------
sfit <- summary(fit)
print(sfit)


## -----------------------------------------------------------------------------
# tidy() is a function from the broom package
tidy(sfit)


## -----------------------------------------------------------------------------
names(sfit)
sfit$r.squared


## -----------------------------------------------------------------------------
fit_2 <- lm(VehOdo ~ VehicleAge + WarrantyCost, data = cars)
summary(fit_2)


## -----------------------------------------------------------------------------
top_3 <- pull(cars, TopThreeAmericanName)
table(top_3)


## ----regress6, comment="", fig.height=4,fig.width=8---------------------------
fit_3 <- lm(VehOdo ~ factor(TopThreeAmericanName), data = cars)
summary(fit_3)


## ---- comment="", fig.height=4,fig.width=8------------------------------------
tidy(fit_3)


## ----regress7, comment="", fig.height=4,fig.width=8---------------------------
glm_fit <- glm(IsBadBuy ~ VehOdo + VehicleAge, data = cars, family = binomial())
summary(glm_fit)  

