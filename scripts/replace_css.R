x = list.files(pattern = "index\\.Rmd", recursive = TRUE)
lines = lapply(x, readLines)
names(lines) = x
pattern = "css: ../../styles.css"
keep = sapply(lines, function(x) {
  sum(grepl(pattern = pattern, x, fixed = TRUE))
})
stopifnot(all(keep %in% c(0, 1)))
lines = lines[keep > 0]
lines = lapply(lines, function(x) {
  sub(pattern = pattern, 
            replacement = "css: ../styles.css", x, fixed = TRUE)
})
mapply(function(x, fname){
  writeLines(text = x, con = fname)
}, lines, names(lines))
