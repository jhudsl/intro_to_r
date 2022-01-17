# Day 3 Cheatsheet

## Data Summarization

### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
|Base `R`| [`min(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Extremes)|`min(x)`| Returns the minimum value of all values in an object `x`.|
|Base `R`| [`sum(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/sum)| `sum(x)`| Returns the sum of all values (values must be integer, numeric, or logical) in object `x`.|
|Base `R`| [`mean(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/mean)|`mean(x)`| Returns the arithmetic mean of all values (values must be integer or numeric) in object `x` or logical vector `x`.|
| Base `R`|[`log(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/log)|`log(x)`| Gives the natural logarithm of object `x`. `log2(x)` can be used to give the logarithm of the object in base 2. Or the base can be specified as an argument.|
| Base `R`|[`range(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/range)|`range(x)`| Gives the min and max for object `x`.|
| Base `R`|[`sd(x)`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/sd)|`sd(x)`| Gives the standard deviation for object `x`.|
| Base `R`|[`sqrt(x)`](https://www.rdocumentation.org/packages/SparkR/versions/2.1.2/topics/sqrt)|`sqrt(x)`| Gives the square root for object `x`.|
| Base `R`|[`quantile(x)`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/quantile)|`quantile(x, probs = .5)`| Produces sample quantiles corresponding to the given probabilities `x`.|
| Base `R`| [`summary(x)`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/summary)|`summary(x)`| Returns a summary of the values in object `x`.|
| Base `R`| [`rowSums()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/rowSums)| `rowSums(df)`|Calculates sums for each row|
| Base `R`| [`colSums()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/colSums)|`colSums(df)`| Calculates sums for each column|
| Base `R`| [`rowMeans()`](https://www.rdocumentation.org/packages/fame/versions/1.03/topics/rowMeans)| `rowMeans(df)`|Calculates means for each row|
| Base `R`| [`colMeans()`](https://www.statology.org/colmeans-in-r/)|`colMeans(df)`| Calculates means for each column|

\* This format was adapted from the [cheatsheet format from AlexsLemonade](https://github.com/AlexsLemonade/training-modules/tree/master/module-cheatsheets).
