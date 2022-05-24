# Render module detail files

# Find anything ending in Rmd
files <- dir(pattern = '[.]Rmd$', recursive = TRUE)

# Extract module detail files
detail_files <- files[grepl("module_details", files)]

# loop thru and render all module detail files to html
if (length(detail_files) != 0) {
  for (file in detail_files) {
    rmarkdown::render(file,
                      output_dir = "docs/module_details")
  }
}
