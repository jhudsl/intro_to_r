### find and install all packages
rm(list = ls())

ss = function(x,pattern,slot=1,...) sapply(strsplit(x = x, split = pattern, ...), "[", slot)

## find RMDs
files <- dir(pattern = '[.]Rmd$', recursive = TRUE)
files = files[ files != "index.Rmd" ]
files = files[ !grepl("HW", files)]
files = files[ basename(files) != "illusion.Rmd" ]

## read in code
fileList = lapply(files, scan, what="character()", sep="\n")
allFiles = unlist(fileList)
libCalls = allFiles[grep("^library", allFiles)]
theLibs = ss(ss(libCalls, "(", 2, fixed=TRUE), ")",fixed=TRUE)
theLibs = unique(theLibs)

## AAAAAND INSTALL!!!
install.packages(theLibs)
