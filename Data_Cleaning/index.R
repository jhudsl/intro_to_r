## ---- echo = FALSE, message = FALSE-------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
library(readr)
suppressPackageStartupMessages(library(dplyr))
library(tidyverse)


## -----------------------------------------------------------------------------
x = c(1, 4, 2, 8, 10)
x[2]


## -----------------------------------------------------------------------------
nth(x, n = 2)


## -----------------------------------------------------------------------------
x = c(1, 2, 4, 8, 10)
x[5]
x[c(2,5)]


## ---- error=TRUE--------------------------------------------------------------
nth(x, n = c(2, 5)) # nth only returns one number


## ----negativeIndex------------------------------------------------------------
x[-2] # all but the second


## ----negativeIndex2-----------------------------------------------------------
x[-c(1,2,3)] # drop first 3
# x[-1:3] # shorthand. R sees as -1 to 3
x[-(1:3)] # needs parentheses


## -----------------------------------------------------------------------------
x
x > 2
x[ x > 2 ]


## -----------------------------------------------------------------------------
x[ x > 2 & x < 5 ]
x[ x > 5 | x == 2 ]


## -----------------------------------------------------------------------------
which(x > 5 | x == 2) # returns index
x[ which(x > 5 | x == 2) ]
x[ x > 5 | x == 2 ]


## -----------------------------------------------------------------------------
x = c(0, NA, 2, 3, 4, -0.5, 0.2)
x > 2


## -----------------------------------------------------------------------------
x != NA
x > 2 & !is.na(x)


## -----------------------------------------------------------------------------
(x == 0 | x == 2) # has NA
(x == 0 | x == 2) & !is.na(x) # No NA


## -----------------------------------------------------------------------------
df = tibble(x = x)
df %>% filter(x > 2)
df %>% filter(between(x, -1, 3) | is.na(x))


## -----------------------------------------------------------------------------
x %in% c(0, 2, NA) # this 
x %in% c(0, 2) | is.na(x) # versus this


## -----------------------------------------------------------------------------
x + 2
x * 2


## ----table--------------------------------------------------------------------
unique(x)
table(x)
table(x, useNA = "ifany") # will not 
df %>% count(x)


## ----onetab_ifany-------------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2, 2, 3), 
        useNA = "ifany")
tibble(x = c(0, 1, 2, 3, 2, 3, 3, 2, 2, 3)) %>%  count(x)


## ----onetab-------------------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2, 2, 3), 
        useNA = "always")


## ----onetab_fact, error = TRUE------------------------------------------------
fac = factor(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3),
             levels = 1:4)
tab = table(fac)
tab
tab[ tab > 0 ]
tibble(x = fac) %>% count(x)


## -----------------------------------------------------------------------------
tab <- table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
             c(0, 1, 2, 3, 2, 3, 3, 4, 4, 3), 
              useNA = "always")
tab


## -----------------------------------------------------------------------------
tab_df = tibble(x = c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
             y = c(0, 1, 2, 3, 2, 3, 3, 4, 4, 3))
tab_df %>% count(x, y)


## ----margin-------------------------------------------------------------------
margin.table(tab, 2)


## ----table2-------------------------------------------------------------------
prop.table(tab)
prop.table(tab,1) * 100


## -----------------------------------------------------------------------------
tab_df %>% 
  count(x, y) %>% 
  group_by(x) %>% mutate(pct_x = n / sum(n))


## -----------------------------------------------------------------------------
library(scales)
tab_df %>% 
  count(x, y) %>% 
  group_by(x) %>% mutate(pct_x = percent(n / sum(n)))


## ----readSal, echo = TRUE, eval = FALSE---------------------------------------
## Sal = jhur::read_salaries() # or
## Sal = read_csv("https://johnmuschelli.com/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv")
## Sal = rename(Sal, Name = name)


## ----readSal_csv, echo= FALSE, eval = TRUE------------------------------------
Sal = read_csv("https://johnmuschelli.com/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv", col_types = cols(
  name = col_character(),
  JobTitle = col_character(),
  AgencyID = col_character(),
  Agency = col_character(),
  HireDate = col_character(),
  AnnualSalary = col_character(),
  GrossPay = col_character()
))
Sal = rename(Sal, Name = name)


## ----isna---------------------------------------------------------------------
head(Sal,2)
any(is.na(Sal$Name)) # are there any NAs?


## ---- eval = FALSE------------------------------------------------------------
## data = data %>%
##   mutate(gender = recode(gender, M = "Male", m = "Male", M = "Male"))


## ---- eval = FALSE------------------------------------------------------------
## data %>%
##   mutate(gender = ifelse(gender %in% c("Male", "M", "m"),
##                          "Male", gender))


## ----gender, echo=FALSE-------------------------------------------------------
set.seed(4) # random sample below - make sure same every time
gender <- sample(c("Male", "mAle", "MaLe", "M", "MALE", "Ma", "FeMAle", "F", "Woman", "Man", "Fm", "FEMALE"), 1000, replace = TRUE)


## ----gentab-------------------------------------------------------------------
table(gender)


## ----gender2, echo=FALSE------------------------------------------------------
gender = gender %>% 
  tolower %>% 
  recode(m = "Male", f = "Female", ma = "Male",
         woman = "Female", man = "Male")


## ----gentab2------------------------------------------------------------------
table(gender)


## ----str_split_orig-----------------------------------------------------------
library(stringr)
x <- c("I really", "like writing", "R code programs")
y <- str_split(x, " ") # returns a list
y


## -----------------------------------------------------------------------------
str_split("I.like.strings", ".")
str_split("I.like.strings", fixed("."))


