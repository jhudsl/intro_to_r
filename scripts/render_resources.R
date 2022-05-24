# Render resources

# Find anything ending in md and extract
files <- dir(pattern = '[.]md$', recursive = TRUE)
res_files_md <- files[grepl("resources", files) &
                        !grepl("docs", files)]

# Find anything ending in Rmd and extract
files <- dir(pattern = '[.]Rmd$', recursive = TRUE)
res_files_Rmd <- files[grepl("resources", files) &
                         !grepl("docs", files)]

res_files <- c(res_files_md, res_files_Rmd)

# loop thru and render all resources files to pdf
if (length(res_files) != 0) {
  for (file in res_files) {
    rmarkdown::render(file,
                      output_dir = "docs/resources",
                      output_format = "pdf_document")
  }
}
