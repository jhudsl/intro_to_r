## ---- echo = FALSE, include=FALSE---------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")
library(tidyverse)


## ---- echo = FALSE, message=FALSE---------------------------------------------
library(tidyverse)


## ---- echo = FALSE------------------------------------------------------------
ex_wide = tibble(id = 1:2,
                     visit1 = c(10, 5),
                     visit2 = c(4, 6),
                     visit3 = c(3, NA)
                     )
ex_long = tibble(id = c(rep(1, 3), rep(2, 2)),
                     visit = c(1:3, 1:2),
                     value = c(10, 4, 3, 5, 6))


## ---- echo = FALSE------------------------------------------------------------
ex_wide


## ---- echo = FALSE------------------------------------------------------------
ex_long


## ---- fig.alt="Wide versus long data rearanges the position of column names and row content.", out.width = "60%", echo = FALSE, fig.align='center'----
knitr::include_graphics("../images/pivot.jpg")


## ---- message = FALSE---------------------------------------------------------
circ = read_csv(
  paste0("http://jhudatascience.org/intro_to_r/",
         "data/Charm_City_Circulator_Ridership.csv"))
head(circ, 2)
class(circ$date)


## ---- message = FALSE---------------------------------------------------------
library(lubridate) # great for dates!


## ---- message= FALSE----------------------------------------------------------
sum(is.na(circ$date))
sum( circ$date == "")
circ = mutate(circ, date = mdy(date))
sum( is.na(circ$date) ) # all converted correctly
head(circ$date, 3)
class(circ$date)


## -----------------------------------------------------------------------------
long = pivot_longer(circ, !c(day, date, daily), # NOT pivoting these
                    names_to = "var", values_to = "number")
head(long, 4)


## -----------------------------------------------------------------------------
long = pivot_longer(circ, 
                    starts_with(c("orange","purple","green","banner")),
                    names_to = "var", values_to = "number")
long


## -----------------------------------------------------------------------------
long %>% count(var)


## -----------------------------------------------------------------------------
long = long %>% mutate(
  var = var %>% 
    str_replace("Board", "_Board") %>% 
    str_replace("Alight", "_Alight") %>% 
    str_replace("Average", "_Average") 
)
long %>% count(var)


## -----------------------------------------------------------------------------
long = separate(long, var, into = c("line", "type"), sep = "_")
head(long, 2)
unique(long$line)
unique(long$type)


## -----------------------------------------------------------------------------
reunited = long %>% 
  unite(col = var, line, type, sep = "_")  
reunited %>% select(day, var) %>% head(3) %>% print


## -----------------------------------------------------------------------------
# have to remove missing days
wide = long %>% filter(!is.na(date))
wide = wide %>% pivot_wider(names_from = "type", 
                            values_from = "number") 
head(wide)


## ----merging------------------------------------------------------------------
base <- tibble(id = 1:10, Age = seq(55,60, length=10))
head(base, 2)


## -----------------------------------------------------------------------------
visits <- tibble(id = c(rep(1:8, 3), 11), visit= c(rep(1:3, 8), 3),
                    Outcome = seq(10,50, length=25))
tail(visits, 2)


## ----inner_join---------------------------------------------------------------
ij = inner_join(base, visits)
dim(ij)
tail(ij)


## ----left_join----------------------------------------------------------------
lj = left_join(base, visits)
dim(lj)
tail(lj)


## ---- include=FALSE-----------------------------------------------------------
library(tidylog)


## ----left_join_log------------------------------------------------------------
library(tidylog)
left_join(base, visits)


## ----right_join---------------------------------------------------------------
rj = right_join(base, visits)
tail(rj, 3)


## ----right_join2--------------------------------------------------------------
rj2 = right_join(visits, base)
tail(rj2, 3)

## ----right_join_arrange, echo = FALSE-----------------------------------------
rj2 = arrange(rj2, id, visit) %>% select(id, visit, Outcome, Age)
lj = arrange(lj, id, visit) %>% select(id, visit, Outcome, Age)

## ----right_join_arrange_out---------------------------------------------------
identical(rj2, lj) ## after some rearranging


## ----full_join----------------------------------------------------------------
fj = full_join(base, visits)
tail(fj, 4)


## ----include=FALSE------------------------------------------------------------
unloadNamespace("tidylog")


## ----use_by-------------------------------------------------------------------
base = base %>% mutate(x = 5)
visits = visits %>% mutate(x = 4)
head(full_join(base, visits))
head(full_join(base, visits, by = "id"))
head(full_join(base, visits, by = "id", suffix = c("_base", "_visit")))


## -----------------------------------------------------------------------------
duplicated(1:5)
duplicated(c(1:5, 1))
fj %>% mutate(dup_id = duplicated(id))


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

