## ---- echo = FALSE, message=FALSE, error = FALSE------------------------------
library(knitr)
opts_chunk$set(comment = "", message = FALSE)
suppressWarnings({library(dplyr)})
library(readr)
library(tidyverse)
library(jhur)


## -----------------------------------------------------------------------------
x <- c(1, 5, 7, 4, 2, 8)
mean(x)
range(x)
sum(x)


## ----error = TRUE-------------------------------------------------------------
x <- c(1, 5, 7, 4, 2, 8, NA)
mean(x)
mean(x, na.rm = TRUE)
quantile(x)
quantile(x, na.rm = TRUE)


## -----------------------------------------------------------------------------
library(jhur)
head(jhu_cars)


## -----------------------------------------------------------------------------
mean(jhu_cars$hp)
quantile(jhu_cars$hp)


## -----------------------------------------------------------------------------
jhu_cars %>% pull(hp) %>% mean() # alt: pull(jhu_cars, hp) %>% mean()
jhu_cars %>% pull(hp) %>% quantile()


## -----------------------------------------------------------------------------
jhu_cars %>% pull(wt) %>% median()
jhu_cars %>% pull(wt) %>% quantile(probs = 0.6)


## -----------------------------------------------------------------------------
tb <- jhur::read_tb()


## -----------------------------------------------------------------------------
head(tb)
colnames(tb)


## -----------------------------------------------------------------------------
library(dplyr)
tb <- tb %>% rename(country = `TB incidence, all forms (per 100 000 population per year)`)


## -----------------------------------------------------------------------------
colnames(tb)


## ---- eval = FALSE------------------------------------------------------------
## # General format - Not the code!
## {data object to update} <- {data to use} %>%
##                           summarize({summary column name} = {operator(source column)})


## -----------------------------------------------------------------------------
tb %>% summarize(mean_2006 = mean(`2006`, na.rm = TRUE))


## -----------------------------------------------------------------------------
tb %>% 
  summarize(mean_2006 = mean(`2006`, na.rm = TRUE),
            median_2007 = median(`2007`, na.rm = TRUE),
            median(`2004`, na.rm = TRUE))


## -----------------------------------------------------------------------------
tb %>% 
  summarize(across( c(`1990`, `1991`, `1992`, `1993`), ~ sum(.x, na.rm = TRUE)))
tb %>% 
  summarize(across( starts_with("2"), ~ range(.x, na.rm = TRUE)))


## -----------------------------------------------------------------------------
tb_2 <- column_to_rownames(tb, "country") # opposite of rownames_to_column() !
head(tb_2, 2)
rowMeans(tb_2, na.rm = TRUE)


## -----------------------------------------------------------------------------
colMeans(tb_2, na.rm = TRUE)
tb_2 %>% 
  summarize(across( colnames(tb_2), ~ mean(.x, na.rm = TRUE)))


## -----------------------------------------------------------------------------
summary(tb)


## -----------------------------------------------------------------------------
yts <- jhur::read_yts()
head(yts)


## ---- message = FALSE---------------------------------------------------------
locations <- yts %>% pull(LocationDesc)
unique(locations) %>% head()


## -----------------------------------------------------------------------------
length(unique(locations))


## ---- message = FALSE---------------------------------------------------------
table(locations)


## ---- message = FALSE---------------------------------------------------------
yts %>% count(LocationDesc)


## ---- message = FALSE---------------------------------------------------------
yts %>% count(LocationDesc, TopicDesc)


## -----------------------------------------------------------------------------
#
yts


## -----------------------------------------------------------------------------
yts <- yts %>% group_by(Response)
yts


## -----------------------------------------------------------------------------
yts %>% summarize(avg_percent = mean(Data_Value, na.rm = TRUE))


## -----------------------------------------------------------------------------
yts %>%
  group_by(Response) %>%
  summarize(avg_percent = mean(Data_Value, na.rm = TRUE),
            max_percent = max(Data_Value, na.rm = TRUE))


## -----------------------------------------------------------------------------
yts = ungroup(yts)
yts


## -----------------------------------------------------------------------------
yts %>%
  group_by(YEAR) %>%
  mutate(year_avg = mean(Data_Value, na.rm = TRUE)) %>%
  select(LocationDesc, Data_Value, year_avg)


## -----------------------------------------------------------------------------
yts %>%
  group_by(YEAR) %>%
  summarize(n = n(),
            mean = mean(Data_Value, na.rm = TRUE))


## -----------------------------------------------------------------------------
plot( pull(jhu_cars,hp), pull(jhu_cars,mpg) ) # alt: plot(jhu_cars$hp, jhu_cars$mpg)


## -----------------------------------------------------------------------------
boxplot( pull(jhu_cars,hp) ~ pull(jhu_cars,cyl) )


## -----------------------------------------------------------------------------
hist(pull(jhu_cars,mpg))


## -----------------------------------------------------------------------------
hist(pull(jhu_cars,mpg), breaks = 10)


## -----------------------------------------------------------------------------
plot(density(pull(jhu_cars,mpg)))

