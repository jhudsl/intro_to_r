library(readr)
library(here)
# create 4 vectors: 2x character class and 2x numeric class
set.seed(1234)
item_categ <- rep(c("pasta", "rice"),each = 20)
item_ID  <- rep(seq(from = 1, to = 4), each = 10)
item_ID <- paste0("ID_", item_ID)
observation_time  <- rep(seq(from = 1, to = 10), times = 4)
item_price_change <- c(sample(0.5:2.5, size = 10, replace = TRUE),
                       sample(0:1, size = 10, replace = TRUE),
                       sample(2:5, size = 10, replace = TRUE),
                       sample(6:7, size = 10, replace = TRUE))
# use 4 vectors to create data frame with 4 columns
food  <- tibble(item_ID, item_categ, observation_time, item_price_change) 
write_csv(food, file = here::here("data", "food_price.csv"))
