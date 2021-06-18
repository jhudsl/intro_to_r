## ----knit-setup, echo=FALSE, include = FALSE----------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, 
               message = FALSE, 
               warning = FALSE,
               fig.height = 4,
               fig.width = 7, 
               comment = "")
library(tidyverse)
library(jhur)


## ----seed, comment="",echo=FALSE----------------------------------------------
set.seed(3) 


## ---- echo = FALSE------------------------------------------------------------
set.seed(1)


## ---- fig.width=4, fig.height=3-----------------------------------------------
var_1 <- seq(from = 1, to = 30)
var_2 <- rnorm(30)

plot(x = var_1, y = var_2)


## ---- fig.width=4, fig.height=3-----------------------------------------------
plot(x = var_1, y = var_2, 
     type = "l", 
     xlab = "My variable 1", ylab = "My variable 2", 
     main = "Title of my plot")


## ---- fig.width=4, fig.height=3-----------------------------------------------
# creating a data frame from the vectors we had 
my_data = data.frame(var_1, var_2)
my_data


## ---- fig.width=5, fig.height=4-----------------------------------------------
# use $ to access column from a data set 
plot(x = my_data$var_1, y = my_data$var_2)


## ---- fig.width=5, fig.height=4-----------------------------------------------
# use $ to access column from a data set 
boxplot(x = my_data$var_1)


## ---- fig.width=4, fig.height=3-----------------------------------------------
head(my_data, 3)   # to recall how "my_data" data frame looks like
library(ggplot2)

ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point() 


## ---- fig.width=4, fig.height=3, eval = FALSE---------------------------------
## ggplot(my_data, aes(x = var_1, y = var_2)) +
##   geom_point()


## ---- fig.width=4, fig.height=3-----------------------------------------------
plt1 <- 
  ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point()

plt2 <- 
  ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_line()

plt1; plt2 # to have 2 plots printed next to each other on a slide


## ---- fig.width=4, fig.height=3-----------------------------------------------
plt3 <- 
  ggplot(my_data, aes(y = var_2)) + 
  geom_boxplot()

plt4 <- 
  ggplot(my_data, aes(x = var_2)) + 
  geom_histogram()

plt3; plt4 # to have 2 plots printed next to each other on a slide


## ---- fig.width=5, fig.height=3-----------------------------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point() + 
  geom_line()


## ---- fig.width=5, fig.height=3-----------------------------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "brown", linetype = 2)


## ---- fig.width=5, fig.height=3-----------------------------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "brown", linetype = 2) + 
  labs(x = "My variable 1", y = "My variable 2",
       title = "My plot title") + 
  theme_bw(base_size = 12, base_family = "Times New Roman")


## -----------------------------------------------------------------------------
# create 4 vectors: 2x character class and 2x numeric class
item_categ <- as.vector(sapply(1:20, function(i) rep(sample(c("pasta", "rice"), 1), 100)))
item_ID  <- rep(seq(from = 1, to = 20), each = 100)
item_ID <- paste0("ID_", item_ID)
observation_time  <- rep(seq(from = 1, to = 100), times = 20)
item_price <- as.vector(replicate(20, cumsum(rnorm(100))))
item_price <- item_price + abs(min(item_price)) + 1

# use 4 vectors to create data frame with 4 columns
df  <- data.frame(item_ID, item_categ, observation_time, item_price) 


## -----------------------------------------------------------------------------
head(df, 3)
tail(df, 3)
str(df)


## ---- fig.width=6, fig.height=4-----------------------------------------------
ggplot(df, aes(x = observation_time, y = item_price, group = item_ID)) + 
  geom_line(size = 0.3) 


## ---- fig.width=6 , fig.height=4 * 0.8----------------------------------------
ggplot(df, aes(x = observation_time, y = item_price, group = item_ID,
               color = item_categ)) + 
  geom_line(size = 0.3) 


## ---- fig.width=6 , fig.height=4 * 0.8----------------------------------------
ggplot(df, aes(x = item_ID, y = item_price)) + 
  geom_boxplot() + 
  labs(x = "Item ID", y = "Item prices") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


## ---- fig.width=7, fig.height=4 * 0.8-----------------------------------------
ggplot(df, aes(x = item_ID, y = item_price, color = item_categ)) + 
  geom_boxplot() + 
  labs(x = "Item ID", y = "Item prices", color = "Item\ncategory") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


## ---- fig.width=7, fig.height=4 * 0.8-----------------------------------------
ggplot(df, aes(x = item_ID, y = item_price, fill = item_categ)) + 
  geom_boxplot() + 
  labs(x = "Item ID", y = "Item prices", fill = "Item\ncategory") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


## -----------------------------------------------------------------------------
item_ID_levels <- 
  df %>% 
  group_by(item_ID) %>% 
  summarise(item_price_median = median(item_price)) %>%
  arrange(item_price_median) %>%
  pull(item_ID)

df <- 
  df %>%
  mutate(item_ID_factor = factor(item_ID, levels = item_ID_levels))


## ---- fig.width=6 , fig.height=4 * 0.8----------------------------------------
ggplot(df, aes(x = item_ID_factor, y = item_price, fill = item_categ)) + 
  geom_boxplot() + 
  labs(x = "Item ID", y = "Item prices", fill = "Item\ncategory") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


## ---- fig.width=8, fig.height=2.7---------------------------------------------
df_subset <- df %>% 
  filter(item_ID %in% c("ID_1", "ID_2", "ID_3", "ID_4"))

ggplot(df_subset, aes(x = observation_time, y = item_price)) + 
  geom_line() + 
  labs(x = "Observation time", y = "Item prices") + 
  facet_grid(. ~ item_ID) 


## ---- fig.width=4, fig.height=3-----------------------------------------------
ggplot(df_subset, aes(x = item_price)) + 
  geom_histogram(fill = "yellow", color = "brown", alpha = 0.5) + 
  labs(x = "Item prices", y = "Observations count") + 
  facet_grid(item_ID ~ .) 


## -----------------------------------------------------------------------------
plot_FINAL <- 
  ggplot(df_subset, aes(x = item_price)) + 
  geom_histogram(fill = "yellow", color = "brown", alpha = 0.5) + 
  labs(x = "Item prices", y = "Observations count") + 
  facet_grid(item_ID ~ .)  

ggsave(filename = "very_important_plot.png",  # will save in working directory
       plot = plot_FINAL, 
       width = 6, height = 3.5)               # by default in inch

