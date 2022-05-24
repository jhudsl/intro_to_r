# Render modules

# Find anything ending in Rmd
files <- dir(pattern = '[.]Rmd$', recursive = TRUE)

# Lab files should be in a /lab subdirectory within modules/
lab_files <- files[grepl("modules/.*/lab", files)]

# Lecture files are everything else
lecture_files <-
  files[grepl("modules/.*", files) &
          !grepl("modules/.*/lab", files)]

# loop thru and render all lab files to html
# Specific module name will be pulled out based on the dir name in modules/
for (i in 1:length(lab_files)) {
  module_name <- stringr::str_split(lab_files, pattern = '/')[[i]][2]
  rmarkdown::render(lab_files[i],
                    output_dir = paste0("docs/modules/", module_name, "/lab"))
}

# loop thru and render all lab files to html and pdf (pagedown)
# Specific module name will be pulled out based on the dir name in modules/
for (i in 1:length(lecture_files)) {
  module_name <- stringr::str_split(lecture_files, pattern = '/')[[i]][2]
  rmarkdown::render(lecture_files[i], output_dir = paste0("docs/modules/", module_name))
  pagedown::chrome_print(paste0("docs/modules/", module_name, "/index.html"))
}
