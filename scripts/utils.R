
read_markdown <- function(file, trim_ws = TRUE, ...){
  if (length(file) > 1) {
    lines <- file
  } else {
    lines <- readr::read_lines(file)
  }
  lines <- lines[!grepl('^[[:blank:]+-=:_|]*$', lines)]
  lines <- gsub('(^\\s*?\\|)|(\\|\\s*?$)', '', lines)
  readr::read_delim(paste(lines, collapse = '\n'), delim = '|', 
                    trim_ws = trim_ws, ...)
}
