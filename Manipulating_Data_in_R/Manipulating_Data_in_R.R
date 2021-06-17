## ---- echo = FALSE, include=FALSE---------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")
library(tidyverse)


## ---- echo = FALSE, message=FALSE---------------------------------------------
library(tidyverse)


## ---- echo = FALSE------------------------------------------------------------
ex_wide = tibble(State = "Alabama",
                 June_vacc_rate = "37.2%",
                 May_vacc_rate = "36.0%",
                 April_vacc_rate = "32.4%"
                     )
ex_long = pivot_longer(ex_wide, cols = c(June_vacc_rate, May_vacc_rate, April_vacc_rate))


## ---- echo = FALSE------------------------------------------------------------
ex_wide


## ---- echo = FALSE------------------------------------------------------------
ex_long


## ---- echo = FALSE------------------------------------------------------------
ex_wide = tibble(State = c("Alabama", "Alaska"),
                 June_vacc_rate = c("37.2%", "47.5%"),
                 May_vacc_rate = c("36.0%", "46.2%"),
                 April_vacc_rate = c("32.4%", "41.7%")
                     )
ex_long = pivot_longer(ex_wide, cols = c(June_vacc_rate, May_vacc_rate, April_vacc_rate))


## ---- echo = FALSE------------------------------------------------------------
ex_wide


## ---- echo = FALSE------------------------------------------------------------
ex_long


## ---- fig.alt="Wide versus long data rearanges the position of column names and row content.", out.width = "60%", echo = FALSE, fig.align='center'----
knitr::include_graphics("../images/pivot.jpg")


## ---- echo = FALSE------------------------------------------------------------
ex_wide


## ---- echo = FALSE------------------------------------------------------------
ex_long


## ---- message = FALSE---------------------------------------------------------
circ = read_csv(
  paste0("http://jhudatascience.org/intro_to_r/",
         "data/Charm_City_Circulator_Ridership.csv"))
head(circ, 5)


## -----------------------------------------------------------------------------
long = circ %>% 
  pivot_longer(starts_with(c("orange","purple","green","banner")),
               names_to = "var", values_to = "number")
long


## -----------------------------------------------------------------------------
long = circ %>% pivot_longer(!c(day, date, daily),
                    names_to = "var", values_to = "number")
long


## -----------------------------------------------------------------------------
long %>% count(var)


## -----------------------------------------------------------------------------
long = long %>% mutate(
  var = str_replace(var, "Board", "_Board"),
  var = str_replace(var, "Alight", "_Alight"),
  var = str_replace(var, "Average", "_Average") 
)
long


## -----------------------------------------------------------------------------
long = 
  long %>% 
  separate(var, into = c("line", "type"), sep = "_")
long


## -----------------------------------------------------------------------------
reunited = long %>% 
  unite(var, line, type, sep = "_")  
reunited


## -----------------------------------------------------------------------------
wide = long %>% pivot_wider(names_from = "type", 
                            values_from = "number") 
wide


## ----merging------------------------------------------------------------------
base <- tibble(id = 1:10, Age = seq(55,60, length=10))
head(base, 2)


## -----------------------------------------------------------------------------
visits <- tibble(id = rep(2:11, 3), visit= rep(1:3, 10),
                    Outcome = seq(10,50, length=30))
head(visits, 2)


## ----inner_join---------------------------------------------------------------
ij = inner_join(base, visits)
dim(ij)
head(ij)


## ----left_join----------------------------------------------------------------
lj = left_join(base, visits)
dim(lj)
head(lj)


## ---- include=FALSE-----------------------------------------------------------
library(tidylog)


## ----left_join_log------------------------------------------------------------
# install.packages("tidylog")
library(tidylog)
left_join(base, visits)


## ----right_join---------------------------------------------------------------
rj = right_join(base, visits)


## ----right_join2--------------------------------------------------------------
lj2 = left_join(visits, base)


## ----full_join----------------------------------------------------------------
fj = full_join(base, visits)


## -----------------------------------------------------------------------------
# fj = full_join(base, visits)
head(fj, 10)


## ----include=FALSE------------------------------------------------------------
unloadNamespace("tidylog")


## -----------------------------------------------------------------------------
duplicated(1:5)
duplicated(c(1:5, 1))
fj %>% mutate(dup_id = duplicated(id))


## ----use_by-------------------------------------------------------------------
# for multiple, by = c(col1, col2)
head(full_join(base, visits, by = "id"))


## -----------------------------------------------------------------------------
head(wide, 3)
not_namat = wide %>% select(Alightings, Average, Boardings)
not_namat = !is.na(not_namat)
head(not_namat, 2)
wide$good = rowSums(not_namat) > 0


## -----------------------------------------------------------------------------
wide = wide %>% filter(good) %>% select(-good)
head(wide)


## -----------------------------------------------------------------------------
long = long %>% filter(!is.na(number) & number > 0)
first_and_last = long %>% arrange(date) %>% # arrange by date
  filter(type == "Boardings") %>% # keep boardings only
  group_by(line) %>% # group by line
  slice( c(1, n())) # select ("slice") first and last (n() command) lines
first_and_last %>%  head(4)


## ----merging2-----------------------------------------------------------------
merged.data <- merge(base, visits, by = "id")
head(merged.data, 5)
dim(merged.data)


## ----mergeall-----------------------------------------------------------------
all.data <- merge(base, visits, by = "id", all = TRUE)
tail(all.data)
dim(all.data)

