---
classoption: landscape
output: pdf_document
---

# Day 6 Cheatsheet

## Data Manipulation

### Major concepts:

- `Wide` data - multiple columns per individual, values spread across multiple columns
- `Long` data - multiple rows per observation, a single column contains the values

### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
| `dplyr`| [`separate()`](https://tidyr.tidyverse.org/reference/separate.html)| `df %>% separate(x, c("A", "B"))`| Separate a character column into multiple columns with a regular expression or numeric locations|
| `dplyr`| [`unite()`](https://tidyr.tidyverse.org/reference/unite.html)| `df %>% unite("z", x:y, remove = FALSE)`| Unite multiple columns together into one column|
| `tidyr`| [`pivot_longer()`](https://tidyr.tidyverse.org/reference/pivot_longer.html)| `df %>% pivot_longer(!column_to_not_touch, names_to = "new_col_with_labels", values_to = "new_col_with_values")`| Lengthens a data frame by increasing the number of rows and decreasing the number of columns.|
| `tidyr`| [`pivot_wider()`](https://tidyr.tidyverse.org/reference/pivot_wider.html)| `df %>% pivot_wider(names_from = "col_with_names", values_from = "col_with_values")`| Widens a data frame by decreasing the number of rows and increasing the number of columns.|
| `dplyr`| [`?_join()`](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/join) | `inner_join(x, y)`| Joins data from two data frames. <br> **inner_join** - only rows that match for x and y are kept. <br> **full_join** - all rows of x and y are kept. <br> **left_join** - all rows of x are kept even if not merged with y. <br> **right_join** - all rows of y are kept even if not merged with x. <br> **anti_join** - all rows from x not in y keeping just columns from x. |
|Base `R`| [`duplicated()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/duplicated)| `duplicated(x)`| Determines and removes duplicate elements from `x`.|
| Base `R`| [`t()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/t) | Transpose       | Returns the transpose of a matrix or data frame. If given a data frame, returns a matrix.|

<div style="page-break-after: always;"></div>

## Data Visualization with `esquisse`

### Major concepts

- The `esquisse` package can help you to test out plots and get familiar with the syntax required to make plots

### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
| `esquisse`| [`esquisser()`](https://cran.r-project.org/web/packages/esquisse/vignettes/get-started.html)| `esquisser(Orange)`| Start an `esquisse` interactive session to create a plot of the given `data.frame` or `tibble`|

\* This format was adapted from the [cheatsheet format from AlexsLemonade](https://github.com/AlexsLemonade/training-modules/tree/master/module-cheatsheets).
