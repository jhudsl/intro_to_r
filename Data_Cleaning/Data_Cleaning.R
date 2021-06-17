## ---- echo = FALSE, message = FALSE-------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
library(readr)
suppressPackageStartupMessages(library(dplyr))
library(tidyverse)


## ----isna---------------------------------------------------------------------
A = c(1, 2, 4, NA)
B = c(1, 2, 3, 4)
any(is.na(A)) # are there any NAs - YES/TRUE
any(is.na(B)) # are there any NAs- NO/FALSE


## ----all----------------------------------------------------------------------
A = c(1, 2, 4, NA)
B = c(1, 2, 3, 4)
all(is.na(A)) # are all values NA - NO/FALSE
all(!is.na(B)) # are all values not NA - YES/TRUE


## -----------------------------------------------------------------------------
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
x # looks like the 1st and 3rd element should be TRUE
x %in% c(0, 2) # uh oh - not good!
x %in% c(0, 2) | is.na(x) # do this



## -----------------------------------------------------------------------------
df <-tibble(x = c(0, NA, 2, 0.2), 
            y = c(NA, 1, 6, NA))
df
drop_na(df)


## ----table--------------------------------------------------------------------
z = c("A", "B", "A", "B")
table(z, useNA = "ifany")
table(z, useNA = "always")


## ---- eval = FALSE------------------------------------------------------------
## data = data %>%
##   mutate(gender = recode(gender, M = "Male", m = "Male", Man = "Male"))


## ----separate_df--------------------------------------------------------------
df = tibble(x = c("I really", "like writing", "R code programs"))


## -----------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second", "third"))


## -----------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second", "third"), 
                extra = "merge", sep = " ")


## ----unite_df-----------------------------------------------------------------
df = tibble(id = rep(1:5, 3), visit = rep(1:3, each = 5))
head(df, 4)


## -----------------------------------------------------------------------------
df_united <- df %>% unite(col = "unique_id", id, visit, sep = "_")
head(df_united, 4)


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
str_split("I.like.strings", "\\.")


## ----readSal, echo = TRUE, eval = TRUE, message=FALSE-------------------------
Sal = jhur::read_salaries() # or

## -----------------------------------------------------------------------------
head(Sal)


## -----------------------------------------------------------------------------
Sal %>% filter(str_detect(name, "Rawlings"))


## -----------------------------------------------------------------------------
head(Sal$Name, 2)
head(str_replace(Sal$name, "a", "j"),2)


## -----------------------------------------------------------------------------
head(str_replace_all(Sal$name, "a", "j"), 2)


## ----Paste--------------------------------------------------------------------
paste("Visit", 1:5, sep = "_")
paste("Visit", 1:5, sep = "_", collapse = "_")
# and paste0 can be even simpler see ?paste0 
paste0("Visit",1:5) # no space!


## ----grepstar_stringr---------------------------------------------------------
head(str_subset( Sal$name, "^Payne.*"), 3)


## ----grepstar2_stringr--------------------------------------------------------
head(str_subset( Sal$name, "Leonard.?S"))
head(str_subset( Sal$name, "Spence.*C.*"))


## -----------------------------------------------------------------------------
x <- c("I really", "like writing", "R code programs")
y <- stringr::str_split(x, pattern =  " ") # returns a list
y


## -----------------------------------------------------------------------------
head(Sal$AgencyID)
head(str_extract(Sal$AgencyID, "\\d"))


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
head(grep("^Payne.*", x = Sal$name, value = TRUE), 3)


## -----------------------------------------------------------------------------
head(grep("Leonard.?S", x = Sal$name, value = TRUE))
head(grep("Spence.*C.*", x = Sal$name, value = TRUE))


## -----------------------------------------------------------------------------
head(str_subset( Sal$name, "^Payne.*"), 3)


## -----------------------------------------------------------------------------
head(str_subset( Sal$name, "Leonard.?S"))
head(str_subset( Sal$name, "Spence.*C.*"))


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
Sal[1:5, c("name", "AnnualSalary", "JobTitle")]


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

