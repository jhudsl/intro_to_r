## ----setup, echo = FALSE, message = FALSE-------------------------------------
library(tidyverse)


## ---- child="_child_schedule.Rmd"---------------------------------------------




## ---- results='asis', echo = FALSE, message=FALSE, warning = FALSE------------
# The str_replace_all creates an absolute url to linked documents since there are word and pdf rendered versions of the syllabus
source("../scripts/utils.R")
pander::pandoc.table(
  read_markdown("_schedule_table.Rmd")  %>%
    mutate(across(
      .fns = ~ str_replace_all(., "\\./", "https://jhudatascience.org/intro_to_R_class/")
    )),
  missing = "",
  split.tables = Inf,
  style = "rmarkdown"
)


## ---- child="_child_assignments.Rmd"------------------------------------------




## ---- child="_child_code_of_coduct.Rmd"---------------------------------------



