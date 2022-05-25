# Render cheatsheets

# Find anything ending in md
files <- dir(pattern = '[.]md$', recursive = TRUE)

# Extract Cheatsheet files
cheatsheet_files <- files[grepl("cheatsheets", files)]

# loop thru and render all cheatsheet files to pdf
if (length(cheatsheet_files) != 0) {
  for (file in cheatsheet_files) {
    rmarkdown::render(file,
                      output_dir = "modules/cheatsheets",
                      output_format = "pdf_document")
  }
}
