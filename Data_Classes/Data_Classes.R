## ---- echo = FALSE, message=FALSE---------------------------------------------
# library(dplyr)
suppressPackageStartupMessages(library(dplyr))
library(readr)
library(forcats)


## ----numChar------------------------------------------------------------------
class(c("tree", "cloud", "stars_&_sky"))
class(c(1, 4, 7))


## ----numChar2-----------------------------------------------------------------
class(c(1, 2, "tree"))
class(c("1", "4", "7"))


## ----seq----------------------------------------------------------------------
x = c(1, 2, 3, 4, 5)
x
x = seq(1:5)
x
class(x)
typeof(x)


## ----double-------------------------------------------------------------------
y = c(1.1, 2.0, 3.2, 4.5, 5.6)
y
class(y)
typeof(y)


## -----------------------------------------------------------------------------
tibble(xvar = x, yvar = y)



## ----logical1-----------------------------------------------------------------
x = c(TRUE, FALSE, TRUE, TRUE, FALSE)
class(x)


## ----logical2-----------------------------------------------------------------
z = c("TRUE", "FALSE", "TRUE", "FALSE")
class(z)


## ----logical_coercion---------------------------------------------------------
is.character(c(1, 4, 7))
is.numeric(c(1, 4, 7))
is.character(c("tree", "cloud"))
is.numeric(c("tree", "cloud"))


## ----logical_coercion3s-------------------------------------------------------
as.character(c(1, 4, 7))
as.numeric(c("1", "4", "7"))
as.logical(c("TRUE", "FALSE", "FALSE"))
as.integer(c(1.2, 3.7))
as.double(c(1, 2, 3))


## ----logical_coercions4-------------------------------------------------------
as.numeric(c("1", "4", "7a"))
as.logical(c("TRUE", "FALSE", "UNKNOWN"))
as.Date(c("2021-06-15", "2021-06-32"))


## ----factor1------------------------------------------------------------------
x <- c("small", "mediam", "large", "medium", "large")
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
rep(c("black", "white"), each = 2, times = 2)


## -----------------------------------------------------------------------------
seq(from = 0, to = 1, by = 0.2)
seq(from = -5, to = 5, length.out = 10)


## -----------------------------------------------------------------------------
head(iris)
class(iris)
iris_mat <-head(tibble(select(iris, -Species)))
as.matrix(iris_mat)
matrix(1:4, ncol = 2)


## ----makeList-----------------------------------------------------------------
mylist <- list(c("A", "b", "c"), c(1,2,3), matrix(1:4, ncol = 2))
mylist
class(mylist)


## ----makeListv----------------------------------------------------------------
mylist_named <- list(letters = c("A", "b", "c"), 
                     numbers = c(1,2,3), 
                     one_matrix = matrix(1:4, ncol = 2))
mylist_named


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


## ----matrix-------------------------------------------------------------------
n = 1:9 
n
mat = matrix(n, nrow = 3)
mat


## -----------------------------------------------------------------------------
x <- c("a", "b", "c", "d", "e", "f", "g", "h")
x
x[2]
x[c(1, 2, 100)]


## ----subset3------------------------------------------------------------------
mat
mat[1, 1] # individual entry: row 1, column 1
mat[1, 2] # individual entry: row 1, column 2
mat[1, ]  # first row
mat[, 1]  # first column

mat[c(1,2), c(2,3)]   # subset of original matrix: two rows and two columns


## -----------------------------------------------------------------------------
mylist_named[[1]]
mylist_named[["letters"]]     # works only for a list with elements' names 
mylist_named$letters          # works only for a list with elements' names 

