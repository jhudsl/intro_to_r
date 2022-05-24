# Render modules

# Find anything ending in Rmd
files <- dir(pattern = '[.]Rmd$', recursive = TRUE)

# Lab files should be in a /lab subdirectory within modules/
lab_files <- files[grepl("modules/.*/lab", files)]

# Lecture files are everything else in modules
lecture_files <-
  files[grepl("modules/.*", files) &
          !grepl("modules/.*/lab", files)]

# loop thru and render all lab files to html
# Specific module name will be pulled out based on the dir name in modules/
if (length(lab_files) != 0) {
  for (i in 1:length(lab_files)) {
    module_name <- stringr::str_split(lab_files, pattern = '/')[[i]][2]
    rmarkdown::render(lab_files[i],
                      output_dir = paste0("modules/", module_name, "/lab"))
  }
}

# loop thru and render all lecture files to html
# Specific module name will be pulled out based on the dir name in modules/
if (length(lecture_files) != 0) {
  for (i in 1:length(lecture_files)) {
    module_name <-
      stringr::str_split(lecture_files, pattern = '/')[[i]][2]
    rmarkdown::render(lecture_files[i],
                      output_dir = paste0("modules/", module_name))
  }
}
