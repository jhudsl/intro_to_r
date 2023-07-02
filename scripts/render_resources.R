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

# Split files up if multiple
files <- stringr::str_split(files, " ")
if (class(files) == "list") files <- unlist(files)

# --------- Render ---------

# Find anything ending in md and extract
files <- files[grepl("[.]md$", files)]
res_files_md <- files[grepl("resources", files)]

# Find anything ending in Rmd and extract
files <- files[grepl("[.]Rmd$", files)]
res_files_Rmd <- files[grepl("resources", files)]

res_files <- c(res_files_md, res_files_Rmd[res_files_Rmd != "resources.Rmd"])
if (length(res_files) != 0)
  print(res_files) else
    print("(no changes, so no rendering needed)")

# loop thru and render all resources files to pdf
if (length(res_files) != 0) {
  for (file in res_files) {
    rmarkdown::render(file,
                      output_dir = "resources",
                      output_format = "pdf_document")
  }
}
