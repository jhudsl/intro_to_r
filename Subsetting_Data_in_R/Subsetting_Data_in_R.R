## ---- echo = FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
suppressPackageStartupMessages(library(dplyr))
library(dplyr)
library(jhur)


## ---- fig.alt="dplyr", out.width = "25%", echo = FALSE, fig.align='center'----
knitr::include_graphics("https://dplyr.tidyverse.org/logo.png")


## ---- fig.alt="dplyr", out.width = "100%", echo = FALSE, fig.align='center'----
knitr::include_graphics("images/dplyr.png")


## -----------------------------------------------------------------------------
library(tidyverse) # loads dplyr and other packages!


## -----------------------------------------------------------------------------
df <- mtcars # df is a copy of mtcars
head(df) # changing df does **not** change mtcars!


## -----------------------------------------------------------------------------
data.frame(df)


## -----------------------------------------------------------------------------
df_updated <-data.frame(df)
# this would overwrite the existing df object
df<-data.frame(df) 


## ---- eval = FALSE------------------------------------------------------------
## # function comes from base R - no package loading required
## df_example_readr <- read.csv("documents/data_analysis/data_file.csv")


## ---- fig.alt="dplyr", out.width = "25%", echo = FALSE, fig.align='center'----
knitr::include_graphics("https://github.com/tidyverse/tibble/raw/main/man/figures/logo.png")


## -----------------------------------------------------------------------------
tbl <- as_tibble(df) 
tbl


## ---- eval = FALSE------------------------------------------------------------
## 
## df_example_readr <- read_csv("documents/data_analysis/data_file.csv")


## -----------------------------------------------------------------------------
head(df, 2)
head(as_tibble(df), 2)


## ---- eval = FALSE------------------------------------------------------------
## # the format!
## mutate({data_to_use}, {new_variable_name} = {new_varaible_source})


## -----------------------------------------------------------------------------
mtcars_mutated <- mutate(mtcars, car = rownames(mtcars))
head(mtcars_mutated, 2)


## ---- size = "tiny"-----------------------------------------------------------
head(rownames_to_column(df, var = "car"),  2)
head(as_tibble(rownames_to_column(df, var = "car")),  2)


## ---- size = 'tiny'-----------------------------------------------------------
mtcars_tbl <- tibble(mtcars_mutated) 
mtcars_tbl


## ---- eval = FALSE------------------------------------------------------------
## # general format
## {data you are creating or changing} <- dplyr::rename({data you are using},
##                                         {New Name} = {Old name})


## -----------------------------------------------------------------------------
df <- dplyr::rename(df, MPG = mpg)
head(df)


## -----------------------------------------------------------------------------
df_upper = dplyr::rename_all(df, toupper)
head(df_upper, 3)


## -----------------------------------------------------------------------------
df = dplyr::rename_all(df, tolower)
head(df, 3)


## -----------------------------------------------------------------------------
df$carb


## -----------------------------------------------------------------------------
pull(df, carb)


## -----------------------------------------------------------------------------
select(df, mpg)


## -----------------------------------------------------------------------------
pull(df, mpg)

# pull with select works too!

pull(select(df,mpg))


## -----------------------------------------------------------------------------
select(df, mpg, cyl)
select(df, starts_with("c"))


## ---- eval = FALSE------------------------------------------------------------
## one_of() # if they exist
## last_col()
## ends_with()
## contains() # like searching


## ---- eval = FALSE------------------------------------------------------------
## ??tidyselect::select_helpers


## -----------------------------------------------------------------------------
filter(df, mpg > 20)


## -----------------------------------------------------------------------------
filter(df, mpg %in% c(20,21,22))


## -----------------------------------------------------------------------------
filter(df, mpg > 20 & cyl == 4)
filter(df, mpg > 20, cyl == 4)


## -----------------------------------------------------------------------------
filter(df, mpg > 20 | cyl == 4)



## -----------------------------------------------------------------------------
select(filter(df, mpg > 20 & cyl == 4), cyl, hp)


## -----------------------------------------------------------------------------
df2 = filter(df, mpg > 20 & cyl == 4)
df2 = select(df2, cyl, hp)

head(df2,4)


## -----------------------------------------------------------------------------
df %>% filter(mpg > 20 & cyl == 4) %>% select(cyl, hp)


## -----------------------------------------------------------------------------
df$newcol = df$wt/2.2
head(df,3)


## -----------------------------------------------------------------------------
df = mutate(df, newcol = wt/2.2)


## ---- echo = FALSE------------------------------------------------------------
print(head({df = mutate(df, newcol = wt/2.2)}, 2))


## ---- eval = FALSE------------------------------------------------------------
## df$newcol = NULL


## ---- eval = FALSE------------------------------------------------------------
## select(df, -newcol)


## ---- echo = FALSE------------------------------------------------------------
head(select(df, -newcol))


## -----------------------------------------------------------------------------
select(df, -c("newcol", "drat"))


## ---- eval = FALSE------------------------------------------------------------
## head(df)
## select(df, cyl, mpg, wt, car) %>%
## head()


## -----------------------------------------------------------------------------
arrange(df, mpg)


## -----------------------------------------------------------------------------
arrange(df, desc(mpg))


## -----------------------------------------------------------------------------
arrange(df, mpg, desc(hp))


## -----------------------------------------------------------------------------
df$disp
#ifelse(test, yes, no)
ifelse(df$disp<=200, "low", "high")


## -----------------------------------------------------------------------------
df = mutate(df, 
            disp_cat = ifelse(disp <= 200, "Low","High")
            )

head(df,2)


## -----------------------------------------------------------------------------
df = mutate(df, 
            disp_cat2 = case_when(
              disp <= 200 ~ "Low",
              disp > 200 ~ "High",
            ))
head(df$disp_cat2)


## -----------------------------------------------------------------------------
colnames(df) # just prints
colnames(df)[1:3] = c("MPG", "CYL", "DISP") # reassigns
head(df)
colnames(df)[1:3] = c("mpg", "cyl", "disp") #reset - just to keep consistent


## -----------------------------------------------------------------------------
cn = colnames(df)
cn[ cn == "drat"] = "DRAT"
colnames(df) = cn
head(df)
colnames(df)[ colnames(df) == "DRAT"] = "drat" #reset


## -----------------------------------------------------------------------------
df[ c(1, 3), ]


## -----------------------------------------------------------------------------
df[, 11]
df[, "carb"]


## -----------------------------------------------------------------------------
df[, 1]
tbl[, 1]
tbl[, "mpg"]
df[, 1, drop = FALSE]


## -----------------------------------------------------------------------------
df[, c("mpg", "cyl")]

