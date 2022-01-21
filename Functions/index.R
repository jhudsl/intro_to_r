## ---- echo = FALSE, message = FALSE-------------------------------------------
library(dplyr)
library(jhur)
library(knitr)
library(stringr)
library(tidyr)
library(emo)
opts_chunk$set(comment = "")


## ----comment=""---------------------------------------------------------------
times_2 <- function(x) x * 2


## ----comment=""---------------------------------------------------------------
times_2(x = 10)


## ----comment=""---------------------------------------------------------------
times_2 <- function(x) {
  x * 2
}
times_2(x = 10)


## ----comment=""---------------------------------------------------------------
times_2 <- function(x) {
  output <- x * 2
  return(output)
}
times_2(x = 10)


## ----comment=""---------------------------------------------------------------
times_2_plus_y <- function(x, y) x * 2 + y
times_2_plus_y(x = 10, y = 3)


## ----comment=""---------------------------------------------------------------
times_2_plus_y <- function(x = 10, y = 3) x * 2 + y
times_2_plus_y()


## ----comment=""---------------------------------------------------------------
sqdif <- function(x = 2, y = 3) (x - y) ^ 2

sqdif()
sqdif(x = 10, y = 5)
sqdif(10, 5)


## ----comment=""---------------------------------------------------------------
loud <- function(word) {
  output <- rep( toupper(word), 5)
  return(output)
}
loud("hooray!")


## ----message=FALSE------------------------------------------------------------
cars <- read_kaggle()

get_row <- function(dat, row) dat %>% filter(row_number()==row)


## ----echo=FALSE---------------------------------------------------------------
# So extra columns don't clutter the slide
cars <- cars %>% select(1:10)


## -----------------------------------------------------------------------------
get_row(dat = cars, row = 10)


## ----echo=FALSE---------------------------------------------------------------
# Restore dataset
cars <- read_kaggle()


## ----message=FALSE------------------------------------------------------------
get_index <- function(dat, row, col){
 dat %>% filter(row_number()==row) %>% select(col) 
}

get_index(dat = cars, row = 10, col = 8)


## ----message=FALSE------------------------------------------------------------
get_top <- function(dat, row = 1, col = 1){
 dat %>% filter(row_number()==row) %>% select(col) 
}

get_top(dat = cars)


## ----comment=""---------------------------------------------------------------
sapply(cars, class)
sapply(pull(cars, VehOdo), log)


## ----comment=""---------------------------------------------------------------
sapply(pull(cars, VehOdo), function(x) x / 1000)


## -----------------------------------------------------------------------------
cars_dbl <- cars %>% select(Make, Model, where(is.double))

Odo_updated <- sapply(pull(cars_dbl, VehOdo), times_2_plus_y)

cars_dbl %>% 
  mutate(Odo_2_y = Odo_updated)


## ----warning=FALSE------------------------------------------------------------
cars_dbl %>% 
  group_by(Make) %>%
  summarize(across(.cols = everything(), .fns = mean))


## ----warning=FALSE------------------------------------------------------------
cars_dbl %>% 
  group_by(Make) %>%
  summarize(across(.cols = where(is.double), .fns = quantile, probs = 0.95))


## ----warning=FALSE------------------------------------------------------------
cars_dbl %>% 
  group_by(Make) %>%
  summarize(across(.cols = starts_with("Veh"), .fns = mean))


## -----------------------------------------------------------------------------
cars_dbl %>% 
  mutate(across(.cols = starts_with("Veh"), .fns = round, digits = -3))


## -----------------------------------------------------------------------------
cars_dbl %>% 
  mutate(across(.cols = everything(), 
                .fns = str_replace_all, 
                pattern = "A",
                replacement = "a"))


## ----warning=FALSE, message=FALSE---------------------------------------------
# Child mortality data
mort <- read_mortality() %>% rename(country = `...1`)

mort %>% 
  select(country, starts_with("194")) %>% 
  mutate(across(.cols = c(`1943`, `1944`, `1945`),
                .fns = replace_na,
                replace = 0))

