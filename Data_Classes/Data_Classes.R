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


## ----seqShort-----------------------------------------------------------------
1:5


## ----logical1-----------------------------------------------------------------
x = c(TRUE, FALSE, TRUE, TRUE, FALSE)
class(x)
is.numeric(c("Andrew", "Jaffe"))
is.character(c("Andrew", "Jaffe"))


## ----logical2-----------------------------------------------------------------
z = c("TRUE", "FALSE", "TRUE", "FALSE")
class(z)
as.logical(z)


## ----logical_z----------------------------------------------------------------
sum(as.logical(z))


## ----logical_coercion---------------------------------------------------------
is.numeric(c("Andrew", "Jaffe"))
is.character(c("Andrew", "Jaffe"))


## ----logical_coercion2--------------------------------------------------------
as.character(c(1, 4, 7))
as.numeric(c("Andrew", "Jaffe"))


## ----factor1------------------------------------------------------------------
x = factor(c("boy", "girl", "girl", "boy", "girl"))
x 
class(x)


## -----------------------------------------------------------------------------
x = c(0, 2, 2, 3, 4)
(x == 0 | x == 2) 


## -----------------------------------------------------------------------------
x %in% c(0, 2) # NEVER has NA and returns logical


## ----factor2------------------------------------------------------------------
cc = factor(c("case","case","case",
        "control","control","control"))
cc


## -----------------------------------------------------------------------------
levels(cc) = c("control","case")
cc


## ----factor_cc_again----------------------------------------------------------
casecontrol = c("case","case","case","control",
          "control","control")
factor(casecontrol, levels = c("control","case") )
factor(casecontrol, levels = c("control","case"), 
       ordered=TRUE)


## ----factorCheck--------------------------------------------------------------
cc = factor(c("case","case","case",
        "control","control","control"))
relevel(cc, "control")


## -----------------------------------------------------------------------------
fct_relevel(cc, "control")


## -----------------------------------------------------------------------------
levels(fct_inorder(chickwts$feed))
levels(fct_infreq(chickwts$feed))
levels(fct_lump(chickwts$feed, n=1))


## ----factor3------------------------------------------------------------------
x = factor(casecontrol,
        levels = c("control","case") )
as.character(x)
as.numeric(x)


## ----rep1---------------------------------------------------------------------
bg = rep(c("boy","girl"),each=50)
head(bg)
bg2 = rep(c("boy","girl"),times=50)
head(bg2)
length(bg) == length(bg2)


## ---- message = FALSE---------------------------------------------------------
circ = jhur::read_circulator()
head(sort(circ$date))
library(lubridate) # great for dates!
circ = mutate(circ, newDate2 = mdy(date))
head(circ$newDate2)
range(circ$newDate2) # gives you the range of the data


## ---- message = FALSE---------------------------------------------------------
x = c("2014-02-4 05:02:00", "2016/09/24 14:02:00")
ymd_hms(x)


## -----------------------------------------------------------------------------
ymd_hm(x)


## ---- message = FALSE---------------------------------------------------------
x = c("2014-02-4 05:02:00", "2016/09/24 14:02:00")
dates = ymd_hms(x)
class(dates)


## -----------------------------------------------------------------------------
theTime = Sys.time()
theTime
class(theTime)
theTime + as.period(20, unit = "minutes") # the future


## -----------------------------------------------------------------------------
the_future = ymd_hms("2020-12-31 11:59:59")
the_future - theTime
difftime(the_future, theTime, units = "weeks")


## ----matrix-------------------------------------------------------------------
n = 1:9 
n
mat = matrix(n, nrow = 3)
mat


## ----subset3------------------------------------------------------------------
mat[1, 1] # individual entry: row 1, column 1
mat[1, ] # first row
mat[, 1] # first columns


## ----subset4------------------------------------------------------------------
class(mat[1, ])
class(mat[, 1])


## ----makeList, comment="", prompt=TRUE----------------------------------------
mylist <- list(letters=c("A", "b", "c"), 
        numbers=1:3, matrix(1:25, ncol=5))


## ----Lists, comment="", prompt=TRUE-------------------------------------------
head(mylist)


## ----Listsref1, comment="", prompt=TRUE---------------------------------------
mylist[1] # returns a list
mylist["letters"] # returns a list


## ----Listsrefvec, comment="", prompt=TRUE-------------------------------------
mylist[[1]] # returns the vector 'letters'
mylist$letters # returns vector
mylist[["letters"]] # returns the vector 'letters'


## ----Listsref2, comment="", prompt=TRUE---------------------------------------
mylist[1:2] # returns a list


## ----Listsref3, comment="", prompt=TRUE---------------------------------------
mylist$letters[1]
mylist[[2]][1]
mylist[[3]][1:2,1:2]


## ---- message=FALSE-----------------------------------------------------------
circ %>% 
  mutate(first_date = first(newDate2),
         last_date = last(newDate2),
         third_date = nth(newDate2, 3)) %>% 
  select(day, date, first_date, last_date, third_date) %>% head(3)


## ---- message=FALSE-----------------------------------------------------------
circ %>% 
  group_by(day) %>% 
  mutate(first_date = first(newDate2),
         last_date = last(newDate2),
         third_date = nth(newDate2, 3)) %>% 
  select(day, date, first_date, last_date, third_date) %>% head(3)


## ---- message=FALSE-----------------------------------------------------------
circ = circ %>% 
  group_by(day) %>% 
  mutate(first_date = first(newDate2),
         diff_from_first = difftime( # time1 - time2
           time1 = newDate2, time2 = first_date)) 
head(circ$diff_from_first, 10)
units(circ$diff_from_first) = "days"
head(circ$diff_from_first, 10)

