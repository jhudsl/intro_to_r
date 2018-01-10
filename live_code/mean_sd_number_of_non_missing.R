library(tidyverse)
library(broom)

# the GROUPING_VARIABLES is the grouping variable
# VARIABLE is the summary variable
dataset = NULL
### getting number of records, mean/sd non-missing
dataset %>% 
  group_by(GROUPING_VARIABLES) %>% 
  summarize(n = n(),
            mean_value = mean(VARIABLE, na.rm = TRUE),
            sd_value = sd(VARIABLE, na.rm = TRUE),
            n_non_na = sum(!is.na(VARIABLE)))

# run quantiles
dataset %>% 
  group_by(GROUPING_VARIABLES) %>% 
  do(tidy(quantile(VARIABLE)))

# if you want quantiles on the columns 
dataset %>% 
  group_by(GROUPING_VARIABLES) %>% 
  do(t(quantile(VARIABLE)))

# same as quantiles as columns, but column names are %
dataset %>% 
  group_by(GROUPING_VARIABLES) %>% 
  do(
    as_data_frame(t(quantile(VARIABLE)))
  )




