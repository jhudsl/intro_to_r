# Render resources

# --------- Combine html -> pdf ---------

# Read in all files needed

files <- readr::read_csv("lecture_files.csv")

if(nrow(files) > 0) {
  files$html <- sapply(files$files, gsub, pattern = ".Rmd", replacement = ".html")
  files$pdf <- sapply(files$files, gsub, pattern = ".Rmd", replacement = ".pdf")
} else {
  # Just render the Intro files if no others to render.
  files <- data.frame(
    files = "modules/Intro/Intro.Rmd",
    html = "modules/Intro/Intro.html",
    pdf = "modules/Intro/Intro.pdf"
  )
}

readr::write_lines(files$html, "html.txt")
readr::write_lines(files$pdf, "pdf.txt")
