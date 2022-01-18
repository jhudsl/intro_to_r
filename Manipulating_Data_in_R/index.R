## ---- echo = FALSE, include=FALSE---------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")
library(tidyverse)


## ---- echo = FALSE, message=FALSE---------------------------------------------
library(tidyverse)


## ---- fig.alt="A preview of the Data transformation cheatsheet produced by RStudio.", out.width = "80%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Manip_cheatsheet.png")


## ---- fig.alt="A gif visualization of data going from wide to long form.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/tidyr_pivoting.gif")


## ---- echo = FALSE------------------------------------------------------------
ex_wide <- tibble(State = "Alabama",
                 June_vacc_rate = "37.2%",
                 May_vacc_rate = "36.0%",
                 April_vacc_rate = "32.4%"
                     )
ex_long <- pivot_longer(ex_wide, cols = !State)


## ---- echo = FALSE------------------------------------------------------------
ex_wide


## ---- echo = FALSE------------------------------------------------------------
ex_long


## ---- echo = FALSE------------------------------------------------------------
ex_wide <- tibble(State = c("Alabama", "Alaska"),
                 June_vacc_rate = c("37.2%", "47.5%"),
                 May_vacc_rate = c("36.0%", "46.2%"),
                 April_vacc_rate = c("32.4%", "41.7%")
                     )
ex_long <- pivot_longer(ex_wide, cols = !State)


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


## ---- eval=FALSE--------------------------------------------------------------
## {long_data} <- {wide_data} %>% pivot_longer(cols = {columns to pivot},
##                                         names_to = {New column name: contains old column names},
##                                         values_to = {New column name: contains cell values})


## ---- echo = FALSE------------------------------------------------------------
wide_data <- tibble(June_vacc_rate = "37.2%",
                 May_vacc_rate = "36.0%",
                 April_vacc_rate = "32.4%")


## -----------------------------------------------------------------------------
wide_data
long_data <- wide_data %>% pivot_longer(cols = everything(),
                                        names_to = "Month",
                                        values_to = "Rate")
long_data


## ---- message = FALSE---------------------------------------------------------
circ <- jhur::read_circulator()
head(circ, 5)


## -----------------------------------------------------------------------------
long <- circ %>% 
  pivot_longer(starts_with(c("orange","purple","green","banner")),
               names_to = "var", 
               values_to = "number")
long


## -----------------------------------------------------------------------------
long <- circ %>% 
  pivot_longer( !c(day, date, daily),
               names_to = "var", 
               values_to = "number")
long


## -----------------------------------------------------------------------------
long %>% count(var)


## -----------------------------------------------------------------------------
long <- long %>% mutate(
  var = str_replace(var, "Board", "_Board"),
  var = str_replace(var, "Alight", "_Alight"),
  var = str_replace(var, "Average", "_Average") 
)
long


## -----------------------------------------------------------------------------
long <- long %>% 
  separate(var, into = c("line", "type"), sep = "_")
long


## ---- eval=FALSE--------------------------------------------------------------
## {wide_data} <- {long_data} %>%
##   pivot_wider(names_from = {Old column name: contains new column names},
##               values_from = {Old column name: contains new cell values})


## -----------------------------------------------------------------------------
long_data
wide_data <- long_data %>% pivot_wider(names_from = "Month", 
                                       values_from = "Rate") 
wide_data


## -----------------------------------------------------------------------------
long


## -----------------------------------------------------------------------------
wide <- long %>% pivot_wider(names_from = "type", 
                            values_from = "number") 
wide


## ----echo=FALSE---------------------------------------------------------------
data_As <- tibble(State = c("Alabama", "Alaska"),
                 June_vacc_rate = c("37.2%", "47.5%"),
                 May_vacc_rate = c("36.0%", "46.2%"))
data_cold <- tibble(State = c("Maine", "Alaska"),
                    April_vacc_rate = c("32.4%", "41.7%"))


## -----------------------------------------------------------------------------
data_As
data_cold


## ---- fig.alt="A gif showing the inner joining of two simple datasets.", out.width = "70%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/inner_join.gif")


## ----inner_join---------------------------------------------------------------
ij = inner_join(data_As, data_cold)
ij


## ---- fig.alt="A gif showing the left joining of two simple datasets.", out.width = "70%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/left_join.gif")


## ----left_join----------------------------------------------------------------
lj = left_join(data_As, data_cold)
lj


## ---- include=FALSE-----------------------------------------------------------
# install.packages("tidylog")
library(tidylog)


## ----left_join_log------------------------------------------------------------
# install.packages("tidylog")
library(tidylog)
left_join(data_As, data_cold)


## ---- fig.alt="A gif showing the right joining of two simple datasets.", out.width = "70%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/right_join.gif")


## ----right_join---------------------------------------------------------------
rj <- right_join(data_As, data_cold)
rj


## ----right_join2--------------------------------------------------------------
lj2 <- left_join(data_cold, data_As)
lj2


## ---- fig.alt="A gif showing the full joining of two simple datasets.", out.width = "70%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/full_join.gif")


## -----------------------------------------------------------------------------
fj <- full_join(data_As, data_cold)


## -----------------------------------------------------------------------------
fj


## ----echo=FALSE---------------------------------------------------------------
data_As <- tibble(State = c("Alabama", "Alaska"),
                 state_bird = c("wild turkey", "williow ptarmigan"))
data_cold <- tibble(State = c("Maine", "Alaska", "Alaska"),
                    vacc_rate = c("32.4%", "41.7%", "46.2%"),
                    month = c("April", "April", "May"))


## -----------------------------------------------------------------------------
data_As
data_cold


## -----------------------------------------------------------------------------
lj <- left_join(data_As, data_cold)


## -----------------------------------------------------------------------------
lj


## ---- fig.alt="A gif showing how data can be duplicated from one dataset when joining two simple datasets.", out.width = "70%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/left_join_extra.gif")


## -----------------------------------------------------------------------------
unloadNamespace("tidylog")


## -----------------------------------------------------------------------------
duplicated(1:5)
duplicated(c(1:5, 1))
lj %>% mutate(dup_State = duplicated(State))


## ----use_by-------------------------------------------------------------------
full_join(data_As, data_cold, by = "State")


## ----eval=FALSE---------------------------------------------------------------
## full_join(data_As, data_cold, by = c("a" = "b"))


## -----------------------------------------------------------------------------
data_As
data_cold


## -----------------------------------------------------------------------------
A_states <- data_As %>% pull(State)
cold_states <- data_cold %>% pull(State)


## -----------------------------------------------------------------------------
setdiff(A_states, cold_states)
setdiff(cold_states, A_states)

