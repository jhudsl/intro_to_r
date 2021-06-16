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
x = c(1, 2, 4, 8, 10)
x[5]
x[c(2,5)]


## ----negativeIndex------------------------------------------------------------
x[-2] # all but the second


## ----negativeIndex2-----------------------------------------------------------
x[-c(1,2,3)] # drop first 3
# x[-1:3] # shorthand. R sees as -1 to 3
x[-(1:3)] # needs parentheses


## -----------------------------------------------------------------------------
complete.cases(x)
complete.cases(mtcars)


## ---- error=FALSE-------------------------------------------------------------
#install.packageS(naniar)
library(naniar)
x = c(0, NA, 2, 3, 4, -0.5, 0.2)
naniar::pct_complete(x)


## -----------------------------------------------------------------------------
naniar::gg_miss_var(iris)


## -----------------------------------------------------------------------------
x = c(0, NA, 2, 3, 4, -0.5, 0.2)
x > 2


## -----------------------------------------------------------------------------
df = tibble(x = x)
df %>% filter(x > 2)
df %>% filter(between(x, -1, 3) | is.na(x))


## -----------------------------------------------------------------------------
x # looks like the 1st and 3rd element should be TRUE
x %in% c(0, 2) # uh oh - not good!
x %in% c(0, 2) | is.na(x) # do this



## -----------------------------------------------------------------------------
x + 2
x * 2


## ----table--------------------------------------------------------------------
unique(x)
table(x, useNA = "ifany")
df %>% count(x)


## ----onetab_ifany-------------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2, 2, 3), 
        useNA = "ifany")
tibble(x = c(0, 1, 2, 3, 2, 3, 3, 2, 2, 3)) %>%  count(x)


## ----onetab-------------------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2, 2, 3), 
        useNA = "always")


## ----readSal, echo = TRUE, eval = FALSE---------------------------------------
## Sal = jhur::read_salaries() # or
## Sal = read_csv("https://jhudatascience.org/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv")
## Sal = rename(Sal, Name = name)


## ----readSal_csv, echo= FALSE, eval = TRUE------------------------------------
Sal = read_csv("https://jhudatascience.org/intro_to_r/data/Baltimore_City_Employee_Salaries_FY2015.csv", col_types = cols(
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
##   mutate(gender = recode(gender, M = "Male", m = "Male", Man = "Male"))


## ----str_split_orig-----------------------------------------------------------
library(stringr)
x <- c("I really like writing R code")
df = tibble(x = c("I really", "like writing", "R code programs"))
y <- unlist(str_split(x, " "))
y
length(y)


## -----------------------------------------------------------------------------
str_split("I.like.strings", ".")
str_split("I.like.strings", fixed("."))


## ----stsplit2-----------------------------------------------------------------
y[[2]]
# sapply(y, dplyr::first) # on the fly
# sapply(y, nth, 2) # on the fly
# sapply(y, last) # on the fly


## ----separate_df--------------------------------------------------------------
df = tibble(x = c("I really", "like writing", "R code programs"))


## -----------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second", "third"))


## -----------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second", "third"), 
                extra = "merge", sep = " ")


## ----RawlMatch_log------------------------------------------------------------
head(str_detect(Sal$Name, "Rawlings"))


## -----------------------------------------------------------------------------
Sal %>% filter(str_detect(Name, "Rawlings"))


## ----grepstar_stringr---------------------------------------------------------
head(str_subset( Sal$Name, "^Payne.*"), 3)


## ----grepstar2_stringr--------------------------------------------------------
head(str_subset( Sal$Name, "Leonard.?S"))
head(str_subset( Sal$Name, "Spence.*C.*"))


## -----------------------------------------------------------------------------
head(Sal$Name, 2)
head(str_replace(Sal$Name, "a", "j"),2)


## -----------------------------------------------------------------------------
head(str_replace_all(Sal$Name, "a", "j"), 2)


## ----classSal-----------------------------------------------------------------
class(Sal$AnnualSalary)


## ----destringSal--------------------------------------------------------------
head(Sal$AnnualSalary, 4)
head(as.numeric(Sal$AnnualSalary), 4)


## ----Paste--------------------------------------------------------------------
paste("Visit", 1:5, sep = "_")
paste("Visit", 1:5, sep = "_", collapse = "_")
paste("To", "is going be the ", "we go to the store!", sep = "day ")
# and paste0 can be even simpler see ?paste0 
paste0("Visit",1:5) # no space!


## ----unite_df-----------------------------------------------------------------
df = tibble(id = rep(1:5, 3), visit = rep(1:3, each = 5))
head(df, 4)


## -----------------------------------------------------------------------------
df_united <- df %>% unite(col = "unique_id", id, visit, sep = "_")
head(df_united, 4)


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


## -----------------------------------------------------------------------------
tab <- table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3),
             c(0, 1, 2, 3, 2, 3, 3, 4, 4, 3),
              useNA = "always")
tab


## -----------------------------------------------------------------------------
tab_df = tibble(x = c(0, 1, 2, 3, 2, 3, 3, 2,2, 3),
             y = c(0, 1, 2, 3, 2, 3, 3, 4, 4, 3))
tab_df %>% count(x, y)


## -----------------------------------------------------------------------------
tab_df %>% 
  count(x, y) %>% 
  group_by(x) %>% mutate(pct_x = n / sum(n))


## ---- message = FALSE---------------------------------------------------------
library(scales)
tab_df %>% 
  count(x, y) %>% 
  group_by(x) %>% mutate(pct_x = percent(n / sum(n)))

