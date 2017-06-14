## ----readin, message = FALSE---------------------------------------------
# readin is just a "label" for this code chunk
## code chunk is just a "chunk" of code, where this code usually
## does just one thing, aka a module
### comments are still # here
### you can do all your reading in there
### let's say we loaded some packages
library(stringr)
library(dplyr)
library(tidyr)
library(readr)
fname <- "http://johnmuschelli.com/intro_to_r/data/Bike_Lanes.csv"
bike = read_csv(fname)

## ---- echo = FALSE-------------------------------------------------------
no.missyear <- bike %>% filter(dateInstalled != 0)
plot(no.missyear$dateInstalled, no.missyear$length)
boxplot(length ~ dateInstalled, data = no.missyear)

## ---- echo = TRUE--------------------------------------------------------
no.missyear = no.missyear %>%  mutate(dateInstalled = factor(dateInstalled)) 
library(ggplot2)
gbox = no.missyear %>% ggplot(aes(x = dateInstalled, y = length)) + geom_boxplot()
print(gbox)

## ------------------------------------------------------------------------
no.missyear <- no.missyear %>% mutate(log.length = log10(length))
### see here that if you specify the data argument, you don't need to do the $ 
boxplot(log.length ~ dateInstalled, data = no.missyear, 
        main = "Boxplots of Bike Lenght by Year", 
        xlab="Year", 
        ylab="Bike Length")

glogbox = no.missyear %>% ggplot(aes(x = dateInstalled, y = log.length)) + geom_boxplot() + 
  ggtitle("Boxplots of Bike Lenght by Year") + 
  xlab("Year") + 
  ylab("Bike Length")
print(glogbox)

## ------------------------------------------------------------------------
boxplot(log.length ~ dateInstalled, 
        data=no.missyear, 
        main="Boxplots of Bike Lenght by Year",
        xlab="Year", 
        ylab="Bike Length", 
        col="red")
glogbox + geom_boxplot(fill = "red")

## ------------------------------------------------------------------------
### type is a character, but when R sees a "character" in a "formula", then it automatically converts it to factor
### a formula is something that has a y ~ x, which says I want to plot y against x
### or if it were a model you would do y ~ x, which meant regress against y
boxplot(log.length ~ type, data=no.missyear, main="Boxplots of Bike Lenght by Year", xlab="Year", ylab="Bike Length")

## ------------------------------------------------------------------------
glogbox + facet_wrap(~ type)

## ------------------------------------------------------------------------
glogbox + aes(colour = type)

## ------------------------------------------------------------------------
no.missyear %>% group_by(type) %>% 
  dplyr::summarise(mean = mean(log.length))

## ------------------------------------------------------------------------
no.missyear %>% group_by(type, dateInstalled) %>% 
  dplyr::summarise(mean = mean(log.length),
      median = median(log.length),
      Std.Dev = sd(log.length))

## ------------------------------------------------------------------------
### type is a character, but when R sees a "character" in a "formula", then it automatically converts it to factor
### a formula is something that has a y ~ x, which says I want to plot y against x
### or if it were a model you would do y ~ x, which meant regress against y
mod.type = lm(log.length ~ type, data = no.missyear)
mod.yr = lm(log.length ~ factor(dateInstalled), data = no.missyear)
mod.yrtype = lm(log.length ~ type + factor(dateInstalled), data = no.missyear)
summary(mod.type)

## ------------------------------------------------------------------------
smod = summary(mod.type)
coef(smod)
class(coef(smod))

## ------------------------------------------------------------------------
library(broom)
smod2 = tidy(mod.type)
class(smod2)
better = smod2 %>% mutate(term = str_replace(term, "^type", ""))
better
better %>% filter(term == "SIDEPATH")
write.csv(better, file = "Best_Model_Coefficients.csv")

## ------------------------------------------------------------------------
library(xlsx)
write.xlsx(better, file = "Best_Model_Coefficients.xlsx")

## ------------------------------------------------------------------------
my_lrtest = anova(mod.yrtype, mod.yr)
print(my_lrtest)
print(tidy(my_lrtest))

## ------------------------------------------------------------------------
my_lrtest = anova(mod.yrtype, mod.type)
print(tidy(my_lrtest))

## ------------------------------------------------------------------------
# devtools::install_github('Rapporter/pander') # need this version!
library(pander)
pander(mod.yr)

## ------------------------------------------------------------------------
pander(summary(mod.yr))

## ------------------------------------------------------------------------
ptable = tidy(mod.yr)
ptable$term = ptable$term %>% 
  str_replace(fixed("factor(dateInstalled)"), "") %>%
  str_replace(fixed("(Intercept)"), "Intercept")

## ------------------------------------------------------------------------
colnames(ptable) = c("Variable", "Beta", "SE", "tstatistic", "p.value")
pander(ptable)

## ------------------------------------------------------------------------
cint = confint(mod.yr)
print(cint)
print(class(cint))

## ------------------------------------------------------------------------
cint = tidy(cint)
colnames(cint) = c("Variable", "lower", "upper")
cint$Variable = cint$Variable %>% 
  str_replace(fixed("factor(dateInstalled)"), "") %>%
  str_replace(fixed("(Intercept)"), "Intercept")
ptable = left_join(ptable, cint, by = "Variable")
ptable = ptable %>% mutate(lower = round(lower, 2),
                           upper = round(lower, 2),
                           Beta = round(Beta, 2),
                           p.value = ifelse(p.value < 0.01, "< 0.01", 
                                            round(p.value,2)))
