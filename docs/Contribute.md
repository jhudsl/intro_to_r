# Contributing Guide

This is a guide for adding content to this course.

## Editing files

To edit a lecture, edit the `index.Rmd` file.

To edit a lab, edit the Rmd files (lab and lab key).

## Rendering Files

To render most files use the `make` command in the main directory.

To render labs and lectures to just have code to create a .R file use:
`Rscript -e "knitr::purl('name_of_rmd.Rmd')"`

We will work on the old `makefiles` and perhaps use GitHub actions to make this more automated.

## Emojis
There are two ways to use emojis.

One way is to copy paste from [here](https://gist.github.com/rxaviers/7360908).

Or you can use [this package](https://github.com/hadley/emo). 

This is currently installed like:
```{r}
# install.packages("devtools")
devtools::install_github("hadley/emo")
```

To use an emoji inline with your text use:

``` `r emo::ji("smile")`  ```

To use an emoji in a chunk use:


```{r}
emo::ji("smile")
```

## Smaller text font per slide

If you want to change the style of a slide, modify the `style.css` file.

For example - this is how you can make slides with smaller font:

In the `style .css` file is the following- which creates smaller font:
```
.small {
   font-size: 0.8em;
}

```

This can be applied to a slide by putting {.small} next to a slide title like so:

`## slide name {.small}`

## Smaller code font per slide


In the `style .css` file is the following- which creates smaller font:
```
.codesmall pre {
    font-size: 16px;
}
```
This can be applied to a slide by putting {.codesmall} next to a slide title like so:

`## slide name {.codesmall}`

## Add color to slide text

```
:::{style="color: red;""}
RED STUFF!
:::
```


## Add background color to code chunk describe general syntax for code

In the `styles.css` file is the following:


```
.codeexample pre{
  background-color: lightgreen;
}
```

To add this to a chunk use this in the Rmd file before and after the chunk:

````
<div class = "codeexample">
```{r}
#some code
```
</div>
````

Additional [help](https://bookdown.org/yihui/rmarkdown/ioslides-presentation.html)


## Create gifs

To create video gifs first [record your screen](https://www.hellotech.com/guide/for/how-to-screen-record-on-mac) like so (note this is for Mac users): 

1) Command + Shift + 5 
2) Select either entire screen - or more likely a portion of the screen button
3) Click record

Next convert the video to a gif using https://ezgif.com/video-to-gif.

Be sure that you select gif as the output.


