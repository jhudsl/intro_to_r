## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)


## ----factor1------------------------------------------------------------------
x <- c("red", "red", "blue", "yellow", "blue")
class(x)

x_fact = factor(x)  # factor() is a function
class(x_fact)
x_fact


## ----factor1b-----------------------------------------------------------------
levels(x_fact)


## ---- fig.alt="Forcats hex sticker", out.width = "30%", echo = FALSE, fig.align='center'----
knitr::include_graphics("https://github.com/tidyverse/forcats/raw/main/man/figures/logo.png")


## -----------------------------------------------------------------------------
set.seed(123)
data_highschool <- tibble(absences = 
                            sample(0:7, size = 32, replace = TRUE), 
                          grade = 
                            rep(c("Sophomore",
                                  "Freshman", 
                                  "Junior", 
                                  "Senior"), 8))


## -----------------------------------------------------------------------------
head(data_highschool)


## ---- fig.height= 3-----------------------------------------------------------
data_highschool %>%
  ggplot(mapping = aes(x = grade, y = absences)) +
  geom_boxplot()


## -----------------------------------------------------------------------------
class(data_highschool$grade)
data_highschool_fct <- data_highschool %>% 
  mutate(grade = factor(grade, levels = 
                          c("Freshman", "Sophomore", 
                            "Junior", "Senior")))
head(data_highschool_fct)


## ---- fig.height= 3-----------------------------------------------------------
data_highschool_fct %>%
  ggplot(mapping = aes(x = grade, y = absences)) +
  geom_boxplot()


## ---- size="tiny"-------------------------------------------------------------
data_highschool %>% arrange(grade) %>% head(19)


## ---- size = 'tiny'-----------------------------------------------------------
data_highschool_fct %>% arrange(grade) %>% head(19)


## -----------------------------------------------------------------------------
data_highschool %>% group_by(grade) %>% tally(absences)


## -----------------------------------------------------------------------------
data_highschool_fct %>% group_by(grade) %>% tally(absences)


## -----------------------------------------------------------------------------
data_highschool %>% group_by(grade) %>% summarise(mean = mean(absences))


## -----------------------------------------------------------------------------
data_highschool_fct %>% group_by(grade) %>% summarise(mean = mean(absences))


## ---- fig.height= 3-----------------------------------------------------------
library(forcats)

data_highschool_fct %>%
  ggplot(mapping = aes(x = grade, y = absences)) +
  geom_boxplot()


## ---- fig.height= 3-----------------------------------------------------------
library(forcats)

data_highschool_fct %>%
  ggplot(mapping = aes(x = forcats::fct_reorder(grade, absences), 
                       y = absences)) +
  geom_boxplot()


## -----------------------------------------------------------------------------
set.seed(1956)
data_highschool_fct <- 
  data_highschool_fct %>% 
  mutate("tardy" = sample(0:7, size = 32, replace = TRUE))

data_highschool_fct


## ---- echo = FALSE------------------------------------------------------------

absences<- data_highschool_fct %>%
  ggplot(mapping = aes(x = forcats::fct_reorder(grade, absences), 
                       y = absences)) +
  geom_boxplot(fill = "lightgreen")


tardy<- data_highschool_fct %>%
  ggplot(mapping = aes(x = forcats::fct_reorder(grade, tardy), 
                       y = tardy)) +
  geom_boxplot(fill = "violet")

library(patchwork)
absences + tardy



## ---- echo = FALSE------------------------------------------------------------

absences<- data_highschool_fct %>%
  ggplot(mapping = aes(x = forcats::fct_reorder(grade, absences), 
                       y = absences)) +
  geom_boxplot(fill = "lightgreen")


tardy<- data_highschool_fct %>%
  ggplot(mapping = aes(x = forcats::fct_reorder(grade, absences), 
                       y = tardy)) +
  geom_boxplot(fill = "violet")

library(patchwork)
absences + tardy




## -----------------------------------------------------------------------------
data_highschool_fct %>% pull(grade) %>% fct_count(prop= TRUE)


