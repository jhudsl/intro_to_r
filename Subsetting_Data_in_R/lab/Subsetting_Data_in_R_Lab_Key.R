## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- message = FALSE---------------------------------------------------------
# don't forget to load the packages that you will need!
library(dplyr)
library(tidyverse)
library(jhur)


## -----------------------------------------------------------------------------
mtcars


## -----------------------------------------------------------------------------
class(mtcars)


## -----------------------------------------------------------------------------
dim(mtcars)
nrow(mtcars)
ncol(mtcars)


## -----------------------------------------------------------------------------
cars_mt_copy <- mtcars
cars_mt_copy <- rename(cars_mt_copy, MPG = mpg)
head(cars_mt_copy)


## -----------------------------------------------------------------------------
cars_mt_copy <- rename_all(cars_mt_copy, toupper)
head(cars_mt_copy)
dim(cars_mt_copy)


## -----------------------------------------------------------------------------
head(cars_mt_copy, 3)
tail(cars_mt_copy, 3)


## -----------------------------------------------------------------------------
cars_mt_copy <- rownames_to_column(cars_mt_copy, var = "CAR")
head(cars_mt_copy)
cars_mt_copy <-tibble(cars_mt_copy)
cars_mt_copy


## -----------------------------------------------------------------------------
pvars <- select(cars_mt_copy, CAR, ends_with("P"))
pvars


## -----------------------------------------------------------------------------
carsSub <- select(cars_mt_copy,CAR, WT, QSEC, HP)
carsSub



## -----------------------------------------------------------------------------
carsSub <- rename_all(carsSub, tolower)
carsSub



## -----------------------------------------------------------------------------
pull(carsSub, car)
select(carsSub, car)


## -----------------------------------------------------------------------------
select(cars_mt_copy, contains("a"))


## -----------------------------------------------------------------------------
cars_mpg <- filter(cars_mt_copy, MPG > 20)
dim(cars_mpg)
nrow(cars_mpg)
cars_mpg


## -----------------------------------------------------------------------------
filter(cars_mt_copy, MPG < 16 & HP > 150)
nrow(filter(cars_mt_copy, MPG < 16 & HP > 150))
nrow(filter(cars_mt_copy, MPG < 16, HP >  150))
cars_mt_copy %>% filter(MPG < 16, HP >  150) %>% nrow()


## -----------------------------------------------------------------------------
filter(cars_mt_copy, MPG < 16 & HP >= 150)
nrow(filter(cars_mt_copy, MPG < 16 & HP >= 150))
nrow(filter(cars_mt_copy, MPG < 16, HP >=  150))
cars_mt_copy %>% filter(MPG < 16, HP >=  150) %>% nrow()


## -----------------------------------------------------------------------------
filter(cars_mt_copy, CYL == 4 | WT < 1.9)
nrow(filter(cars_mt_copy, CYL == 4 & WT < 1.9))


## -----------------------------------------------------------------------------
carsSub <- filter(cars_mt_copy, CYL == 8) 
carsSub <- select(carsSub, CAR, WT, QSEC, HP)
carsSub # can get dimensions just from viewing the tibble
dim(carsSub) # alternatively can use dim() function


## -----------------------------------------------------------------------------
carsSub <- cars_mt_copy %>% 
  filter(CYL == 8) %>% 
  select(CAR, WT, QSEC, HP)
carsSub
dim(carsSub)


## ---- eval = FALSE------------------------------------------------------------
## carsSub <- cars_mt_copy %>%
##   select(CAR, WT, QSEC, HP) %>%
##   filter(CYL == 8)
## 


## -----------------------------------------------------------------------------
carsSub <- arrange(carsSub, WT)
carsSub
pull(carsSub, CAR) %>% last()
last(carsSub$CAR) # alternatively without pipes


## -----------------------------------------------------------------------------
carsSub <- carsSub %>% mutate(WT2 = WT^2)


## -----------------------------------------------------------------------------

carsSub <- carsSub %>% relocate(WT2, .before = CAR)
carsSub


## -----------------------------------------------------------------------------
carsSub %>% 
  filter(CAR == "Cadillac Fleetwood") %>%
  select(WT2)


