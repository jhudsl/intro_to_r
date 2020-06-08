## -----------------------------------------------------------------------------
library(readr)
youth = read_csv("http://johnmuschelli.com/intro_to_r/data/Youth_Tobacco_Survey_YTS_Data.csv")


## -----------------------------------------------------------------------------
problems(youth)
stop_for_problems(youth)


## -----------------------------------------------------------------------------
library(readxl)


## -----------------------------------------------------------------------------
download.file("http://johnmuschelli.com/intro_to_r/data/Monuments.xlsx",
              destfile = "Monuments.xlsx",
              overwrite = TRUE)


## -----------------------------------------------------------------------------
mon = read_excel("Monuments.xlsx")


## -----------------------------------------------------------------------------
write_csv(mon, "monuments.csv")


## -----------------------------------------------------------------------------
readr::write_rds(mon, "monuments.rds")

