
library(ggplot2)
qplot(x = year, y = deaths, data = swede_long)
## ----generic_gg, comment="",  fig.align='center', cache=FALSE------------
g = ggplot(data = swede_long, aes(x = year, y = deaths))
## ----gprint_point--------------------------------------------------------
gpoints = g + geom_point(); print(gpoints) # one line for slides
## ----geom_line-----------------------------------------------------------
g + geom_line()
## ----geom_line_point-----------------------------------------------------
g + geom_line() + geom_point()
g + geom_line(color = "green") + geom_point()
g + geom_point() + geom_line(color = "green")
g + geom_line(color = "green") + geom_point()
mat = matrix(c(
"Day 1", "https://youtu.be/Xi-wsACc7p0",
"Day 2", "https://youtu.be/u1FQt9Hr8iw",
"Day 3", "https://youtu.be/woc7AGJTzZw",
"Day 4", "https://youtu.be/RZ7eVIMPIes",
"Day 5", ""), ncol = 2)
mat = matrix(c(
"Day 1", "https://youtu.be/Xi-wsACc7p0",
"Day 2", "https://youtu.be/u1FQt9Hr8iw",
"Day 3", "https://youtu.be/woc7AGJTzZw",
"Day 4", "https://youtu.be/RZ7eVIMPIes",
"Day 5", ""), ncol = 2)
mat = data.frame(mat, stringsAsFactors = FALSE)
knitr::kable(mat, format = "html") %>%
kable_styling() %>%
source('~/.active-rstudio-document', echo=TRUE)
library(RColorBrewer)
palette(brewer.pal(5,"Dark2"))
?palette()
library(ggplot2
)
?scale_color_brewer()
## ----knit-setup, echo=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE,
message = FALSE,
warning = FALSE,
fig.height = 4,
fig.width = 7,
comment = "")
## ----seed, comment="",echo=FALSE-----------------------------------------
set.seed(3)
## ----plotEx,  fig.align='center',cache=FALSE-----------------------------
library(readr)
death = read_csv(
"http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv")
death[1:2, 1:5]
## ------------------------------------------------------------------------
colnames(death)[1] = "country"
death[1:2, 1:5]
## ----plot1, comment="",  fig.align='center',cache = FALSE----------------
library(dplyr)
sweden = death %>%
filter(country == "Sweden") %>%
select(-country)
year = as.numeric(colnames(sweden))
plot(as.numeric(sweden) ~ year)
## ----plotEx2, comment="",  fig.align='center',cache = FALSE--------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden", type = "l")
## ----plotEx3, fig.align='center', cache = FALSE--------------------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden",
xlim = c(1760,2012), pch = 19, cex=1.2,col="blue")
## ----plotEx_sub, fig.align='center', cache = FALSE-----------------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden",
subset = year < 2015, pch = 19, cex=1.2,col="blue")
## ----makelong_swede, fig.align='center', cache = FALSE-------------------
library(tidyr)
long = gather(death, key = year, value = deaths, -country)
long = long %>% filter(!is.na(deaths))
head(long)
class(long$year)
long$year = as.numeric(long$year)
## ----plot_long_swede, fig.align='center'---------------------------------
swede_long = long %>% filter(country == "Sweden")
plot(deaths ~ year, data = swede_long)
## ------------------------------------------------------------------------
library(ggplot2)
qplot(x = year, y = deaths, data = swede_long)
## ----generic_gg, comment="",  fig.align='center', cache=FALSE------------
g = ggplot(data = swede_long, aes(x = year, y = deaths))
## ----gprint_point--------------------------------------------------------
gpoints = g + geom_point(); print(gpoints) # one line for slides
## ----geom_line-----------------------------------------------------------
g + geom_line()
## ----geom_line_point-----------------------------------------------------
g + geom_line() + geom_point()
## ----line_smooth---------------------------------------------------------
g + geom_line() + geom_smooth()
## ----geom_all------------------------------------------------------------
sub = long %>% filter(country %in%
c("United States", "United Kingdom", "Sweden",
"Afghanistan", "Rwanda"))
g = ggplot(sub, aes(x = year, y = deaths, colour = country))
g + geom_line()
## ----geom_noguide--------------------------------------------------------
g + geom_line() + guides(colour = FALSE)
## ----geom_box------------------------------------------------------------
ggplot(long, aes(x = year, y = deaths)) + geom_boxplot()
## ----geom_box_fac--------------------------------------------------------
ggplot(long, aes(x = factor(year), y = deaths)) + geom_boxplot()
## ----geom_box_jitter-----------------------------------------------------
sub_year = long %>% filter( year > 1995 & year <= 2000)
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_boxplot(outlier.shape = NA) + # don't show outliers - will below
geom_jitter(height = 0)
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_boxplot(outlier.shape = NA)
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_boxplot()
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_boxplot(outlier.shape = NA) + # don't show outliers - will below
geom_point()
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_jitter(height = 0) +
geom_boxplot(outlier.shape = NA) # don't show outliers - will below
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_jitter(height = 0) +
geom_boxplot(outlier.shape = NA, fill = NA) # don't show outliers - will below
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_jitter(height = 0) +
geom_boxplot(outlier.shape = NA, fill = NA, colour = "blue") # don't show outliers - will below
qplot(x = year, y = deaths, geom = "line",
data = sub) +  facet_wrap( ~ country)
sub$fac = sample(c("High", "Low"), replace = TRUE)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(~ country + fac)
dim(sub)
head(sub)
sub$fac = sample(c("High", "Low"),
replace = TRUE, size = nrow(sub))
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(~ country + fac)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(fac ~ country )
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(fac ~ country , ncol = 2)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(~ country +fac, ncol = 2)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_grid(fac ~ country, ncol = 2)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_grid(fac ~ country)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_grid(country ~ fac)
?dput
sub$country
unique(sub$country)
x = unique(sub$country)
dput(x)
### Data Visualization Lab
## you will need the charm city circulator dataset:
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
# read in data
# covert dates
circ = mutate(circ, date = mdy(date))
# change colnames for reshaping
colnames(circ) =  colnames(circ) %>%
str_replace("Board", ".Board") %>%
str_replace("Alight", ".Alight") %>%
str_replace("Average", ".Average")
# make long
long = gather(circ, "var", "number",
starts_with("orange"),
starts_with("purple"), starts_with("green"),
starts_with("banner"))
# separate
long = separate(long, var, into = c("line", "type"),
sep = "[.]")
## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))
# separate
type_wide = spread(long, type, value = number)
head(type_wide)
# Using ggplot2:
# 1. plot average ridership  by date.
# 	a. Color the points by route (orange, purple, green, banner)
qplot(x = date, y = number, data = avg, colour = line)
first_plot = qplot(x = date, y = number, data = avg, colour = line)
print(first_plot)
#	b. Color the points by day of the week
qplot(x = date, y = number, data = avg, colour = day)
# 2. Replot 1a where the colors of the points are the
#	name of the route (with banner --> blue)
pal = c("blue", "darkgreen","orange","purple")
qplot(x = date, y = number, data = avg, colour = line) +
scale_colour_manual(values = pal)
# 3. plot average ridership by date with one panel per route
qplot(x = date, y = number, data= avg, facets = ~line)
qplot(x = date, y = number, data= avg) +
facet_wrap( ~ line)
qplot(x = date, y = number, data= avg, facets = ~day,
library(ggplot2)
qplot(x = year, y = deaths, data = swede_long)
## ----generic_gg, comment="",  fig.align='center', cache=FALSE------------
g = ggplot(data = swede_long, aes(x = year, y = deaths))
## ----gprint_point--------------------------------------------------------
gpoints = g + geom_point(); print(gpoints) # one line for slides
## ----geom_line-----------------------------------------------------------
g + geom_line()
## ----geom_line_point-----------------------------------------------------
g + geom_line() + geom_point()
g + geom_line(color = "green") + geom_point()
g + geom_point() + geom_line(color = "green")
g + geom_line(color = "green") + geom_point()
mat = matrix(c(
"Day 1", "https://youtu.be/Xi-wsACc7p0",
"Day 2", "https://youtu.be/u1FQt9Hr8iw",
"Day 3", "https://youtu.be/woc7AGJTzZw",
"Day 4", "https://youtu.be/RZ7eVIMPIes",
"Day 5", ""), ncol = 2)
mat = matrix(c(
"Day 1", "https://youtu.be/Xi-wsACc7p0",
"Day 2", "https://youtu.be/u1FQt9Hr8iw",
"Day 3", "https://youtu.be/woc7AGJTzZw",
"Day 4", "https://youtu.be/RZ7eVIMPIes",
"Day 5", ""), ncol = 2)
mat = data.frame(mat, stringsAsFactors = FALSE)
knitr::kable(mat, format = "html") %>%
kable_styling() %>%
source('~/.active-rstudio-document', echo=TRUE)
library(RColorBrewer)
palette(brewer.pal(5,"Dark2"))
?palette()
library(ggplot2
)
?scale_color_brewer()
## ----knit-setup, echo=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE,
message = FALSE,
warning = FALSE,
fig.height = 4,
fig.width = 7,
comment = "")
## ----seed, comment="",echo=FALSE-----------------------------------------
set.seed(3)
## ----plotEx,  fig.align='center',cache=FALSE-----------------------------
library(readr)
death = read_csv(
"http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv")
death[1:2, 1:5]
## ------------------------------------------------------------------------
colnames(death)[1] = "country"
death[1:2, 1:5]
## ----plot1, comment="",  fig.align='center',cache = FALSE----------------
library(dplyr)
sweden = death %>%
filter(country == "Sweden") %>%
select(-country)
year = as.numeric(colnames(sweden))
plot(as.numeric(sweden) ~ year)
## ----plotEx2, comment="",  fig.align='center',cache = FALSE--------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden", type = "l")
## ----plotEx3, fig.align='center', cache = FALSE--------------------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden",
xlim = c(1760,2012), pch = 19, cex=1.2,col="blue")
## ----plotEx_sub, fig.align='center', cache = FALSE-----------------------
plot(as.numeric(sweden) ~ year,
ylab = "# of deaths per family", main = "Sweden",
subset = year < 2015, pch = 19, cex=1.2,col="blue")
## ----makelong_swede, fig.align='center', cache = FALSE-------------------
library(tidyr)
long = gather(death, key = year, value = deaths, -country)
long = long %>% filter(!is.na(deaths))
head(long)
class(long$year)
long$year = as.numeric(long$year)
## ----plot_long_swede, fig.align='center'---------------------------------
swede_long = long %>% filter(country == "Sweden")
plot(deaths ~ year, data = swede_long)
## ------------------------------------------------------------------------
library(ggplot2)
qplot(x = year, y = deaths, data = swede_long)
## ----generic_gg, comment="",  fig.align='center', cache=FALSE------------
g = ggplot(data = swede_long, aes(x = year, y = deaths))
## ----gprint_point--------------------------------------------------------
gpoints = g + geom_point(); print(gpoints) # one line for slides
## ----geom_line-----------------------------------------------------------
g + geom_line()
## ----geom_line_point-----------------------------------------------------
g + geom_line() + geom_point()
## ----line_smooth---------------------------------------------------------
g + geom_line() + geom_smooth()
## ----geom_all------------------------------------------------------------
sub = long %>% filter(country %in%
c("United States", "United Kingdom", "Sweden",
"Afghanistan", "Rwanda"))
g = ggplot(sub, aes(x = year, y = deaths, colour = country))
g + geom_line()
## ----geom_noguide--------------------------------------------------------
g + geom_line() + guides(colour = FALSE)
## ----geom_box------------------------------------------------------------
ggplot(long, aes(x = year, y = deaths)) + geom_boxplot()
## ----geom_box_fac--------------------------------------------------------
ggplot(long, aes(x = factor(year), y = deaths)) + geom_boxplot()
## ----geom_box_jitter-----------------------------------------------------
sub_year = long %>% filter( year > 1995 & year <= 2000)
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_boxplot(outlier.shape = NA) + # don't show outliers - will below
geom_jitter(height = 0)
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_boxplot(outlier.shape = NA)
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_boxplot()
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_boxplot(outlier.shape = NA) + # don't show outliers - will below
geom_point()
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_jitter(height = 0) +
geom_boxplot(outlier.shape = NA) # don't show outliers - will below
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_jitter(height = 0) +
geom_boxplot(outlier.shape = NA, fill = NA) # don't show outliers - will below
ggplot(sub_year, aes(x = factor(year), y = deaths)) +
geom_jitter(height = 0) +
geom_boxplot(outlier.shape = NA, fill = NA, colour = "blue") # don't show outliers - will below
qplot(x = year, y = deaths, geom = "line",
data = sub) +  facet_wrap( ~ country)
sub$fac = sample(c("High", "Low"), replace = TRUE)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(~ country + fac)
dim(sub)
head(sub)
sub$fac = sample(c("High", "Low"),
replace = TRUE, size = nrow(sub))
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(~ country + fac)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(fac ~ country )
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(fac ~ country , ncol = 2)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_wrap(~ country +fac, ncol = 2)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_grid(fac ~ country, ncol = 2)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_grid(fac ~ country)
sub %>% ggplot(aes(x = year, y = deaths)) +
geom_line() +
facet_grid(country ~ fac)
?dput
sub$country
unique(sub$country)
x = unique(sub$country)
dput(x)
### Data Visualization Lab
## you will need the charm city circulator dataset:
library(readr)
library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
# read in data
# covert dates
circ = mutate(circ, date = mdy(date))
# change colnames for reshaping
colnames(circ) =  colnames(circ) %>%
str_replace("Board", ".Board") %>%
str_replace("Alight", ".Alight") %>%
str_replace("Average", ".Average")
# make long
long = gather(circ, "var", "number",
starts_with("orange"),
starts_with("purple"), starts_with("green"),
starts_with("banner"))
# separate
long = separate(long, var, into = c("line", "type"),
sep = "[.]")
## take just average ridership per day
avg = filter(long, type == "Average")
avg = filter(avg, !is.na(number))
# separate
type_wide = spread(long, type, value = number)
head(type_wide)
# Using ggplot2:
# 1. plot average ridership  by date.
# 	a. Color the points by route (orange, purple, green, banner)
qplot(x = date, y = number, data = avg, colour = line)
first_plot = qplot(x = date, y = number, data = avg, colour = line)
print(first_plot)
#	b. Color the points by day of the week
qplot(x = date, y = number, data = avg, colour = day)
# 2. Replot 1a where the colors of the points are the
#	name of the route (with banner --> blue)
pal = c("blue", "darkgreen","orange","purple")
qplot(x = date, y = number, data = avg, colour = line) +
scale_colour_manual(values = pal)
# 3. plot average ridership by date with one panel per route
qplot(x = date, y = number, data= avg, facets = ~line)
qplot(x = date, y = number, data= avg) +
facet_wrap( ~ line)
qplot(x = date, y = number, data= avg, facets = ~day,
colour = line) +  scale_colour_manual(values=pal)
ggplot(aes(x = date, y = number, colour = line), data= avg)
+ facet_wrap( ~day) +  scale_colour_manual(values=pal)
ggplot(aes(x = date, y = number, colour = line), data= avg) +
facet_wrap( ~day) +  scale_colour_manual(values=pal)
ggplot(aes(x = date, y = number, colour = line), data= avg) +
geom_point() +
facet_wrap( ~day) +  scale_colour_manual(values=pal)
first_plot = qplot(x = date, y = number, data = avg, colour = line)
print(first_plot)
first_plot  +
xlab("Year") + ylab("Number of People")
first_plot  +
xlab("Year") + ylab("Number of People") + theme_bw()
pdf("black_and_white_theme.pdf")
first_plot  +
xlab("Year") + ylab("Number of People")
first_plot  +
xlab("Year") + ylab("Number of People") + theme_bw()
dev.off()
pdf("black_and_white_theme.pdf")
first_plot  +
xlab("Year") + ylab("Number of People")
first_plot  +
xlab("Year") + ylab("Number of People") + theme_bw()
dev.off()
first_plot  +
xlab("Year") + ylab("Number of People") + theme_bw() +
theme(text = element_text(size = 20))
orange = long %>% filter(line == "orange")
g = ggplot(orange, aes(x = date, y = number)) +
geom_line(aes(linetype = type))
g
g = ggplot(orange, aes(x = date, y = number)) +
geom_line(linetype = "dashed")
g
orange = long %>% filter(line == "orange")
g = ggplot(orange, aes(x = date, y = number)) +
geom_line(aes(linetype = type))
g
g + scale_linetype_manual(
values = c("dashed",
"dashed",
"solid"))
g + scale_linetype_manual(
values = c(Alightings = "dashed",
Boardings = "dashed",
Average = "solid"))
g = ggplot(orange, aes(x = date, y = number)) +
geom_line(aes(linetype = type), linetype = "dashed")
g
?scale_linetype_manual
g = ggplot(orange, aes(x = date, y = number)) +
geom_line(aes(linetype = type))
g
g + scale_linetype_manual(drop = FALSE)
?scale_color_manual
qplot(x= deaths, fill = country, data = sub,
geom = c("density")
)
df = data.frame(x = rnorm(1000), y = rnorm(1000))
qplot(df, x = x, y =y)
qplot(data = df, x = x, y =y)
df = data.frame(x = rnorm(10000), y = rnorm(10000))
qplot(data = df, x = x, y =y)
qplot(data = df, x = x, y =y, alpha = 0.1)
ggplot(data = df, aes(x = x, y =y)) + geom_point(alpha = 0.1)
ggplot(data = df, aes(x = x, y =y)) + geom_point()
sub$cat = cut(sub$deaths, breaks = c(0, 1, 2, max(sub$deaths)))
q2 = qplot(x = year, y = country, fill = cat, data = sub, geom = "tile") +
guides(colour = FALSE)
q2
print(q2)
source('~/Dropbox/Teaching/intro_to_r/Data_Visualization/Data_Visualization.R')
ggplot(aes(x = weight, colour = Diet), data = ChickWeight) +
geom_line(stat = "density")
ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line()
g = ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line() + guides(colour = FALSE)
g
library(plotly)
ggplotly(g)
devtools::install_github('hadley/ggplot2')
ggplotly(g)
ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line()
ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line()
library(ggplot2)
ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line()
g = ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line() + guides(colour = FALSE)
ggplotly(g)
library(plotly)
ggplotly(g)
install.packages("plotly")
install.packages("ggplot2")
ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line()
library(ggplot2)
library(plotly)
ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line()
g = ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line() + guides(colour = FALSE)
g
ggplotly(g)
g
devtools::install_github('hadley/ggplot2')
g = ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line()  + guides(colour = FALSE)
library(ggplot2)
g = ggplot(aes(x = Time, y = weight, colour = Chick),
data = ChickWeight) + geom_line()  + guides(colour = FALSE)
ggplotly(g)
library(plotly)
ggplotly(g)
?cor.test
library("psych")
data(sat.act)
corr.test(sat.act)
library("psych")
data(sat.act)
corr.test(sat.act, adjust = "none")
###########
## Statistics Lab
############
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)
#############################
# Part 1
#############################
# Read in the following infant mortality data:
# http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv
mort = read_csv("http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv")
colnames(mort)[1] = "country"
cor(mort)
mort
mort %>% select(`1980`, `1990`, `2000`, "2010")
mort %>% select(`1980`, `1990`, `2000`, "2010") %>% cor
?cor
mort %>% select(`1980`, `1990`, `2000`, "2010") %>% cor(use = "complete.obs")
library(psych)
mort %>% select(`1980`, `1990`, `2000`, "2010") %>% corr.test(use = "complete.obs")
?corr.test
mort %>% select(`1980`, `1990`, `2000`, "2010") %>% corr.test(adjust = "none")
?cor
mort_subs = mort %>%
filter(country %in% c("Myanmar", "China", "United States")) %>%
select(-country)
head(mort_sub)
head(mort_subs)
cor(mort_subs)
tmort = t(mort_subs)
head(tmort)
mort_subs[1:5, 1:5]
mort_subs = mort %>%
filter(country %in% c("Myanmar", "China", "United States"))
mort_subs[1:5, 1:5]
mort_subs[1:3, 1:5]
t(mort_subs[1:3, 1:5])
mort_subs = mort %>%
filter(country %in% c("Myanmar", "China", "United States")) %>%
select(-country)
country_cor = cor(t(mort_subs),
use = "complete.obs")
country_cor
country_cor[1,3]
country_cor[3, 1]
t.test(mort[["1990"]], mort[["2000"]])
t.test(mort$`1990`, mort$`2000`)
t.test(mort$`1990`, mort$`2000`, paired = TRUE)
## ----knit-setup, echo=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE,
message = FALSE,
warning = FALSE,
fig.height = 4,
fig.width = 7,
comment = "")
## ----cor1, comment="",prompt=TRUE, message = FALSE-----------------------
library(readr)
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
cor(circ$orangeAverage, circ$purpleAverage, use="complete.obs")
## ----cor2, comment="",prompt=TRUE----------------------------------------
library(dplyr)
avgs = circ %>% select(ends_with("Average"))
avgs_cor = cor(avgs, use = "complete.obs")
signif(avgs_cor,3)
## ----cor3, comment="",prompt=TRUE----------------------------------------
op = avgs %>% select(orangeAverage, purpleAverage)
gb = avgs %>% select(greenAverage, bannerAverage)
signif(cor(op, gb, use = "complete.obs"), 3)
## ----cor4, comment="",prompt=TRUE----------------------------------------
ct = cor.test(circ$orangeAverage, circ$purpleAverage,
use = "complete.obs")
ct
## ----cor5, comment="",prompt=TRUE----------------------------------------
# str(ct)
names(ct)
ct$statistic
ct$p.value
## ----broom, comment="",prompt=TRUE---------------------------------------
library(broom)
tidy_ct = tidy(ct)
tidy_ct
## ----cor4a, comment="", prompt=TRUE, fig.height=4,fig.width=4------------
txt = paste0("r=", signif(ct$estimate,3))
plot(circ$orangeAverage, circ$purpleAverage,
xlab="Orange Line", ylab="Purple Line",
main="Average Ridership",cex.axis=1.5,
cex.lab=1.5,cex.main=2)
legend("topleft", txt, bty="n",cex=1.5)
## ----cor_ggplot, comment="", prompt=TRUE, fig.height=4,fig.width=4-------
library(ggplot2)
q = qplot(data = circ, x = orangeAverage, y = purpleAverage)
q + annotate("text", x = 4000, y = 8000, label = txt, size = 5)
## ----tt1, comment="",prompt=TRUE-----------------------------------------
tt = t.test(circ$orangeAverage, circ$purpleAverage)
tt
## ----tt1_1, comment="", prompt=TRUE--------------------------------------
names(tt)
## ----tt1_broom, comment="", prompt=TRUE----------------------------------
tidy(tt)
## ----long_tt-------------------------------------------------------------
library(tidyr)
long = circ %>%
select(date, orangeAverage, purpleAverage) %>%
gather(key = line, value = avg, -date)
tt = t.test(avg ~ line, data = long)
tidy(tt)
## ----wt, comment="",prompt=TRUE------------------------------------------
tidy(wilcox.test(avg ~ line, data = long))
## ----regress1, comment="",prompt=TRUE------------------------------------
fit = lm(avg ~ line, data = long)
fit
## ----regress2, comment="",prompt=TRUE------------------------------------
sfit = summary(fit)
print(sfit)
## ----regress3, comment="",prompt=TRUE------------------------------------
names(sfit)
sfit$coef
## ----tidy_lm, comment="",prompt=TRUE-------------------------------------
tidy(fit)
## ----tt2, comment="",prompt=TRUE, message = FALSE------------------------
http_data_dir = "http://johnmuschelli.com/intro_to_r/data/"
cars = read_csv(paste0(http_data_dir, "kaggleCarAuction.csv"))
## ------------------------------------------------------------------------
fit = lm(VehOdo~VehicleAge, data = cars)
print(fit)
## ----regress4, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
par(mfrow=c(1,2))
plot(VehOdo ~ jitter(VehicleAge,amount=0.2), data=cars, pch = 19,
col = scales::alpha("black",0.05), xlab = "Vehicle Age (Yrs)")
abline(fit, col = "red",lwd=2)
legend("topleft", paste("p =",summary(fit)$coef[2,4]))
boxplot(VehOdo ~ VehicleAge, data=cars, varwidth=TRUE)
abline(fit, col="red",lwd=2)
## ----gg_regress, comment="",prompt=TRUE, fig.height=4,fig.width=8--------
g = ggplot(aes(x = VehicleAge, y = VehOdo), data = cars) +
geom_jitter(alpha = 0.05, height = 0) +
geom_smooth(se = FALSE, method = "lm")
print(g)
## ----regress5, comment="",prompt=TRUE, fig.height=4,fig.width=8----------
fit2 = lm(VehOdo ~ IsBadBuy + VehicleAge, data = cars)
summary(fit2)
fit2
plot(fit2)
par(mfrow=c(1,1,))
par(mfrow=c(1,1))
plot(fit2)
?family
?confint
fit2
confint(fit2)
tidy(confint(fit2))
confint_tidy(fit2)
fit2 = lm(VehOdo ~ IsBadBuy * VehicleAge, data = cars)
fit2

cbind(tidy(fit2), confint_tidy(fit2))

fit_with_int = lm(VehOdo ~ IsBadBuy * VehicleAge, data = cars)
fit_no_int = lm(VehOdo ~ IsBadBuy + VehicleAge, data = cars)
fit_with_int_year = lm(VehOdo ~ IsBadBuy * VehicleAge + factor(VehYear), data = cars)
anova(fit_with_int_year, fit_with_int, fit_no_int)


sp

ggmap

cars$IsBadBuy = factor(cars$IsBadBuy)
classes = sapply(cars, class)
facs = sapply(cars, is.factor)
fac_cols = cars[, facs]
sapply(fac_cols, levels)

classes == "factor"

sapply(cars, levels)


all.equal

df1 != df2
