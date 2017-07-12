library(haven)
library(dplyr)
# library(sjlabelled)
setwd("~/Downloads/ML_2015_MIS_07102017_1141_105112/mlhr70dt/")
x = read_stata("MLHR70FL.DTA")
head(x$hv024)
table(x$hv024)
xx = as_factor(x)
head(xx$hv024)
table(xx$hv024)

label_table = function(x) {
  labs = sapply(x, function(col) {
    attributes(col)$label
  })
  df = data.frame(var_name = colnames(x),
             label = labs,
             stringsAsFactors = FALSE)
  as.tbl(df)
}
lab_tab = label_table(x)


# library(dhs)
# vlabs = read_do_var_labels(
#   "~/Downloads/ML_2015_MIS_07102017_1141_105112/mlhr70dt/MLHR70FL.DO"
#   )
