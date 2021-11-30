rm(list = ls())
library(rmarkdown)
library(knitr)
files <- dir(pattern = '[.]Rmd$', recursive = TRUE)
files = files[ files != "index.Rmd" ]
files = files[ !grepl("HW", files)]
files = files[ basename(files) != "illusion.Rmd" ]

source("scripts/renderFile.R")

## Render all Rmd files in this directory
for (file in files) {
  renderFile(file)
}
