# Day 7 Cheatsheet

## Data Visualization

### Major concepts:

- ggplot2 A tidyverse package for producing graphics
- Tidy data: Each variable forms a column and each observation forms a row.

### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
| `ggplot2`| [`ggplot()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/ggplot) | GG Plot| Begins a plot that is finished by adding layers.  |
| `ggplot2`| [`aes()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/aes) | Aesthetic Mappings     | Designates how variables in the data object are mapped to the visual properties of the ggplot.|
| `ggplot2`| [`geom_boxplot()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/geom_boxplot) | Boxplot| Creates a boxplot when added as a layer to a `ggplot()` object.   |
| `ggplot2`| [`geom_density()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/geom_density) | Density Plot| Creates a smoothed plot when added as a layer to a `ggplot()` object based on the computed density estimate.   |
| `ggplot2`| [`geom_point()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/geom_point) | Scatterplot| Creates a scatterplot when added as a layer to a `ggplot()` object.   |
| `ggplot2`| [`geom_line()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/geom_path) | Line plot| Creates a line plot when added as a layer to a `ggplot()` object by connecting the points in order of the x axis variable.   |
| `ggplot2`| [`geom_hline()`](https://www.rdocumentation.org/packages/ggplot2/versions/0.9.0/topics/geom_hline) | Horizontal line     | Annotates a plot with horizontal lines when added as a layer to a `ggplot()` object with one of the `geom` functions used to draw the plot, for example, `geom_point()`.  |
| `ggplot2`| [`theme_classic()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/ggtheme)| Classic Theme   | Displays `ggplot` without gridlines. The [`ggtheme` documentation](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/ggtheme) has descriptions on additional themes that can be used.|
| `ggplot2`| [`xlab()`; `ylab()`; `ggtitle()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/labs)  | X Axis Labels; Y Axis Labels; GG Title  | Modifies the labels on the x axis and on the y axis, and sets the title of a `ggplot`, respectively.  |
| `ggplot2`   | [`facet_wrap()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/facet_wrap)   | Facet Wrap| Plots individual graphs using specified variables to subset the data.  |
| `ggplot2`| [`ggsave()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/ggsave)  | GG Save   | Saves the last plot in working directory.|
| `ggplot2`| [`last_plot()`](https://www.rdocumentation.org/packages/ggplot2/versions/3.3.0/topics/last_plot)| Last plot | Returns the last plot produced.     |  


\* This format was adapted from the [cheatsheet format from AlexsLemonade](https://github.com/AlexsLemonade/training-modules/tree/master/module-cheatsheets).
