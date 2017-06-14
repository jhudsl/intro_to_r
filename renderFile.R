renderFile <- function(file) {
  # owd = getwd()
  # setwd(dirname(file))
  # file = basename(file)
  output = gsub(".Rmd", ".R", file)
  ## Extract R code
  knitr::purl(file, output = output)
  
  ## Make presentation
  rmarkdown::render(file, output_format = "all")
                    # output_format = c("ioslides_presentation", 
                                      # "beamer_presentation"))
  # on.exit({ 
  #   setwd(owd)
  # })
}
