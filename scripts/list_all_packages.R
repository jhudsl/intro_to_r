### find and install all packages
rm(list = ls())

ss = function(x,pattern,slot=1,...) {
  sapply(strsplit(x = x, split = pattern, ...), "[", slot)
}

## find RMDs
files <- dir(pattern = '[.]R', recursive = TRUE)
files = files[ !grepl("scratch", files)]
files = files[ !grepl("all_packages", files)]
# files = files[ files != "index.Rmd" ]
# files = files[ !grepl("HW", files)]
files = files[ basename(files) != "illusion.Rmd" ]

## read in code
fileList = lapply(files, scan, what = "character()", sep="\n")
allFiles = unlist(fileList)
allFiles = trimws(allFiles)
libCalls = allFiles[grep("^(library|require)", allFiles)]
theLibs = ss(ss(libCalls, "(", 2, fixed = TRUE), ")", fixed=TRUE)
theLibs = ss(theLibs, ",", 1, fixed = TRUE)
theLibs = ss(theLibs, '"', 1, fixed = TRUE)
theLibs = ss(theLibs, " ", 1, fixed = TRUE)
theLibs = unique(theLibs)
theLibs = sort(theLibs)

writeLines(theLibs, con = "./resources/all_the_packages.txt")

sapply(theLibs, library, character.only = TRUE)

####################################
# Getting functions for cheatsheet
####################################
library(NCmisc)
all_r = list.files(pattern = "[.]R$", recursive = TRUE, full.names = TRUE)
all_r = all_r[ !grepl("scratch", all_r)]
all_r = all_r[ !grepl("all_packages", all_r)]
xall_func = all_func = sapply(all_r, list.functions.in.file)

all_func = xall_func
quick = function(r) {
  res = mapply(function(x, y) { 
    x[ !grepl(":", x)] = ""
    cbind(package = x, func = y)
  }, names(r), r, SIMPLIFY = FALSE)
  res = do.call("rbind", res)
  res
}
all_func = sapply(all_func, quick)
all_func = do.call("rbind", all_func)
all_func = data.frame(all_func, stringsAsFactors = FALSE)
all_func$package = gsub('"', "", all_func$package)
all_func$package = gsub('c(', "", all_func$package, fixed = TRUE)
all_func$package = gsub('(', "", all_func$package, fixed = TRUE)
all_func$package = gsub(')', "", all_func$package, fixed = TRUE)

all_func = unique(all_func)
all_func = all_func %>% 
  tidyr::separate(package, 
                  into = paste0("pack", 1:5),
                  sep = ",") %>% 
  tidyr::gather(number, package, starts_with("pack")) %>% 
  dplyr::select(-number) %>% 
  dplyr::mutate(package = str_replace(package, "package:", ""))
all_func = all_func %>% 
  dplyr::filter(!is.na(package)) %>% 
  dplyr::mutate(package = trimws(package)) %>% 
  distinct() %>% 
  dplyr::arrange(package, func)
all_func = all_func %>% 
  dplyr::filter(
    !(package == "" | func %in% c("f", "renamer", "renderFile", 
                                  "return2", "return2a", "return2b", 
                                  "return2c", "set", "sqdif", "ss"))
  )

package = NULL
lib.loc = NULL
verbose = TRUE
topic = "select"
package = "dplyr"

get_help_desc = function(topic, package, lib.loc = NULL, verbose = TRUE){
  print(topic)
  
  pkgpaths <- find.package(package, lib.loc, verbose = verbose)
  file <- utils:::index.search(topic, pkgpaths, TRUE)
  if (!length(file)) {
    warning(gettextf("no help found for %s", sQuote(topic)), 
            domain = NA)
    return(invisible())
  }
  packagePath <- dirname(dirname(file))
  pkgname <- basename(packagePath)
  lib <- dirname(packagePath)
  tf <- tempfile("Rex")
  tools::Rd2latex(utils:::.getHelpFile(file), tf)
  res = readLines(tf)
  match = grep("\\\\(begin|end)\\{Description\\}", res)
  if (length(match) == 0) {
    res = ""
  } else {
    res = res[seq(match[1] + 1, match[2] - 1)]
  }
  res
}

helps = mapply(function(topic, package) {
  get_help_desc(topic, package)
}, all_func$func, all_func$package)

xhelps = helps

helps = xhelps
helps = lapply(helps, function(x) {
  paste(x, collapse = " ")
})

helps = unlist(helps)
all_func$description = helps

readr::write_csv(all_func, file = "./resources/all_the_functions.csv")

## AAAAAND INSTALL!!!
# install.packages(theLibs)
