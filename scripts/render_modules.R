# Render modules

# Find anything ending in Rmd
files <- dir(pattern = '[.]Rmd$', recursive = TRUE)

print(file.info(files))

# Find only the Rmds that have been updated since last rendering
last_rendered <- readr::read_rds(file = "docs/last_rendered_timestamp.rds")
print(paste0("Last module rmarkdown render time was ", last_rendered))
files <-
  dplyr::filter(file.info(files), mtime > readr::read_rds(file = "docs/last_rendered_timestamp.rds"))
filenames <- rownames(files)

# Lab files should be in a /lab subdirectory within modules/
lab_files <- filenames[grepl("modules/.*/lab", filenames)]

# Lecture files are everything else in modules
lecture_files <-
  filenames[grepl("modules/.*", filenames) &
              !grepl("modules/.*/lab", filenames)]

# loop thru and render all lab files to html
# Specific module name will be pulled out based on the dir name in modules/
try(for (i in 1:length(lab_files)) {
  module_name <- stringr::str_split(lab_files, pattern = '/')[[i]][2]
  rmarkdown::render(lab_files[i],
                    output_dir = paste0("docs/modules/", module_name, "/lab"))
}, TRUE)

# loop thru and render all lab files to html
# Specific module name will be pulled out based on the dir name in modules/
try(for (i in 1:length(lecture_files)) {
  module_name <-
    stringr::str_split(lecture_files, pattern = '/')[[i]][2]
  rmarkdown::render(lecture_files[i], output_dir = paste0("docs/modules/", module_name))
}, TRUE)

# Save timestamp to avoid re-rendering all files next time
last_rendered <- Sys.time()
write_rds(last_rendered, file = "docs/last_rendered_timestamp.rds")
