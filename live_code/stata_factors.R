library(tidyverse)
library(haven)

# Download the example data set from the internet
dta_file = tempfile(fileext = ".dta")
# change dta_file = "~/Downloads/demog.dta" 
# or some other path if you want to save it and open it in Stata
curl::curl_download(
  url = "http://johnmuschelli.com/intro_to_r/live_code/demog.dta",
  destfile = dta_file)

df = read_dta(dta_file)
View(df)
head(df$sex)
head(as_factor(df$sex))
df2 = as_factor(df)
View(df2)





