# Render resources

# --------- Combine html -> pdf ---------

# Read in all files needed

files <- readr::read_csv("lecture_files.csv")

if(nrow(files) > 0) {
  files$files <- sapply(files$files, gsub, pattern = ".Rmd", replacement = "")
} else {
  # Just render the Intro files if no others to render.
  files <- data.frame(
    files = "modules/Intro/Intro"
  )
}

readr::write_lines(files$files, "files.txt")
