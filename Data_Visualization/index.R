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


## ---- fig.alt="esquisse", out.width = "28%", echo = FALSE, fig.show='hold',fig.align='center'----
knitr::include_graphics("https://pbs.twimg.com/media/DoaBCAwWsAEaz-y.png")


## ---- fig.alt="ggplot2", out.width = "19%", echo = FALSE, fig.show='hold',fig.align='center'----
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
           y = "Variable 2")


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


## ---- fig.width=3.5, fig.height=2.5, fig.align='center'-----------------------
ggplot(Orange, aes(x = Tree, y = circumference, fill = Tree)) + 
  geom_boxplot() +
  theme(legend.position = "none")


## -----------------------------------------------------------------------------
# create 4 vectors: 2x character class and 2x numeric class
item_categ <- rep(c("pasta", "rice"),each = 20)
item_ID  <- rep(seq(from = 1, to = 4), each = 10)
item_ID <- paste0("ID_", item_ID)
observation_time  <- rep(seq(from = 1, to = 10), times = 4)
item_price_change <- c(sample(0.5:2.5, size = 10, replace = TRUE),
                       sample(0:1, size = 10, replace = TRUE),
                       sample(2:5, size = 10, replace = TRUE),
                       sample(6:9, size = 10, replace = TRUE))
# use 4 vectors to create data frame with 4 columns
food  <- tibble(item_ID, item_categ, observation_time, item_price_change) 


## -----------------------------------------------------------------------------
food


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------

ggplot(food, aes(x = observation_time, 
                 y = item_price_change)) + 
  geom_line() 


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(food, aes(x = observation_time, 
                 y = item_price_change, 
                 group = item_ID)) + 
  geom_line() 


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(food, aes(x = observation_time, 
                 y = item_price_change,
                color = item_ID)) + 
  geom_line() 


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(food, aes(x = observation_time, 
                 y = item_price_change,
                color = item_categ)) + 
  geom_line() 


## ---- fig.width=5, fig.height=3, fig.align='center'---------------------------
ggplot(food, aes(x = observation_time, 
                 y = item_price_change,
                 group = item_ID,
                color = item_categ)) + 
            geom_line() 



## ---- fig.width=4, fig.height=3, fig.align='center'---------------------------
ggplot(food, aes(x = observation_time, 
                 y = item_price_change,
                 color = item_ID)) + 
  geom_line() +
  facet_grid( ~ item_categ)


## ---- fig.width=4, fig.height=2.7, fig.align='center'-------------------------
rp_fac_plot <- ggplot(food, aes(x = observation_time, 
                                y = item_price_change,
                                color = item_ID)) + 
                  geom_line()  +
                  geom_point() +
                  facet_wrap( ~ item_categ, ncol = 1, scales = "free")

rp_fac_plot


## ---- fig.width=5 , fig.height=3, fig.align='center'--------------------------
ggplot(food, aes(x = item_ID, 
                 y = item_price_change, 
                 color = item_categ)) + 
  geom_boxplot() 


## ---- fig.width=5 , fig.height=3, fig.align='center'--------------------------
ggplot(food, aes(x = item_ID, 
                 y = item_price_change, 
                 fill = item_categ)) + 
  geom_boxplot() 


## ---- fig.width=6 , fig.height=4 * 0.8, eval = FALSE--------------------------
## ggplot(food, aes(x = item_ID,
##                  y = item_price_change,
##                  fill = item_categ))
##  + geom_boxplot()


## ---- fig.width=5 , fig.height=3, fig.align='center'--------------------------
ggplot(food, aes(x = item_ID, 
                 y = item_price_change, 
                 fill = item_categ)) + 
  geom_boxplot() +
  geom_jitter(width = .06)


## ---- fig.width=5 , fig.height=3, fig.align='center'--------------------------
ggplot(food, aes(x = item_ID, 
                 y = item_price_change, 
                 fill = item_categ)) + 
  geom_boxplot() +
  geom_jitter(width = .06) +
  scale_fill_viridis_d()


## ---- fig.width=5 , fig.height=3, fig.align='center'--------------------------

food_bar <-food %>% 
  group_by(item_categ) %>%
  summarize("max_price_change" = max(item_price_change)) %>%
  ggplot(aes(x = item_categ, 
             y = max_price_change,
             fill = item_categ)) + 
  scale_fill_viridis_d()+
  geom_col() +
  theme(legend.position = "none")

food_bar


## ---- fig.width=5 , fig.height=3, fig.align='center'--------------------------
food_bar +
   geom_col(color = "black") 


## ---- fig.width=5 , fig.height=3, fig.align='center'--------------------------
ggplot(food, aes(x = item_ID, 
                 y = item_price_change, 
                 fill = item_categ)) + 
  geom_col()


## -----------------------------------------------------------------------------
head(food)

food %>% group_by(item_ID) %>%
  summarize(sum = sum(item_price_change))


## ---- fig.width=5 , fig.height=3, fig.align='center'--------------------------
food_bar +
  theme(text = element_text(size = 20))



## -----------------------------------------------------------------------------
#install.packages("directlabels")
library(directlabels)
direct.label(rp_fac_plot, method = list("angled.boxes"))


## -----------------------------------------------------------------------------
#install.packages("plotly")
library("plotly")
ggplotly(rp_fac_plot)


## ---- eval = FALSE------------------------------------------------------------
## ggsave(filename = "saved_plot.png",  # will save in working directory
##        plot = rp_fac_plot,
##        width = 6, height = 3.5)               # by default in inch

