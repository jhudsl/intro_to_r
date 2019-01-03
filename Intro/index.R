## ---- echo = FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")

## ------------------------------------------------------------------------
library(jhur)
head(read_yts()) # read youth tobacco data

## ---- packageInstall, eval=FALSE-----------------------------------------
## install.packages("remotes")
## remotes::install_github("muschellij2/jhur")

