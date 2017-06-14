## ---- echo = FALSE, message=FALSE----------------------------------------
# library(dplyr)
suppressPackageStartupMessages(library(dplyr))
library(readr)

## ----numChar-------------------------------------------------------------
class(c("Andrew", "Jaffe"))
class(c(1, 4, 7))

## ----seq-----------------------------------------------------------------
x = seq(from = 1, to = 5) # seq() is a function
x
class(x)

## ----seqShort------------------------------------------------------------
1:5

## ----logical1------------------------------------------------------------
x = c(TRUE, FALSE, TRUE, TRUE, FALSE)
class(x)
is.numeric(c("Andrew", "Jaffe"))
is.character(c("Andrew", "Jaffe"))

## ----logical2------------------------------------------------------------
z = c("TRUE", "FALSE", "TRUE", "FALSE")
class(z)
as.logical(z)

## ----logical_z-----------------------------------------------------------
sum(as.logical(z))

## ----logical_coercion----------------------------------------------------
is.numeric(c("Andrew", "Jaffe"))
is.character(c("Andrew", "Jaffe"))

## ----logical_coercion2---------------------------------------------------
as.character(c(1, 4, 7))
as.numeric(c("Andrew", "Jaffe"))

## ----factor1-------------------------------------------------------------
x = factor(c("boy", "girl", "girl", "boy", "girl"))
x 
class(x)

## ----factor2-------------------------------------------------------------
cc = factor(c("case","case","case",
        "control","control","control"))
cc

## ------------------------------------------------------------------------
levels(cc) = c("control","case")
cc

## ----factor_cc_again-----------------------------------------------------
casecontrol = c("case","case","case","control",
          "control","control")
factor(casecontrol, levels = c("control","case") )
factor(casecontrol, levels = c("control","case"), 
       ordered=TRUE)

## ----factor3-------------------------------------------------------------
x = factor(casecontrol,
        levels = c("control","case") )
as.character(x)
as.numeric(x)

## ----factorCheck---------------------------------------------------------
xCopy = x
levels(xCopy) = c("case", "control") # wrong way
xCopy        
as.character(xCopy) # labels switched
as.numeric(xCopy)

## ----rep1----------------------------------------------------------------
bg = rep(c("boy","girl"),each=50)
head(bg)
bg2 = rep(c("boy","girl"),times=50)
head(bg2)
length(bg) == length(bg2)

## ---- message = FALSE----------------------------------------------------
# paste/paste0 combines strings/character
circ = read_csv(
  paste0("http://johnmuschelli.com/intro_to_r/data",
         "/Charm_City_Circulator_Ridership.csv"))

## ----ifelse1-------------------------------------------------------------
hi_rider = ifelse(circ$daily > 10000, "high", "low")
hi_rider = factor(hi_rider, levels = c("low","high"))
head(hi_rider)
table(hi_rider)

## ----ifelse2-------------------------------------------------------------
riderLevels = ifelse(circ$daily < 10000, "low", 
                  ifelse(circ$daily > 20000,
                  "high", "med"))
riderLevels = factor(riderLevels, 
              levels = c("low","med","high"))
head(riderLevels)
table(riderLevels)

## ----show_cut------------------------------------------------------------
riderLevels2 = cut(
  circ$daily, 
  breaks = c(min(circ$daily, na.rm = TRUE),
             10000, 
             20000,
             max(circ$daily, na.rm = TRUE)),
  labels = c("low", "med", "high"), # one less than breaks
  include.lowest = TRUE)
head(riderLevels2)
table(riderLevels2, riderLevels)

## ----cut1----------------------------------------------------------------
x = 1:100
cx = cut(x, breaks = c(0,10,25,50,100))
head(cx)  
table(cx)

## ----cut2----------------------------------------------------------------
cx = cut(x, breaks = c(0,10,25,50,100), labels = FALSE)
head(cx)  
table(cx)

## ----cut3----------------------------------------------------------------
cx = cut(x, breaks = c(10,25,50), labels = FALSE)
head(cx)  
table(cx)
table(cx, useNA = "ifany")

## ----date----------------------------------------------------------------
head(sort(circ$date))
# creating a date for sorting
circ$newDate <- as.Date(circ$date, "%m/%d/%Y")
head(circ$newDate)
range(circ$newDate)

## ---- message=FALSE------------------------------------------------------
library(lubridate) # great for dates!
circ = mutate(circ, newDate2 = mdy(date))
head(circ$newDate2)
range(circ$newDate2) # gives you the range of the data

## ------------------------------------------------------------------------
theTime = Sys.time()
theTime
class(theTime)
theTime + as.period(20, unit = "minutes") # the future

## ---- message=FALSE------------------------------------------------------
circ = circ %>% 
  group_by(day) %>% 
  mutate(first_date = first(newDate2),
         diff_from_first = difftime( # time1 - time2
           time1 = newDate2, time2 = first_date)) 
head(circ$diff_from_first, 10)
units(circ$diff_from_first) = "days"
head(circ$diff_from_first, 10)

## ----matrix--------------------------------------------------------------
n = 1:9 
n
mat = matrix(n, nrow = 3)
mat

## ----subset3-------------------------------------------------------------
mat[1, 1] # individual entry: row 1, column 1
mat[1, ] # first row
mat[, 1] # first columns

## ----subset4-------------------------------------------------------------
class(mat[1, ])
class(mat[, 1])

## ----makeList, comment="", prompt=TRUE-----------------------------------
mylist <- list(letters=c("A", "b", "c"), 
        numbers=1:3, matrix(1:25, ncol=5))

## ----Lists, comment="", prompt=TRUE--------------------------------------
head(mylist)

## ----Listsref1, comment="", prompt=TRUE----------------------------------
mylist[1] # returns a list
mylist["letters"] # returns a list

## ----Listsrefvec, comment="", prompt=TRUE--------------------------------
mylist[[1]] # returns the vector 'letters'
mylist$letters # returns vector
mylist[["letters"]] # returns the vector 'letters'

## ----Listsref2, comment="", prompt=TRUE----------------------------------
mylist[1:2] # returns a list

## ----Listsref3, comment="", prompt=TRUE----------------------------------
mylist$letters[1]
mylist[[2]][1]
mylist[[3]][1:2,1:2]

