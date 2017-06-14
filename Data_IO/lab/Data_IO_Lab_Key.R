############
## Data Input/Output Lab
############

# 1. Install and invoke the `readxl` package. 
# install.packages("readxl") # just run once
library(readxl)

# 2. Download an Excel version of the Monuments dataset:
#		http://www.aejaffe.com/winterR_2017/data/Monuments.xlsx

# 3. Use the `read_excel()` function in the `readxl` package to 
#		read in the dataset
mon = read_excel("../../data/Monuments.xlsx")

# 4. Write out the R object as a CSV file 
write.csv(mon, file = "monuments.csv")
write_csv(mon, path = "monuments_write_csv.csv")
