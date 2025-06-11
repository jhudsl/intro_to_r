---
classoption: landscape
output: pdf_document
---

# Day 8 Cheatsheet

## Statistics

### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
| Base `R`| [`cor(x, y)`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/cor)|`cor(x, y)`| Calculate correlation of two vectors in R.|
| `corrplot`| [`corrplot(cor_mat)`](https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html)|`corrplot(cor_mat, type = "upper", order = "hclust")`| Create a correlation matrix plot.|
| Base `R`| [`t.test(x, y)`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/t.test)|`t.test(x, y, alternative = "two.sided")`| Perform one and two sided t tests.|
| `broom`| [`tidy(x)`](https://broom.tidymodels.org/)|`tidy(t_test_result)`| Manipulates and tidies up wonky statistical R objects into nice data frames|
| Base `R`| [`wilcox.test(x, y)`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/wilcox.test)|`wilcox.test(x, y)`| Calculate non-parametric, Wilcoxon signed rank test, Wilcoxon rank sum test.|
| Base `R`| [`shapiro.test()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/shapiro.test)|`shapiro.test(x)`| Test for normality with Shapiro-Wilk. |
| Base `R`| [`ks.test()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/ks.test)|`ks.test(x)`| Test for normality with Kolmogorov-Smirnov. |
| Base `R`| [`var.test(x, y)`](http://www.sthda.com/english/wiki/f-test-compare-two-variances-in-r)|`var.test(x, y)`| Compare two variances with Fisher's F-test |
| Base `R`| [`chisq.test(x, y)`](http://www.sthda.com/english/wiki/f-test-compare-two-variances-in-r)|`chisq.test(x, y)`| Perform chi squared contingency tables and goodness of fit tests |
| Base `R`| [`lm(x ~ y)`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/lm)|`lm(x ~ y, data = df)`| Fit linear models based on a formula you provide. |
| Base `R` [`summary(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/summary)| summary(linear_model_result) | Returns a summary of the values in object, including a linear model or other statistical test. |
| Base `R`| [`glm(x ~ y)`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/glm)|`glm(x ~ y, data = df, family = binomial())`| Fit generalized linear models based on a formula you provide. Must specify the error distribution and link function using the `family` argument. |


\* This format was adapted from the [cheatsheet format from AlexsLemonade](https://github.com/AlexsLemonade/training-modules/tree/master/module-cheatsheets).
