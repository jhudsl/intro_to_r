############
## Data Input/Output Lab
############

# 1. Install and invoke the `readxl` package. 
# install.packages("readxl") # just run once
library(readxl)
library(readr)

# 2. Download an Excel version of the Monuments dataset:
#		http://johnmuschelli.com/intro_to_r/data/Monuments.xlsx

# 3. Use the `read_excel()` function in the `readxl` package to 
#		read in the dataset
destfile = file.path(tempdir(), "Monuments.xlsx")
download.file("http://johnmuschelli.com/intro_to_r/data/Monuments.xlsx", 
              destfile = destfile)
mon = read_excel(destfile)

# 4. Write out the R object as a CSV file 
write.csv(mon, file = "monuments.csv")
write_csv(mon, path = "monuments_write_csv.csv")

save(mon, file = "monuments_data.rda")
load("monuments_data.rda")

saveRDS(mon, file = "monuments.rds")
mon2 = readRDS("monuments.rds")






