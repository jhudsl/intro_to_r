library(tidyverse)


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


urls_for_module_details <- function(df){
  df <- df %>% mutate(across(
    .fns = ~ str_replace_all(., "docs/module_details/", "../../docs/module_details/")
  )) %>%
    mutate(across(
      .fns = ~ str_replace_all(., "modules/", "../../modules/")
    )) 
  
  return(df)
}
