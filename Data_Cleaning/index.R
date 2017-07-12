## ---- echo = FALSE, message = FALSE--------------------------------------
library(knitr)
opts_chunk$set(comment = "")
library(readr)
suppressPackageStartupMessages(library(dplyr))

## ------------------------------------------------------------------------
x = c(0, NA, 2, 3, 4)
x > 2

## ------------------------------------------------------------------------
x != NA
x > 2 & !is.na(x)

## ------------------------------------------------------------------------
(x == 0 | x == 2) # has NA
(x == 0 | x == 2) & !is.na(x) # No NA

## ------------------------------------------------------------------------
x %in% c(0, 2, NA) # NEVER has NA and returns logical
x %in% c(0, 2) | is.na(x)

## ------------------------------------------------------------------------
x + 2
x * 2

## ----table---------------------------------------------------------------
unique(x)
table(x)
table(x, useNA = "ifany") # will not 

## ----onetab_ifany--------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
        useNA = "ifany")

## ----onetab--------------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
        useNA = "always")

## ----onetab_fact---------------------------------------------------------
fac = factor(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3),
             levels = 1:4)
tab = table(fac)
tab
tab[ tab > 0 ]

## ------------------------------------------------------------------------
tab <- table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
             c(0, 1, 2, 3, 2, 3, 3, 4, 4, 3), 
              useNA = "always")
tab

## ----margin--------------------------------------------------------------
margin.table(tab, 2)

## ----table2--------------------------------------------------------------
prop.table(tab)
prop.table(tab,1) * 100

## ----readSal, echo = TRUE, eval = FALSE----------------------------------
## Sal = read_csv("http://data.baltimorecity.gov/api/views/nsfe-bg53/rows.csv")
## Sal = rename(Sal, Name = name)

## ----readSal_csv, echo= FALSE, eval = TRUE-------------------------------
Sal = read.csv("http://data.baltimorecity.gov/api/views/nsfe-bg53/rows.csv")
Sal = rename(Sal, Name = name)

## ----isna----------------------------------------------------------------
head(Sal,2)
any(is.na(Sal$Name)) # are there any NAs?

## ---- eval = FALSE-------------------------------------------------------
## data$gender[data$gender %in%
##     c("Male", "M", "m")] <- "Male"

## ---- eval = FALSE-------------------------------------------------------
## data %>%
##   mutate(gender = ifelse(gender %in% c("Male", "M", "m"),
##                          "Male", gender))

## ----gender, echo=FALSE--------------------------------------------------
set.seed(4) # random sample below - make sure same every time
gender <- sample(c("Male", "mAle", "MaLe", "M", "MALE", "Ma", "FeMAle", "F", "Woman", "Man", "Fm", "FEMALE"), 1000, replace = TRUE)

## ----gentab--------------------------------------------------------------
table(gender)

## ----Paste---------------------------------------------------------------
paste("Visit", 1:5, sep = "_")
paste("Visit", 1:5, sep = "_", collapse = " ")
paste("To", "is going be the ", "we go to the store!", sep = "day ")
# and paste0 can be even simpler see ?paste0 
paste0("Visit",1:5)

## ----Paste2--------------------------------------------------------------
paste(1:5)
paste(1:5, collapse = " ")

## ----strsplit------------------------------------------------------------
x <- c("I really", "like writing", "R code programs")
y <- strsplit(x, split = " ") # returns a list
y

## ----str_split-----------------------------------------------------------
library(stringr)
y2 <- str_split(x, " ") # returns a list
y2

## ------------------------------------------------------------------------
str_split("I.like.strings", ".")
str_split("I.like.strings", fixed("."))

## ----stsplit2------------------------------------------------------------
suppressPackageStartupMessages(library(dplyr)) # must be loaded AFTER plyr
y[[2]]
sapply(y, dplyr::first) # on the fly
sapply(y, nth, 2) # on the fly
sapply(y, last) # on the fly

## ----ggrep---------------------------------------------------------------
str_subset(Sal$Name, "Rawlings")
Sal %>% filter(str_detect(Name, "Rawlings"))

## ----orderSal_stringr_rework---------------------------------------------
dplyr_sal = Sal
dplyr_sal = dplyr_sal %>% mutate( 
  AnnualSalary = AnnualSalary %>%
    str_replace(fixed("$"), "") %>%
    as.numeric) %>%
  arrange(desc(AnnualSalary))

## ------------------------------------------------------------------------
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"), 2)

## ----orderrank-----------------------------------------------------------
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))
x = rnorm(10)
x[1] = x[2] # create a tie
rank(x)

## ----RawlMatch-----------------------------------------------------------
grep("Rawlings",Sal$Name)
which(grepl("Rawlings", Sal$Name))
which(str_detect(Sal$Name, "Rawlings"))

## ----RawlMatch_log-------------------------------------------------------
head(grepl("Rawlings",Sal$Name))
head(str_detect(Sal$Name, "Rawlings"))

## ----grepl---------------------------------------------------------------
grep("Rawlings",Sal$Name,value=TRUE)
Sal[grep("Rawlings",Sal$Name),]

## ----ggrep2--------------------------------------------------------------
ss = str_extract(Sal$Name, "Rawling")
head(ss)
ss[ !is.na(ss)]

## ------------------------------------------------------------------------
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"), 2)

## ----grepstar------------------------------------------------------------
head(grep("^Payne.*", x = Sal$Name, value = TRUE), 3)

## ----grepstar2-----------------------------------------------------------
head(grep("Leonard.?S", x = Sal$Name, value = TRUE))
head(grep("Spence.*C.*", x = Sal$Name, value = TRUE))

## ----grepstar_stringr----------------------------------------------------
head(str_subset( Sal$Name, "^Payne.*"), 3)

## ----grepstar2_stringr---------------------------------------------------
head(str_subset( Sal$Name, "Leonard.?S"))
head(str_subset( Sal$Name, "Spence.*C.*"))

## ----classSal------------------------------------------------------------
class(Sal$AnnualSalary)

## ----orderstring---------------------------------------------------------
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))

## ----destringSal---------------------------------------------------------
head(Sal$AnnualSalary, 4)
head(as.numeric(Sal$AnnualSalary), 4)

## ----orderSal------------------------------------------------------------
Sal$AnnualSalary <- as.numeric(gsub(pattern = "$", replacement="", 
                              Sal$AnnualSalary, fixed=TRUE))
Sal <- Sal[order(Sal$AnnualSalary, decreasing=TRUE), ] 
Sal[1:5, c("Name", "AnnualSalary", "JobTitle")]

## ----orderSal_stringr----------------------------------------------------
dplyr_sal = Sal
dplyr_sal = dplyr_sal %>% mutate( 
  AnnualSalary = AnnualSalary %>%
    str_replace(
      fixed("$"), 
      "") %>%
    as.numeric) %>%
  arrange(desc(AnnualSalary))
check_Sal = Sal
rownames(check_Sal) = NULL
all.equal(check_Sal, dplyr_sal)

