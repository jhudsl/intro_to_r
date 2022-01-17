## ---- eval = FALSE------------------------------------------------------------
## install.packages("esquisse")
## install.packages("ggplot2")


## ---- comment = FALSE---------------------------------------------------------
library(esquisse)
library(ggplot2)


## -----------------------------------------------------------------------------
#esquisser(Orange)
ggplot(Orange) +
  aes(x = age, y = circumference) +
  geom_point(shape = "circle", size = 1.5, colour = "#112446") +
  theme_minimal() +
  facet_wrap(vars(Tree))

ggplot(Orange) +
  aes(x = age, y = circumference, colour = Tree) +
  geom_point(shape = "circle", size = 1.5) +
  scale_color_hue(direction = 1) +
  theme_minimal()


## -----------------------------------------------------------------------------
ggplot(Orange) +
  aes(x = age, y = circumference, colour = Tree) +
  geom_line(size = 0.5) +
  scale_color_hue(direction = 1) +
  theme_minimal()


