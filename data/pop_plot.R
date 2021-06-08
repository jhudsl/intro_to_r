rm(list=ls())
library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)

death = read_csv(
  "http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv")
colnames(death)[1] = "country"
long = pivot_longer(death, !country,
                    names_to = "year", values_to = "deaths")
long = long %>% 
  filter(!is.na(deaths)) %>% 
  mutate(
    year = as.numeric(year),
    before_1900 = year < 1900) 

df = long %>% 
  group_by(country, before_1900) %>% 
  summarize(deaths = mean(deaths)) %>% 
  mutate(deaths = ifelse(before_1900, -deaths, deaths))


df = df %>% 
  filter(country %in% 
           c("United States", "United Kingdom", "Sweden",
             "Afghanistan", "Rwanda"))
n1 <- ggplot(df, aes(x = country, y = deaths, 
                       fill = before_1900)) + 
  geom_bar(subset = long$before_1900, stat = "identity") + 
  geom_bar(subset = !long$before_1900, stat = "identity") + 
  coord_flip() + 
  scale_fill_brewer(palette = "Set1") + 
  theme_bw()
