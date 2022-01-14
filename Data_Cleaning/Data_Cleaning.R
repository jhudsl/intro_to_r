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


## ---- error=FALSE-------------------------------------------------------------
#install.packages("naniar")
library(naniar)
x = c(0, NA, 2, 3, 4, -0.5, 0.2)
naniar::pct_complete(x)


## ---- message=FALSE-----------------------------------------------------------
?airquality # use this to find out more about the data
airqual <-tibble(airquality)
airqual


## -----------------------------------------------------------------------------
pct_complete(airquality)


## ---- fig.height=4, warning=FALSE, fig.align='center'-------------------------
naniar::gg_miss_var(airqual)


## ---- fig.height=4, warning=FALSE, fig.align='center'-------------------------
naniar::gg_miss_var(airqual, facet = Month)


## -----------------------------------------------------------------------------
sum(c(1,2,3,NA))
mean(c(2,4,NA))
median(c(1,2,3,NA))


## ---- echo = FALSE------------------------------------------------------------
red_blue <- tibble(color = rep(c("red", "blue", NA), 3))
red_blue <- red_blue %>% count(color)
red_blue <- rename(red_blue, col_count = n)


## -----------------------------------------------------------------------------
x = c(0, NA, 2, 3, 4, -0.5, 0.2)
x > 2


## -----------------------------------------------------------------------------
x # looks like the 1st and 3rd element should be TRUE
x %in% c(0, 2) # uh oh - not good!
x %in% c(0, 2) | is.na(x) # do this



## ---- echo = FALSE------------------------------------------------------------
df <-tibble(Dog = c(0, NA, 2, 3, 1, 1), 
            Cat= c(NA, 8, 6, NA, 2, NA))


## -----------------------------------------------------------------------------
df

df %>% filter(Dog < 3)


## -----------------------------------------------------------------------------
df %>% filter(!is.na(Dog))


## -----------------------------------------------------------------------------
NA == NA
NA != NA


## -----------------------------------------------------------------------------
df
drop_na(df)


## -----------------------------------------------------------------------------
red_blue
red_blue %>% mutate(percent = 
                      col_count/sum(pull(red_blue, col_count)))


## -----------------------------------------------------------------------------
red_blue %>% mutate(percent = 
                      col_count/sum(pull(drop_na(red_blue), col_count)))

# Should you be dividing by 9 or 6? It depends on your data
# Pay attention to your data and your NAs!


## ---- message=FALSE-----------------------------------------------------------
bike <-jhur::read_bike()

bike %>% count(subType)
bike %>% pull(subType) %>% unique()



## ---- echo=FALSE--------------------------------------------------------------
data_diet <- tibble(Diet = rep(c("A", "B", "B"),
                               times = 4), 
                    Gender = c("Male", 
                               "m",
                               "Other",
                               "F", 
                               "Female",
                               "M", 
                               "f",
                               "O", 
                               "Man",
                               "f",
                               "F",
                               "O"), 
                    Weight_start = sample(100:250, size = 12),
                    Weight_change = sample(-10:20, size = 12))



## -----------------------------------------------------------------------------
data_diet


## -----------------------------------------------------------------------------
data_diet %>%
  count(Gender, Diet)


## ---- eval = FALSE------------------------------------------------------------
## # General Format - this is not code!
## {data_input} %>%
##   mutate({variable_to_fix} = {Variable_fixing, {old_value} = {new_value},
##                                        {another_old_value} = {new_value})
## 


## ---- eval = FALSE------------------------------------------------------------
## 
## data_diet %>%
##   mutate(Gender = recode(Gender, M = "Male",
##                                  m = "Male",
##                                Man = "Male",
##                                  O = "Other",
##                                  f = "Female",
##                                  F = "Female")) %>%
##   count(Gender, Diet)


## ---- eval = FALSE------------------------------------------------------------
## # General Format - this is not code!
## {data_input} %>%
##   mutate({variable_to_fix} = case_when{Variable_fixing}/condition/
##                                               ~ {value_for_cond}))
## 


## -----------------------------------------------------------------------------
data_diet %>% 
  mutate(Gender = case_when(Gender =="M" ~ "Male"))


## -----------------------------------------------------------------------------
data_diet %>% 
  mutate(Gender = case_when(
    Gender %in% c("M", "male", "Man", "m", "Male") ~ "Male",
    Gender %in% c("F", "Female", "f", "female")~ "Female",
    Gender %in% c("O", "Other") ~ "Other"))



## -----------------------------------------------------------------------------

data_diet <-data_diet %>% 
      mutate(Effect = case_when(Weight_change > 0 ~ "Increase",
                                Weight_change == 0 ~ "Same",
                                Weight_change < 0 ~ "Decrease"))

data_diet



## -----------------------------------------------------------------------------
data_diet %>% 
  count(Diet, Effect)


## ---- echo = FALSE------------------------------------------------------------
diet_effect <-data_diet %>% 
  count(Diet, Effect)

data_diet %>% 
  count(Diet, Effect)%>%
  ggplot(aes(x = Effect,y = n, fill = Diet)) + 
  geom_col(position = position_dodge()) +
  labs(y = "Individuals", 
       title = "Effect of diet A & B on participants")




## ---- echo = FALSE------------------------------------------------------------
diet_comb<-diet_effect %>% unite("change" , Diet:Effect, remove = TRUE)


## -----------------------------------------------------------------------------
diet_comb


## -----------------------------------------------------------------------------
diet_comb %>% 
  separate(change, into = c("Diet", "Change"))


## ---- echo = FALSE------------------------------------------------------------
diet_comb<-diet_effect %>% unite("change" , Diet:Effect, remove = TRUE, sep = "_diet ")


## -----------------------------------------------------------------------------
diet_comb %>% 
  separate(change, into = c("Diet", "Change"), sep = " ")


## ----unite_df-----------------------------------------------------------------
df = tibble(id = rep(1:5, 3), visit = rep(1:3, each = 5))
head(df, 4)


## -----------------------------------------------------------------------------
df_united <- df %>% unite(col = "unique_id", id, visit, sep = "_")
head(df_united, 4)


## ----readSal, echo = TRUE, eval = TRUE, message=FALSE-------------------------
Sal = jhur::read_salaries() # or


## -----------------------------------------------------------------------------
head(Sal)


## -----------------------------------------------------------------------------
Sal %>% filter(str_detect(name, "Rawlings"))


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

