## ---- echo = FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")


## ----code---------------------------------------------------------------------
print("I'm code")


## ----calcDemo-----------------------------------------------------------------
2 + 2
2 * 4
2 ^ 3


## ----calcDemo2----------------------------------------------------------------
2 + (2 * 3)^2
(1 + 3) / 2 + 45
6 / 2 * (1 + 2)


## ---- fig.alt="Problem gives answer of 1 or 9 depending on calculator.", out.width = "30%", echo = FALSE, out.extra='style="float:left"'----
knitr::include_graphics("../images/Basic_R_calculator.jpg")


## ---- fig.alt="Problem gives answer of 1 or 9 depending on calculator.", out.width = "60%", echo = FALSE, out.extra='style="float:left"'----
knitr::include_graphics("../images/Basic_R_viral_math_problem.png")


## -----------------------------------------------------------------------------
# this is a comment

# nothing to its right is evaluated

# this # is still a comment
### you can use many #'s as you want

1 + 2 # Can be the right of code



## ----assign-------------------------------------------------------------------
x <- 2
x
x * 4
x + 2


## ----assignClass--------------------------------------------------------------
class(x)
y <- "hello world!"
print(y)
class(y)


## ----myName-------------------------------------------------------------------
name <- "Ava Hoffman"
name


## ----assign3a-----------------------------------------------------------------
x <- c(1, 4, 6, 8)
x
class(x)


## ----myName2------------------------------------------------------------------
name2 <- c("Ava","Hoffman")
name2


## ----assign3b-----------------------------------------------------------------
length(x)
y
length(y)


## ----myName3------------------------------------------------------------------
length(name)
length(name2)


## ----assign4------------------------------------------------------------------
x + 2
x * 3
x + c(1, 2, 3, 4)


## ---- error=TRUE--------------------------------------------------------------
name2 + 4


## ----assign5------------------------------------------------------------------
y <- x + c(1, 2, 3, 4)
y 


## ----assign2------------------------------------------------------------------
str(x)
str(y)

