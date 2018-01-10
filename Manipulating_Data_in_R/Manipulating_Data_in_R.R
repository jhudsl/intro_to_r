## ---- echo = FALSE, include=FALSE----------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")
library(tidyverse)

## ---- echo = FALSE, message=FALSE----------------------------------------
library(tidyverse)

## ---- echo = FALSE-------------------------------------------------------
ex_wide = data.frame(id = 1:2,
                     visit1 = c(10, 5),
                     visit2 = c(4, 6),
                     visit3 = c(3, NA)
                     )
ex_long = data.frame(id = c(rep(1, 3), rep(2, 2)),
                     visit = c(1:3, 1:2),
                     value = c(10, 4, 3, 5, 6))

## ---- echo = FALSE-------------------------------------------------------
ex_wide

## ---- echo = FALSE-------------------------------------------------------
ex_long

## ---- message = FALSE----------------------------------------------------
circ = read_csv(
  paste0("http://johnmuschelli.com/intro_to_r/",
         "data/Charm_City_Circulator_Ridership.csv"))
head(circ, 2)
class(circ$date)

## ---- message = FALSE----------------------------------------------------
library(lubridate) # great for dates!

## ---- message= FALSE-----------------------------------------------------
sum(is.na(circ$date))
sum( circ$date == "")
circ = mutate(circ, date = mdy(date))
sum( is.na(circ$date) ) # all converted correctly
head(circ$date, 3)
class(circ$date)

## ------------------------------------------------------------------------
long = gather(circ, key = "var", value = "number", 
              -day, -date, -daily)
head(long, 4)

## ------------------------------------------------------------------------
long = gather(circ, key = "var", value = "number", 
              starts_with("orange"), starts_with("purple"),
              starts_with("green"), starts_with("banner"))
head(long, 4)

## ------------------------------------------------------------------------
table(long$var)

## ------------------------------------------------------------------------
long = long %>% mutate(
  var = var %>% str_replace("Board", ".Board") %>% 
    str_replace("Alight", ".Alight") %>% 
    str_replace("Average", ".Average") 
)
table(long$var)

## ------------------------------------------------------------------------
long = separate(long, var, into = c("line", "type"), 
                 sep = "[.]")
head(long, 2)
unique(long$line)
unique(long$type)

## ------------------------------------------------------------------------
reunited = long %>% 
  unite(col = var, line, type, sep = ".")  
reunited %>% select(day, var) %>% head(3) %>% print

## ---- eval = FALSE-------------------------------------------------------
## cn = colnames(circ)
## cn = cn %>%
##   str_replace("Board", ".Board") %>%
##   str_replace("Alight", ".Alight") %>%
##   str_replace("Average", ".Average")
## colnames(circ) = cn # then reshape using gather!

## ------------------------------------------------------------------------
# have to remove missing days
wide = filter(long, !is.na(date))
wide = spread(wide, type, number)
head(wide)

## ----merging-------------------------------------------------------------
base <- data.frame(id = 1:10, Age= seq(55,60, length=10))
base[1:2,]
visits <- data.frame(id = rep(1:8, 3), visit= rep(1:3, 8),
                    Outcome = seq(10,50, length=24))
visits[1:2,]

## ----inner_join----------------------------------------------------------
ij = inner_join(base, visits)
dim(ij)
tail(ij)

## ----left_join-----------------------------------------------------------
lj = left_join(base, visits)
dim(lj)
tail(lj)

## ----right_join----------------------------------------------------------
rj = right_join(base, visits)
dim(rj)
tail(rj)

## ----right_join2---------------------------------------------------------
rj2 = right_join(visits, base)
dim(rj2)
tail(rj2)

## ----right_join_arrange, echo = FALSE------------------------------------
rj2 = arrange(rj2, id, visit) %>% select(id, visit, Outcome, Age)
lj = arrange(lj, id, visit) %>% select(id, visit, Outcome, Age)

## ----right_join_arrange_out----------------------------------------------
identical(rj2, lj) ## after some rearranging

## ----full_join-----------------------------------------------------------
fj = full_join(base, visits)
dim(fj)
tail(fj)

## ------------------------------------------------------------------------
duplicated(1:5)
duplicated(c(1:5, 1))

## ------------------------------------------------------------------------
head(wide, 3)
not_namat = !is.na(select(wide, Alightings, Average, Boardings))
head(not_namat, 2)
wide$good = rowSums(not_namat) > 0

## ------------------------------------------------------------------------
wide = filter(wide, good) %>% select(-good)
head(wide)

## ------------------------------------------------------------------------
long = long %>% filter(!is.na(number) & number > 0)
first_and_last = long %>% arrange(date) %>% # arrange by date
  filter(type == "Boardings") %>% # keep boardings only
  group_by(line) %>% # group by line
  slice( c(1, n())) # select ("slice") first and last (n() command) lines
first_and_last %>%  head(4)

## ----merging2------------------------------------------------------------
merged.data <- merge(base, visits, by = "id")
merged.data[1:5,]
dim(merged.data)

## ----mergeall------------------------------------------------------------
all.data <- merge(base, visits, by = "id", all = TRUE)
tail(all.data)
dim(all.data)

