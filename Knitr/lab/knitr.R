
# 1.  Make an Rmarkdown Document (File -> New file -> Rmarkdown).  Save it as
# knitr_lab.Rmd

# 2.  Make a code chunk, name it reading.  Load the readr library and read in the
# Youth Tobacco survey data http://johnmuschelli.com/intro_to_r/data/Youth_Tobacco_Survey_YTS_Data.csv
# using read_csv, calling it smoke.  Delete all other code chunks other than `setup`.

# 3.  Make the title "YTS Analysis", add your name as the author.

# 4.  Make a code chunk with a table of the MeasureDesc column

# 5. Filter the smoke data set using the MeasureDesc equal to "Smoking Status",
# Gender = "Overall", and Response = "Frequent".  Call this `sub_smoke`.  If using 
# filter, load the dplyr package

# 6.  How many rows are in sub_smoke?

# 7. Write the sentence: "There are `r nrow(sub_smoke)` rows in this data set."

# 8.  Plot a histogram of the Data_Value
# 9.  Plot a boxplot of Data_Value by each YEAR
# 10.  Plot a scatterplot of Data_Value (y) by year (x)
