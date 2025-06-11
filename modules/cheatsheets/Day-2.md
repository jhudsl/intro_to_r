---
classoption: landscape
output: pdf_document
---

# Day 2 Cheatsheet

## Basic R

### Major concepts

- **Package** - a package in R is a bundle or “package” of code (and or possibly data)
that can be loaded together for easy repeated use or for sharing with others.
- The R console is a full calculator:
  - `+`, `-`, `/`, `*` are add, subtract, divide and multiply
  - `^` or `**` is power
  - parentheses – ( and ) – work with order of operations
  - %% finds the remainder
- `#` is the comment symbol; nothing to its right is evaluated.


### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
| Base `R`| [`<-`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/assignOps.html)| `x <- 1`| Assigns a name to something in the R environment.|
| Base `R`| [`c()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/c)| `x <- c(1, 3)`| Combines values into a vector or list. |
| Base `R`| [`str(x)`](https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/str)|`str(x)`| Gets a summary of the object `x` structure.|
| Base `R`| [`class(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/class)|`class(x)`| Returns the type of the values in object `x`.|
| Base `R`| [`print(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/print)|`print(x)`| Prints out contents of `x`.|
| Base `R`| [`length(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/length)|`length(x)`| Returns how long the object `x` is. |

<div style="page-break-after: always;"></div>

## Data Input/Output

### Major concepts

- **Delimited file** - columns within the file have boundaries created with some type of punctuation - for example, a csv file stands for comma separated values, thus the columns are delimited or separated by commas. txt files often use tabs.
- **tibble** – a rectangular data frame, where data are split into rows and columns.
- **File path** - where a file lives on your computer (or on the internet) - [File paths can be relative or absolute](https://en.wikipedia.org/wiki/Path_(computing)#Absolute_and_relative_paths).
- **Getting help** - For any function, you can write `?FUNCTION_NAME`, or `help("FUNCTION_NAME")` to
look at the help file for that function.
- [**R Projects**](https://support.rstudio.com/hc/en-us/articles/200526207-Using-RStudio-Projects) set the working directory where the .Rproj file is.
- [**R Markdown**](https://bookdown.org/yihui/rmarkdown-cookbook/working-directory.html) files look for file paths relative to where the `.Rmd` file is located

### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
| `readr`| [`read_csv()`](https://www.rdocumentation.org/packages/readr/versions/1.3.0/topics/read_delim)| `df <- read_csv("<url>")`| Reads in a TSV file from a specified file path. This function can be tailored to read in other common types of files. i.e. read_csv(), read_rds(), etc.|
|`readxl`| [`read_excel()`](https://www.rdocumentation.org/packages/readxl/versions/1.3.1/topics/read_excel)| `read_excel("dataset.xlsx")`| Read in an excel file.|
| Base `R`| [`getwd()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/getwd)| `getwd()`| Finds the current working directory.|
| Base `R`| [`setwd()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/getwd)| `setwd("Desktop")`| Changes the current working directory.|


\* This format was adapted from the [cheatsheet format from AlexsLemonade](https://github.com/AlexsLemonade/training-modules/tree/master/module-cheatsheets).
