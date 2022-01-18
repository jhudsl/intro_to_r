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


## ---- fig.alt="esquisse", out.width = "31%", echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("https://pbs.twimg.com/media/DoaBCAwWsAEaz-y.png")


## ---- fig.alt="ggplot2", out.width = "21%", echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("https://d33wubrfki0l68.cloudfront.net/2c6239d311be6d037c251c71c3902792f8c4ddd2/12f67/css/images/hex/ggplot2.png")



## ---- echo = FALSE------------------------------------------------------------
set.seed(456)
emo::ji("graph")  
emo::ji("plus") 
emo::ji("graph")



## ---- echo = FALSE, fig.align='center'----------------------------------------
include_graphics("img/tidy_data_ex1.png")


## ---- echo = FALSE, fig.align='center', out.width="80%"-----------------------
include_graphics("img/messy_data_ex1.png")


## ----seed---------------------------------------------------------------------
set.seed(3) 
var_1 <- seq(from = 1, to = 30)
var_2 <- rnorm(30)
my_data = tibble(var_1, var_2)
my_data


## ---- eval = FALSE, class.source = "codeexample"------------------------------
## library(ggplot2) # don't forget to load ggplot2
## # This is not code but shows the general format
## ggplot({data_to plot},  mapping = aes(x = {var in data to plot},
##                                       y = {var in data to plot}))


## ---- fig.width=3, fig.height=2.5, fig.align='center', class.source = "codereg"----
ggplot(my_data, mapping = aes(x = var_1, y = var_2))


## ---- eval = FALSE, class.source = "codeexample"------------------------------
## 
## ggplot({data_to plot},  mapping = aes(x = {var in data to plot},
##                                       y = {var in data to plot})) +
##   geom_{type of plot}</div>


## ---- fig.width=4, fig.height=3, fig.align='center'---------------------------

ggplot(my_data, mapping = aes(x = var_1, y = var_2)) + 
  geom_point() 


## ---- fig.width=3, fig.height=2.5---------------------------------------------
plt1 <- 
  ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point()

plt2 <- 
  ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_line()

plt1; plt2 # to have 2 plots printed next to each other on a slide


## ---- fig.width=4, fig.height=3, fig.align='center'---------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point() + 
  geom_line()


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "black", linetype = 2)


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "brown", linetype = 2) + 
  theme_dark()


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "brown", linetype = 2) + 
  theme_bw(base_size = 20, base_family = "Comic Sans MS")


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "brown", linetype = 2) + 
  labs(title = "My plot of var1 vs var2",
           x = "Variable 1",
           y = "Variable 2") + 
  theme(plot.title = element_text(hjust = 0.5))



## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------

ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "brown", linetype = 2) + 
  labs(title = "My plot of var1 vs var2") + 
  xlim(0,40)
  


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
seq(from = 0, to = 30, by = 5)
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "brown", linetype = 2) + 
  labs(title = "My plot of var1 vs var2") + 
  scale_x_continuous(breaks = seq(from = 0, to = 30, by = 5))


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  geom_line(size = 0.8, color = "brown", linetype = 2) + 
  labs(title = "My plot of var1 vs var2") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20))



## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(my_data, aes(x = var_1, y = var_2)) + 
  geom_point(size = 5, color = "red", alpha = 0.5) + 
  labs(title = "My plot of var1 vs var2", x = "Variable 1") +
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        axis.title.x = element_text(size = 16))


## -----------------------------------------------------------------------------
head(Orange, 3)


## ---- fig.width=3, fig.height=2, fig.align='center'---------------------------
ggplot(Orange, aes(x = Tree, y = circumference, fill = Tree)) + 
  geom_boxplot() +
  theme(legend.position = "none")


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

