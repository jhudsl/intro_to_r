---
classoption: landscape
output: pdf_document
---

# Day 9 Cheatsheet

## Functions

**Why create your own functions?**
- Cut down on repetitive code (easier to fix things!)
- Organize code into manageable chunks
- Avoid running code unintentionally
- Use names that make sense to you


Syntax for a function is:
```
functionName <- function(inputs) {
  # Document your inputs here
  <function body>
  return(value)
}
```
### Functions
|Library/Package|Piece of code|Example of usage|What it does|
|---------------|-------------|----------------|-------------|
| Base `R`| [`lapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lapply)| `lapply(some_list, a_function`)| Apply a function over a list or vector.|
| Base `R`| [`sapply()`](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lapply)| `sapply(some_list, a_function`)| Apply a function over a list or vector but by default returns a matrix or vector.|

\* This format was adapted from the [cheatsheet format from AlexsLemonade](https://github.com/AlexsLemonade/training-modules/tree/master/module-cheatsheets).
