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

files_quotes <- paste0("'",files$files,"'")
combined_files <- paste0(files_quotes, collapse = ", ")

readr::write_lines(
  paste0("[", combined_files, "]"),
  "files.txt", 
  sep = ""
)
