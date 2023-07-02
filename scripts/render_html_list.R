# Render resources

# --------- Combine html -> pdf ---------

# Read in all files needed

files <- readr::read_csv("lecture_files.csv")

if(nrow(files) > 0) {
  files$files <- sapply(files$files, gsub, pattern = ".Rmd", replacement = "")
  files$files <- sapply(files$files, gsub, pattern = "modules/.*/", replacement = "")
} else {
  # Just render the Intro files if no others to render.
  files <- data.frame(
    files = "Intro"
  )
}

readr::write_lines(files$files, "files.txt")
