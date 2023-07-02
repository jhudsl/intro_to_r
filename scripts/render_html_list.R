# Render resources

# --------- Combine html -> pdf ---------

# Read in all files needed

files <- rbind(
  read.csv("lecture_files.csv"),
  read.csv("lab_files.csv"),
  read.csv("cheatsheet_files.csv")
)[2]

files$html <- sapply(files$files, gsub, pattern = ".Rmd", replacement = ".html")
files$pdf <- sapply(files$files, gsub, pattern = ".Rmd", replacement = ".pdf")

readr::write_lines(files$html, "html.txt")
readr::write_lines(files$pdf, "pdf.txt")
