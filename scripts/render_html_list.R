# Render resources

# --------- Combine html -> pdf ---------

# Read in all files needed

files <- readr::read_csv("lecture_files.csv", show_col_types = FALSE)

if(nrow(files) > 0) {
  files$files <- stringr::str_replace_all(files$files, pattern = ".Rmd", replacement = "")
  files$files <- stringr::str_replace_all(files$files, pattern = "modules/.*/", replacement = "")
  
  # Don't need to render HWs
  files <- files[!grepl("homework", files$files),]
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
