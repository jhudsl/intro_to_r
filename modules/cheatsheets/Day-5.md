# Day 5 Cheatsheet

## Data Cleaning

### Major concepts

- **Most important rule of data handling - Always be looking at your data!**

- `NA` - general missing data
- `NaN` - stands for “Not a Number”, happens when you do 0/0.
- `Inf` and `-Inf` - Infinity, happens when you take a positive number (or negative
number) by 0.

### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
|Base `R`| [`is.na(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/NA)|`is.na(x)`| checks if `x` is `NA`. |
|Base `R`| [` is.nan(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/NA)|`is.nan(x)`| checks if `x` is `NaN`. |
|Base `R`| [` is.infinite(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/is.finite)|`is.infinite(x)`| checks if `x` is `Inf` or `-Inf`. |
|`naniar`| [`pct_complete(x)`](https://www.rdocumentation.org/packages/naniar/versions/0.6.1/topics/pct_complete)|`pct_complete(x)`| Reports the percentage of data that is complete in `x`. |
|`naniar`| [`gg_miss_var(x)`](https://www.rdocumentation.org/packages/naniar/versions/0.6.1/topics/gg_miss_var)|`gg_miss_var(x)`| Reports as a plot the percentage of data that is complete in `x`. |
|`tidyr`| [`drop_na(df)`](https://tidyr.tidyverse.org/reference/drop_na.html)|`drop_na(df)`| Drops rows of `NA` from a given data frame/tibble |
| `dplyr`| [`case_when()`](https://dplyr.tidyverse.org/reference/case_when.html)| `df <- df %>% mutate(variable_recoded = case_when(variable > 2 ~ "large"", TRUE ~ variable) `|This function allows you to vectorize multiple [`if_else()`](https://dplyr.tidyverse.org/reference/if_else.html) statements.  If no cases match, NA is returned, unless the TRUE statement specifies otherwise.|
| `dplyr`| [`mutate()`](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/mutate)| `df <- mutate(df, newcol = wt/2.2)`| Adds a new column that is a function of existing columns|
| `dplyr`| [`separate()`](https://tidyr.tidyverse.org/reference/separate.html)| `df %>% separate(x, c("A", "B"))`| Separate a character column into multiple columns with a regular expression or numeric locations|
| `dplyr`| [`unite()`](https://tidyr.tidyverse.org/reference/unite.html)| `df %>% unite("z", x:y, remove = FALSE)`| Unite multiple columns together into one column|
| `stringr`|[`str_detect`](https://www.rdocumentation.org/packages/stringr/versions/1.4.0/topics/str_detect)| `df %>% filter(str_detect(col_name, "string_pattern"))`| Returns logical vector to indicate if string pattern was detected |
| `stringr`|[`str_replace`](https://stringr.tidyverse.org/reference/str_replace.html)| `str_replace(vector), "replace_me","with_me")`| Replaces all instances of one specified string with another specified string |


\* This format was adapted from the [cheatsheet format from AlexsLemonade](https://github.com/AlexsLemonade/training-modules/tree/master/module-cheatsheets).
