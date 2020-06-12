rm(list = ls())
library(plyr)
library(dplyr)
pwd = getwd()
x = list.files(pattern = ".Rmd$", recursive = TRUE)
x = x[grepl("lab", tolower(x))]

sapply(x, function(x) {
  out = sub(".Rmd$", ".R", x)
  knitr::purl(input = x, output = out)
  })

sapply(x, rmarkdown::render, envir = new.env())


x = list.files(pattern = ".R$", recursive = TRUE)
x = x[grepl("lab", tolower(x))]
x = x[ !grepl("run_labs", x)]
r = x[1]
# all_in_mem = ls()
# sapply(x, function(r) {
#   # wd = dirname(r)
#   # setwd(wd)
#   # on.exit(setwd)
#   print(r)
#   source(r, local = TRUE)
# })