## ----stsplit2-----------------------------------------------------------------
y[[2]]
sapply(y, dplyr::first) # on the fly
sapply(y, nth, 2) # on the fly
sapply(y, last) # on the fly


## ----separate_df--------------------------------------------------------------
df = tibble(x = c("I really", "like writing", "R code programs"))


## -----------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second", "third"))


## ----separate_df2_for_easy----------------------------------------------------
df = tibble(x = c("I really", "like writing", "R code programs"))


## -----------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second"))


## ----separate_df2-------------------------------------------------------------
df = tibble(x = c("I really", "like. _writing R. But not", "R code programs"))


## -----------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second", "third"), extra = "merge")


## -----------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second", "third"), 
                extra = "merge", sep = " ")


## ----RawlMatch_log------------------------------------------------------------
head(str_detect(Sal$Name, "Rawlings"))


## ----RawlMatch----------------------------------------------------------------
which(str_detect(Sal$Name, "Rawlings"))


## ----ggrep2-------------------------------------------------------------------
ss = str_extract(Sal$Name, "Rawling")
head(ss)
ss[ !is.na(ss)]


## ----ggrep--------------------------------------------------------------------
str_subset(Sal$Name, "Rawlings")
Sal %>% filter(str_detect(Name, "Rawlings"))


## ----grepstar_stringr---------------------------------------------------------
head(str_subset( Sal$Name, "^Payne.*"), 3)


## ----grepstar2_stringr--------------------------------------------------------
head(str_subset( Sal$Name, "Leonard.?S"))
head(str_subset( Sal$Name, "Spence.*C.*"))


## -----------------------------------------------------------------------------
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"), 2)


## -----------------------------------------------------------------------------
head(str_replace(Sal$Name, "a", "j"))
head(str_replace_all(Sal$Name, "a", "j"), 2)


## ----classSal-----------------------------------------------------------------
class(Sal$AnnualSalary)

## ----destringSal--------------------------------------------------------------
head(Sal$AnnualSalary, 4)
head(as.numeric(Sal$AnnualSalary), 4)


## ----orderSal-----------------------------------------------------------------
Sal = Sal %>% mutate(
  AnnualSalary = str_replace(AnnualSalary, fixed("$"), ""),
  AnnualSalary = as.numeric(AnnualSalary)
  ) %>% 
  arrange(desc(AnnualSalary))


## ----Paste--------------------------------------------------------------------
paste("Visit", 1:5, sep = "_")
paste("Visit", 1:5, sep = "_", collapse = " ")
paste("To", "is going be the ", "we go to the store!", sep = "day ")
# and paste0 can be even simpler see ?paste0 
paste0("Visit",1:5)


## ----unite_df-----------------------------------------------------------------
df = tibble(id = rep(1:5, 3), visit = rep(1:3, each = 5))


## -----------------------------------------------------------------------------
df %>% unite(col = "unique_id", id, visit, sep = "_")


## ----unite_df2----------------------------------------------------------------
df = tibble(id = rep(1:5, 3), visit = rep(1:3, each = 5))


## -----------------------------------------------------------------------------
df %>% unite(col = "unique_id", id, visit, sep = "_", remove = FALSE)


## ----Paste2-------------------------------------------------------------------
paste(1:5)
paste(1:5, collapse = " ")


## ----orderrank----------------------------------------------------------------
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))
x = rnorm(10)
x[1] = x[2] # create a tie
rank(x)


## -----------------------------------------------------------------------------
x <- c("I really", "like writing", "R code programs")
y <- strsplit(x, split = " ") # returns a list
y


## -----------------------------------------------------------------------------
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"), 2)


## -----------------------------------------------------------------------------
grep("Rawlings",Sal$Name)
which(grepl("Rawlings", Sal$Name))
which(str_detect(Sal$Name, "Rawlings"))


## -----------------------------------------------------------------------------
head(grepl("Rawlings",Sal$Name))
head(str_detect(Sal$Name, "Rawlings"))


## -----------------------------------------------------------------------------
grep("Rawlings",Sal$Name,value=TRUE)
Sal[grep("Rawlings",Sal$Name),]


## -----------------------------------------------------------------------------
ss = str_extract(Sal$Name, "Rawling")
head(ss)
ss[ !is.na(ss)]


## -----------------------------------------------------------------------------
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"), 2)


## -----------------------------------------------------------------------------
head(grep("^Payne.*", x = Sal$Name, value = TRUE), 3)


## -----------------------------------------------------------------------------
head(grep("Leonard.?S", x = Sal$Name, value = TRUE))
head(grep("Spence.*C.*", x = Sal$Name, value = TRUE))


## -----------------------------------------------------------------------------
head(str_subset( Sal$Name, "^Payne.*"), 3)


## -----------------------------------------------------------------------------
head(str_subset( Sal$Name, "Leonard.?S"))
head(str_subset( Sal$Name, "Spence.*C.*"))


## -----------------------------------------------------------------------------
class(Sal$AnnualSalary)


## -----------------------------------------------------------------------------
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))


## -----------------------------------------------------------------------------
head(Sal$AnnualSalary, 4)
head(as.numeric(Sal$AnnualSalary), 4)


## -----------------------------------------------------------------------------
Sal$AnnualSalary <- as.numeric(gsub(pattern = "$", replacement="", 
                              Sal$AnnualSalary, fixed=TRUE))
Sal <- Sal[order(Sal$AnnualSalary, decreasing=TRUE), ] 
Sal[1:5, c("Name", "AnnualSalary", "JobTitle")]


## -----------------------------------------------------------------------------
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

