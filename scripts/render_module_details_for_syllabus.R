# Render modules

# Find anything ending in Rmd
files <- dir(pattern = '[.]Rmd$', recursive = TRUE)

# Extract Cheatsheet files
detail_files <- files[grepl("module_details", files)]

# loop thru and render all cheatsheet files to pdf
if (length(detail_files) != 0) {
  for (file in detail_files) {
    rmarkdown::render(file,
                      output_dir = "docs/module_details")
  }
}