ptable = ptable %>% mutate(ci = paste0("(", lower, ", ", upper, ")"))
ptable = dplyr::select(ptable, Beta, ci, p.value)
pander(ptable)

## ------------------------------------------------------------------------
# pander(mod.yr, mod.yrtype) does not work
# pander(list(mod.yr, mod.yrtype)) # will give 2 separate tables

## ---- message = FALSE----------------------------------------------------
library(memisc)
mtab_all <- mtable("Model Year" = mod.yr,
                   "Model Type" = mod.type,
                   "Model Both" = mod.yrtype, 
                   summary.stats = c("sigma","R-squared","F","p","N"))
print(mtab_all)

## ------------------------------------------------------------------------
write.mtable(mtab_all, file = "my_tab.txt")

## ------------------------------------------------------------------------
pander(mtab_all)

## ------------------------------------------------------------------------
renamer = function(model) {
  names(model$coefficients) = names(model$coefficients) %>% 
  str_replace(fixed("factor(dateInstalled)"), "") %>%
  str_replace(fixed("(Intercept)"), "Intercept")
  names(model$contrasts) = names(model$contrasts) %>% 
  str_replace(fixed("factor(dateInstalled)"), "") %>%
  str_replace(fixed("(Intercept)"), "Intercept")
  return(model)
}
mod.yr = renamer(mod.yr)
mod.yrtype = renamer(mod.yrtype)
mod.type = renamer(mod.type)

mtab_all_better <- mtable("Model Year" = mod.yr,
                   "Model Type" = mod.type,
                   "Model Both" = mod.yrtype, 
                   summary.stats = c("sigma","R-squared","F","p","N"))
pander(mtab_all_better)

## ------------------------------------------------------------------------
require(stargazer)

## ---- results='markup', comment=""---------------------------------------
stargazer(mod.yr, mod.type, mod.yrtype, type = "text")

## ---- results='asis', comment=""-----------------------------------------
stargazer(mod.yr, mod.type, mod.yrtype, type="html")

## ----computes------------------------------------------------------------
### let's get number of bike lanes installed by year
n.lanes = no.missyear %>% group_by(dateInstalled) %>% dplyr::summarize(n())
class(n.lanes)
print(n.lanes)
n.lanes = as.data.frame(n.lanes)
print(n.lanes)

## ------------------------------------------------------------------------
colnames(n.lanes) <- c("date", "nlanes")
n2009 <- filter(n.lanes, date == 2009)
n2010 <- filter(n.lanes, date == 2010)
getwd()

## ------------------------------------------------------------------------
fname <- "http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv"
## file.path takes a directory and makes a full name with a full file path
charm = read.csv(fname, as.is=TRUE)

library(chron)
days = levels(weekdays(1, abbreviate=FALSE))
charm$day <- factor(charm$day, levels=days)
charm$date <- as.Date(charm$date, format="%m/%d/%Y")
cn <- colnames(charm)
daily <- charm[, c("day", "date", "daily")]


## ------------------------------------------------------------------------
charm$daily <- NULL
require(reshape)
long.charm <- melt(charm, id.vars = c("day", "date"))
long.charm$type <- "Boardings"
long.charm$type[ grepl("Alightings", long.charm$variable)] <- "Alightings"
long.charm$type[ grepl("Average", long.charm$variable)] <- "Average"

long.charm$line <- "orange"
long.charm$line[ grepl("purple", long.charm$variable)] <- "purple"
long.charm$line[ grepl("green", long.charm$variable)] <- "green"
long.charm$line[ grepl("banner", long.charm$variable)] <- "banner"
long.charm$variable <- NULL

long.charm$line <-factor(long.charm$line, levels=c("orange", "purple", 
                                                   "green", "banner"))

head(long.charm)

### NOW R has a column of day, the date, a "value", the type of value and the 
### circulator line that corresponds to it
### value is now either the Alightings, Boardings, or Average from the charm dataset

## ----plots---------------------------------------------------------------
require(ggplot2)
### let's make a "ggplot"
### the format is ggplot(dataframe, aes(x=COLNAME, y=COLNAME))
### where COLNAME are colnames of the dataframe
### you can also set color to a different factor
### other options in AES (fill, alpha level -which is the "transparency" of points)
g <- ggplot(long.charm, aes(x=date, y=value, color=line)) 
### let's change the colors to what we want- doing this manually, not letting it choose
### for me
g <- g + scale_color_manual(values=c("orange", "purple", "green", "blue"))
### plotting points
g + geom_point()
### Let's make Lines!
g + geom_line()
### let's make a new plot of poitns
gpoint <- g + geom_point()
### let's plot the value by the type of value - boardings/average, etc
gpoint + facet_wrap(~ type)

## ---- warning=FALSE------------------------------------------------------
## let's compare vertically 
gpoint + facet_wrap(~ type, ncol=1)

gfacet = g + facet_wrap(~ type, ncol=1)

## ---- warning=FALSE------------------------------------------------------
## let's smooth this - get a rough estimate of what's going on
gfacet + geom_smooth(se=FALSE)

## ---- echo=FALSE, warning=FALSE, fig.width=10, fig.height=5--------------
#### COMBINE! - let's make the line width bigger (lwd)
### also making the "alpha level" (transparency) low for the point sos we can see the lines
g + geom_point(alpha=0.2) +  geom_smooth(se=FALSE, lwd=1.5) + facet_wrap( ~ type)

## ---- echo=FALSE, warning=FALSE, message = FALSE, fig.width=10, fig.height=5----
g + geom_point(alpha=0.2) +  geom_smooth(se=FALSE, lwd=1.5) + facet_wrap( ~ type)

