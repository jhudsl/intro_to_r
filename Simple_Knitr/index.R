## ----read----------------------------------------------------------------
library(stringr)
library(plyr)
library(pander)

bl = read.csv("http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv", as.is =TRUE)
bl2 = bl
bl2$numLanes = factor(bl2$numLanes)
mod2 = lm(length ~ numLanes, data = bl2)

mod = lm(length ~ factor(numLanes), data = bl)
smod = summary(mod)
ci = confint(mod)
mat = cbind(smod$coefficients[, "Estimate"], ci)
mat = data.frame(mat)
colnames(mat) = c("Beta", "Lower", "Upper")
mat$CI = paste0("(", round(mat$Lower, 2), 
                ", ", round(mat$Upper, 2), ")")
mat = mat[, c("Beta", "CI")]
mat$Variable = rownames(mat)
rownames(mat) = NULL
mat$Variable = str_replace(mat$Variable, fixed("factor(numLanes)"), "Number of Lanes: ")
mat = mat[, c("Variable", "Beta", "CI")]
mat$Variable = plyr::revalue(mat$Variable, c("(Intercept)" = "B0"))

## ---- results='asis'-----------------------------------------------------
pander(mat)

## ---- results='asis'-----------------------------------------------------
pander(smod)

## ---- results='asis'-----------------------------------------------------
pander(mod)

## ---- echo=FALSE---------------------------------------------------------
plot(cars)

## ------------------------------------------------------------------------
pvals =smod$coefficients[, "Pr(>|t|)"]
pvals = ifelse(pvals < 0.001, "< 0.001", round(pvals, 2))

