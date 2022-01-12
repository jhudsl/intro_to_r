## ---- echo = FALSE------------------------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")


## ---- fig.alt="The New R Project button is highlighted.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_Rproject.png")


## ---- fig.alt="In the New Project Wizard, the 'New Directory' option is highlighted.", out.width = "60%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_new_directory.png")


## ---- fig.alt="In the New Project Wizard, the 'New Project' option is highlighted.", out.width = "60%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_new_project.png")


## ---- fig.alt="In the New Project Wizard, the new project has been given a name and is going to be stored in the Desktop directory. The 'Create Project' button is highlighted.", out.width = "60%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_new_project_details.png")


## ---- fig.alt="The image shows an image of an arrow pointing to the newly created R project repository.", out.width = "60%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_new_desktop.png")


## ----read_url, message = FALSE------------------------------------------------
# load library `readr` that contains function `read_csv`
library(readr)
dat <- read_csv("http://jhudatascience.org/intro_to_R_class/data/Youth_Tobacco_Survey_YTS_Data.csv")

# `head` displays first few rows of a data frame 
head(dat, 5)


## ---- eval = FALSE------------------------------------------------------------
## ## Examples
## 
## dat <- read_csv("/Users/avahoffman/Downloads/Youth_Tobacco_Survey_YTS_Data.csv")
## 
## dat <- read_csv("Youth_Tobacco_Survey_YTS_Data.csv")
## 
## dat <- read_csv("www.someurl.com/table1.csv")


## ---- fig.alt="GIF with text. PC: *autosaves file* Me: Cool, so where did the file save? PC: shows image of Power Rangers shrugging.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_where_are_the_files.gif")


## ---- fig.alt="Image showing the csv dataset being moved to the R Project directory created earlier.", out.width = "40%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_file_move.png")


## ---- eval = FALSE------------------------------------------------------------
## dat <- read_csv("Youth_Tobacco_Survey_YTS_Data.csv")


## ---- eval = FALSE------------------------------------------------------------
## ## Examples
## dat <- read_delim("Youth_Tobacco_Survey_YTS_Data.csv", delim = ",")
## 
## dat <- read_delim("www.someurl.com/table1.txt", delim = "\t")


## ----readCSV2-----------------------------------------------------------------
dat <- read_csv("../data/Youth_Tobacco_Survey_YTS_Data.csv")


## ----stop_problems------------------------------------------------------------
# dat <- read_csv("../data/Youth_Tobacco_Survey_YTS_Data.csv")
spec(dat)


## ----stop_problems2-----------------------------------------------------------
problems(dat)


## ----stop_problems2.1, message = FALSE, warning = FALSE-----------------------
ufo_data <- read_csv("https://github.com/SISBID/Data-Wrangling/blob/gh-pages/data/ufo/ufo_data_complete.csv")

## ----stop_problems2.2---------------------------------------------------------
problems(ufo_data)


## ----stop_problems3, error = TRUE---------------------------------------------
stop_for_problems(ufo_data)


## ---- eval = FALSE------------------------------------------------------------
## ?read_delim
## help("read_delim")


## ---- fig.alt="Screenshot of the RStudio console. '?read_delim' has been typed and the help page has appeared in the help pane on the right.", out.width = "60%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_read_delim.png")


## ---- fig.alt="Gif showing the process of importing a dataset via readr.", out.width = "80%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_import_dataset.gif")


## ----workingDirectory,eval=FALSE----------------------------------------------
## # get the working directory
## getwd()
## 
## # set the working directory
## setwd("/Users/avahoffman/Desktop")


## ---- fig.alt="Image showing the RStudio console. There is an arrow pointing to the .Rproj file. The top right corner shows that the 'Intro_to_r_class' project has been selected.", out.width = "80%", echo = FALSE, align = "center"----
knitr::include_graphics("../images/Data_IO_Rproj_file.png")


## ---- eval = FALSE------------------------------------------------------------
## # Examples
## 
## write_csv(dat, file = "YouthTobacco_newNames.csv")
## 
## write_delim(dat, file = "YouthTobacco_newNames.csv", delim = ",")


## -----------------------------------------------------------------------------
# write a variable: a data frame "dat" 
write_rds(dat, file = "yts_dataset.rds")

# write a variable: vector "x"
x <- c(1,3,3)
write_rds(x, file = "my_vector.rds")

# read a variable from file and assign to a new variable named "y"
x2 <- read_rds("my_vector.rds")
x2

