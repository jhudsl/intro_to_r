library(dplyr)
library(readr)
circ = read_csv(
  paste0("http://johnmuschelli.com/intro_to_r/data",
         "/Charm_City_Circulator_Ridership.csv"))


circ2 = circ
circ2$daily[1] = NA
circ2 = circ2 %>% mutate(
  riderLevels = NA,
  riderLevels = ifelse(daily < 10000, "low", riderLevels),
  riderLevels = ifelse(daily >= 10000 & daily < 20000, 
                       "med", riderLevels),
  riderLevels = ifelse(daily >= 20000, 
                       "high", riderLevels),
  riderLevels = ifelse(is.na(riderLevels), 
                       "unknown", riderLevels)  
) %>% 
  circ2 %>% 
  select(daily, riderLevels) 


circ2 %>% 
  mutate(
    riderLevels3 = cut(
      daily, 
      breaks = c(min(daily, na.rm = TRUE),
                 10000, 
                 20000,
                 max(daily, na.rm = TRUE)),
      labels = c("low", "med", "high"), # one less than breaks
      include.lowest = TRUE)
  )
with(circ2, table(riderLevels2, riderLevels))
