## ---- echo = FALSE, message=FALSE---------------------------------------------
# library(dplyr)
suppressPackageStartupMessages(library(dplyr))
library(readr)
library(forcats)


## ----numChar------------------------------------------------------------------
class(c("Andrew", "Jaffe"))
class(c(1, 4, 7))


## ----seq----------------------------------------------------------------------
x = seq(from = 1, to = 5) # seq() is a function
x
class(x)


## ----logical1-----------------------------------------------------------------
x = c(TRUE, FALSE, TRUE, TRUE, FALSE)
class(x)


## ----logical2-----------------------------------------------------------------
z = c("TRUE", "FALSE", "TRUE", "FALSE")
class(z)


## ----logical_coercion---------------------------------------------------------
is.numeric(c("Andrew", "Jaffe"))
is.character(c("Andrew", "Jaffe"))


## ----logical_coercion2--------------------------------------------------------
is.character(c(1, 4, 7))
is.numeric(c(1, 4, 7))


## ----logical_coercion3s-------------------------------------------------------
as.character(c(1, 4, 7))
as.numeric(c("1", "4", "7"))
as.logical(c("TRUE", "FALSE", "FALSE"))


## ----logical_coercions4-------------------------------------------------------
as.numeric(c("1", "4", "7a"))
as.logical(c("TRUE", "FALSE", "UNKNOWN"))
as.Date(c("2021-06-15", "2021-06-32"))


## ----factor1------------------------------------------------------------------
x <- c("red", "red", "blue", "yellow", "blue")
class(x)

x_fact = factor(x)  # factor() is a function
class(x_fact)
x_fact


## ----factor1b-----------------------------------------------------------------
levels(x_fact)


## ----factor3------------------------------------------------------------------
x_fact

as.character(x_fact)
as.numeric(x_fact)


## -----------------------------------------------------------------------------
rep(c("black", "white"), each = 3)
rep(c("black", "white"), times = 3)


## -----------------------------------------------------------------------------
seq(from = 0, to = 1, by = 0.2)
seq(from = -5, to = 5, length.out = 10)


## ---- message = FALSE---------------------------------------------------------
class("2021-06-15")

as.Date("2021-06-15")         # base R 
class(as.Date("2021-06-15"))  # base R 


## ---- message = FALSE---------------------------------------------------------
class("2021-06-15")

library(lubridate)

ymd("2021-06-15")             # lubridate package         
class(ymd("2021-06-15"))      # lubridate package    


## ---- error = TRUE------------------------------------------------------------
mdy("06/15/2021")  

mdy("06/15/21")  


## -----------------------------------------------------------------------------
class("2013-01-24 19:39:07")
ymd_hms("2013-01-24 19:39:07")             # lubridate package 
class(ymd_hms("2013-01-24 19:39:07"))      # lubridate package 


## -----------------------------------------------------------------------------
x <- ymd(c("2021-06-15", "2021-07-15"))
x
day(x)   # see also: month(x) , year(x)
x + days(10)
x + months(1) + days(10)
wday(x, label = TRUE)


## -----------------------------------------------------------------------------
x <- ymd_hms("2013-01-24 19:39:07")
x
date(x)
x + hours(3)
floor_date(x, "1 hour")  # see also: ceiling_date()


## -----------------------------------------------------------------------------
x1 <- ymd(c("2021-06-15"))
x2 <- ymd(c("2021-07-15"))

difftime(x2, x1, units = "weeks")
as.numeric(difftime(x2, x1, units = "weeks"))


## -----------------------------------------------------------------------------
x <- c("a", "b", "c", "d", "e", "f", "g", "h")
x
x[2]
x[c(1, 2, 100)]


## -----------------------------------------------------------------------------
x <- c("a", "b", "c", "d", "e", "f", "g", "h")
x_long <- rep(x, times = 20)
x_long
x


## ----matrix-------------------------------------------------------------------
n = 1:9 
n
mat = matrix(n, nrow = 3)
mat


## ----subset3------------------------------------------------------------------
mat[1, 1] # individual entry: row 1, column 1
mat[1, ]  # first row
mat[, 1]  # first column

mat[c(1,2), c(2,3)]   # subset of original matrix: two rows and two columns


## ----makeList-----------------------------------------------------------------
mylist <- list(c("A", "b", "c"), c(1,2,3), matrix(1:4, ncol = 2))
mylist
class(mylist)


## ----makeListv----------------------------------------------------------------
mylist_named <- list(letters = c("A", "b", "c"), 
                     numbers = c(1,2,3), 
                     one_matrix = matrix(1:4, ncol = 2))
mylist_named


## -----------------------------------------------------------------------------
mylist_named[[1]]
mylist_named[["letters"]]     # works only for a list with elements' names 
mylist_named$letters          # works only for a list with elements' names 

