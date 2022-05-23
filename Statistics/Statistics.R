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


## ----echo=FALSE---------------------------------------------------------------
coefs=lm(data=iris,Petal.Width~Petal.Length) %>%  coef

line_df=data.frame(x=c(0,7),y=c(coefs[1],(coefs[2]*7+coefs[1])))
riserun_df=data.frame(x=c(2.1,2.9,2.9),y=c((coefs[1]+coefs[2]*2.1),(coefs[1]+coefs[2]*2.1),(coefs[1]+coefs[2]*2.9)))
residual_df=data.frame(x=c(3,3),y=c(1.1,(coefs[1]+coefs[2]*3)))
labels_df=data.frame(x=c(0.5,3.2,2.7),y=c(coefs[1],0.65,1),labels=c("alpha","beta","epsilon[i]"))   
 
print(ggplot(data=iris,aes(x=Petal.Length,y=Petal.Width))+geom_point()+geom_line(data=line_df,aes(x=x,y=y))+
    geom_point(data=line_df[1,],aes(x=x,y=y,color="red",size=1.5))+
    geom_line(data=riserun_df,aes(x=x,y=y,color="orange",size=1.4))+
    geom_line(data=residual_df,aes(x=x,y=y,color="blue",size=1.4))+
    geom_label(data=labels_df,aes(x=x,y=y,label=labels,size=2),parse=TRUE)+
    theme_bw()+ylab(expression(y))+xlab(expression(x))+
    theme(legend.position="none",text=element_text(size=20)))



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

