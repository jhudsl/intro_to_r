## ---- echo = FALSE, message=FALSE---------------------------------------------
# library(dplyr)
suppressPackageStartupMessages(library(dplyr))
library(readr)
library(forcats)


## ----seq----------------------------------------------------------------------
seq(from = 1, to = 5) 
seq(from = 1, to = 5, by = 0.1) 


## ----logical0-----------------------------------------------------------------
x = c(TRUE, FALSE, TRUE, TRUE, FALSE)
class(x)
z = c("TRUE", "FALSE", "TRUE", "FALSE")
class(z)
as.logical(z)


## ----logical1-----------------------------------------------------------------
is.logical(c(TRUE, FALSE))
is.numeric(c(TRUE, FALSE))
as.numeric(c(TRUE, FALSE))
as.numeric(c("5", "0", "$0 "))
as.character(c(TRUE, FALSE))
as.integer(c(TRUE, FALSE))
as.logical(c(5, 0))


## ----factor1------------------------------------------------------------------
x = factor(c("boy", "girl", "girl", "boy", "girl"))
x 
class(x)

