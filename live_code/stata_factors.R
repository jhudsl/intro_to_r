library(tidyverse)
library(haven)

# Download the example data set from the internet
dta_file = tempfile(fileext = ".dta")
# change dta_file = "~/Downloads/demog.dta" 
# or some other path if you want to save it and open it in Stata
curl::curl_download(
  url = "http://johnmuschelli.com/intro_to_r/live_code/demog.dta",
  destfile = dta_file)

df = read_dta("demographics.dta")
head(df$ethnicity)
df$ethnicity = as_factor(df$ethnicity)
head(df$ethnicity)
