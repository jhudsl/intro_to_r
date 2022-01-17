## ----setup, echo = FALSE, message = FALSE, warning=FALSE----------------------
library(tidyverse)
source("../../scripts/utils.R")
schedule <- read_markdown("../_schedule_table.Rmd")


## ---- results='asis', echo = FALSE, message=FALSE, warning=FALSE--------------
# The str_replace_all creates an absolute url to linked documents. Important because there are word and pdf rendered versions of the syllabus.
# The filter() step removes all dates but this date to make a smaller table.
pander::pandoc.table(
  schedule  %>%
    mutate(across(
      .fns = ~ str_replace_all(., "\\./", "https://jhudatascience.org/intro_to_R_class/")
    )) %>%
    filter(
      row_number() >= which(str_detect(schedule$`**Day**`, "\\[Day 6\\]")) &
        row_number() < which(str_detect(schedule$`**Day**`, "\\[Day 7\\]"))
    ),
  missing = "",
  split.tables = Inf,
  style = "rmarkdown"
)

