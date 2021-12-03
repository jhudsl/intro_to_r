
library(tidyverse)

set.seed(123)
data_highschool <- tibble(absences = sample(0:7, size = 32, replace = TRUE), grade = rep(c("Sophomore","Freshman",  "Junior", "Senior"), 8))
data_highschool

data_highschool %>%
  ggplot(mapping = aes(x = grade, y = absences)) +
  geom_boxplot()

class(data_highschool$grade)
data_highschool_fct <- data_highschool %>% 
  mutate(grade = factor(grade, levels = c("Freshman", "Sophomore", "Junior", "Senior")))
data_highschool_fct

data_highschool_fct %>%
  ggplot(mapping = aes(x = grade, y = absences)) +
  geom_boxplot()

data_highschool %>% arrange(grade)
data_highschool_fct %>% arrange(grade)

data_highschool %>% group_by(grade) %>% summarise(mean = mean(absences))

data_highschool_fct %>% group_by(grade) %>% summarise(mean = mean(absences))


