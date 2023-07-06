# Render cheatsheets

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
if (class(files) == "list") 
  files <- unlist(files)

# Keep only mds
files <- files[grepl("[.]md$", files)]

# --------- Render ---------

# Extract Cheatsheet files
cheatsheet_files <- files[grepl("cheatsheets", files)]
message("The following cheatsheet files will be rendered to pdf:")
if (length(cheatsheet_files) != 0) 
  print(cheatsheet_files) else 
  print("(no changes, so no rendering needed)")
write.csv(data.frame(files = cheatsheet_files), "cheatsheet_files.csv")

# loop thru and render all cheatsheet files to pdf
if (length(cheatsheet_files) != 0) {
  for (file in cheatsheet_files) {
    rmarkdown::render(file,
                      output_dir = "modules/cheatsheets",
                      output_format = "pdf_document")
  }
}
