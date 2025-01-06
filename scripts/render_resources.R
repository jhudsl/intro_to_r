# Render resources

# --------- Check Files ---------

option_list <- list(
  optparse::make_option(
    c("--files"),
    type = "character",
    default = NULL,
    help = "files that have been changed",
  )
)

# Read the files argument
opt_parser <- optparse::OptionParser(option_list = option_list)
opt <- optparse::parse_args(opt_parser)
files <- opt$files

if (files == "all"){
  # If no argument supplied, do all
  files <- list.files(recursive = T)
}

# Split files up if multiple
files <- stringr::str_split(files, " ")
if (class(files) == "list") files <- unlist(files)

# --------- Render ---------

# Find anything ending in md and extract
files_md <- files[grepl("[.]md$", files)]
res_files_md <- files_md[grepl("resources", files_md)]

# Find anything ending in Rmd and extract
files_Rmd <- files[grepl("[.]Rmd$", files)]
res_files_Rmd <- files_Rmd[grepl("resources", files_Rmd)]

# Check if any .md files at all
if (length(res_files_md) != 0)
  print(res_files_md) else
    print("(no .md changes, so no rendering of .md files needed)")

# loop thru and render all markdown (.md) resources files to pdf
if (length(res_files_md) != 0) {
  for (file in res_files_md) {
    rmarkdown::render(file,
                      output_dir = "resources",
                      output_format = "pdf_document")
  }
}

# Excluding the parent file, "resources.Rmd"
res_files_Rmd <- res_files_Rmd[res_files_Rmd != "resources.Rmd"]
res_files_Rmd <- res_files_Rmd[res_files_Rmd != "resources/Mapping.Rmd"] # Exclude for now

# Check if any .Rmd files at all
if (length(res_files_Rmd) != 0)
  print(res_files_Rmd) else
    print("(no .md changes, so no rendering of .md files needed)")

# loop thru and render all markdown (.Rmd) resources files to format specified
if (length(res_files_Rmd) != 0) {
  for (file in res_files_Rmd) {
    rmarkdown::render(file,
                      output_dir = "resources")
  }
}
