## ----knit-setup, echo=FALSE, include = FALSE----------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, 
               message = FALSE, 
               warning = FALSE,
               fig.height = 4,
               fig.width = 7, 
               comment = "")
library(tidyverse)
library(jhur)


## ----seed, comment="",echo=FALSE----------------------------------------------
set.seed(3) 


## ----plotEx,  fig.align='center',cache=FALSE----------------------------------
library(readr)
mort = read_csv(
  "http://johnmuschelli.com/intro_to_r/data/indicatordeadkids35.csv")
mort[1:2, 1:5]


## ----fig.align='center',cache=FALSE-------------------------------------------
jhur::read_mortality()


## -----------------------------------------------------------------------------
mort = mort %>% rename(country = X1)
mort[1:2, 1:5]


## -----------------------------------------------------------------------------
library(tidyverse)
long = mort
long = long %>% pivot_longer(!country, 
                             names_to = "year", values_to = "morts")
head(long, 2)


## -----------------------------------------------------------------------------
library(stringr)
library(dplyr)
long$year = long$year %>% str_replace("^X", "") %>% as.numeric
long = long %>% filter(!is.na(morts))


## ----plot_long_swede, fig.align='center'--------------------------------------
swede_long = long %>% filter(country == "Sweden")
qplot(x = year, y = morts, data = swede_long)


## ----plot_long_swede_xlim, fig.align='center', warning=FALSE------------------
qplot(x = year, y = morts, data = swede_long, xlim = c(1760,2012))


## -----------------------------------------------------------------------------
library(ggplot2)
qplot(x = year, y = morts, data = swede_long)


## ----generic_gg, comment="",  fig.align='center', cache=FALSE-----------------
g = ggplot(data = swede_long, aes(x = year, y = morts))


## ----gen_q, comment="",  fig.align="center", cache=FALSE----------------------
q = qplot(data = swede_long, x = year, y = morts)
q


## ----gprint_point-------------------------------------------------------------
gpoints = g + geom_point(); print(gpoints) # one line for slides


## ----geom_line----------------------------------------------------------------
g + geom_line()


## ----geom_line_point----------------------------------------------------------
g + geom_line() + geom_point()


## ----line_smooth--------------------------------------------------------------
g + geom_line() + geom_smooth()


## ----geom_all-----------------------------------------------------------------
sub = long %>% filter(country %in% c("United States", "United Kingdom", 
    "Sweden", "Afghanistan", "Rwanda"))
g = sub %>% ggplot(aes(x = year, y = morts, colour = country))
g + geom_line()


## ----geom_color---------------------------------------------------------------
g + geom_line() + scale_colour_manual(values = 
    c("United States" = "blue", "United Kingdom" = "green", 
      "Sweden" = "black", "Afghanistan" = "red", "Rwanda" = "orange"))


## ----geom_noguide-------------------------------------------------------------
g + geom_line() + guides(colour = FALSE)


## ----geom_box-----------------------------------------------------------------
ggplot(long, aes(x = year, y = morts)) + geom_boxplot()


## ----geom_box_fac-------------------------------------------------------------
ggplot(long, aes(x = factor(year), y = morts)) + geom_boxplot()


## ----geom_box_grouped---------------------------------------------------------
ggplot(long, aes(x = year, y = morts, group = year)) + geom_boxplot()


## ----geom_box_jitter----------------------------------------------------------
sub_year = long %>% filter( year > 1995 & year <= 2000)
ggplot(sub_year, aes(x = factor(year), y = morts)) + 
  geom_boxplot(outlier.shape = NA) + # don't show outliers - will below
  geom_jitter(height = 0)


## -----------------------------------------------------------------------------
sub %>% ggplot(aes(x = year, y = morts)) + 
  geom_line() + 
  facet_wrap(~ country)


## -----------------------------------------------------------------------------
sub %>% ggplot(aes(x = year, y = morts)) + 
  geom_line() + 
  facet_wrap(~ country, ncol = 1)


## -----------------------------------------------------------------------------
qplot(x = year, y = morts, geom = "line", facets = ~ country, data = sub)


## ---- eval = FALSE------------------------------------------------------------
## sub %>% ggplot(aes(x = year, y = morts)) +
##   geom_line() +
##   facet_wrap(~ country + x2 + ... )


## ----labs_save, eval = TRUE---------------------------------------------------
png("morts_over_time.png")
print(q)
dev.off()
file.exists("morts_over_time.png")


## ----labs_del, echo = FALSE, results="hide"-----------------------------------
file.remove("morts_over_time.png")


## ----labs, eval = TRUE--------------------------------------------------------
q = qplot(x = year, y = morts, colour = country, data = sub,
          geom = "line") + 
  xlab("Year of Collection") + ylab("morts /100,000") +
  ggtitle("Mortality of Children over the years", subtitle = "not great") 
q


## ----theme_bw, eval = TRUE----------------------------------------------------
q + theme_bw()


## ----theme, eval = TRUE-------------------------------------------------------
q + theme(text = element_text(size = 12), title = element_text(size = 20))


## ----theme2, eval = TRUE------------------------------------------------------
q = q + theme(axis.text = element_text(size = 14),
          title = element_text(size = 20),
          axis.title = element_text(size = 16),
          legend.position = c(0.9, 0.8)) + 
  guides(colour = guide_legend(title = "Country"))
q


## ----translegend--------------------------------------------------------------
transparent_legend =  theme(legend.background = element_rect(
    fill = "transparent"),
  legend.key = element_rect(fill = "transparent", 
                            color = "transparent") )
q + transparent_legend


## ----qhist_mort, comment="", fig.align='center', cache=FALSE------------------
qplot(x = morts, data = sub, bins = 200)


## ----ghist, comment="", fig.align='center', cache = FALSE---------------------
qplot(x = morts, fill = factor(country),
      data = sub, geom = c("histogram"))


## ----ghist_alpha, comment="", fig.align='center', cache = FALSE---------------
qplot(x = morts, fill = country, data = sub, 
      geom = c("histogram"), alpha=.7)


## ----gdens, comment="", fig.align='center', cache = FALSE---------------------
qplot(x= morts, fill = country, data = sub, 
      geom = c("density"), alpha= .7)  + guides(alpha = FALSE)


## ----gdens_alpha, comment="", fig.align='center', cache = FALSE---------------
qplot(x = morts, colour = country, data = sub, 
      geom = c("density"), alpha= .7) + guides(alpha = FALSE)


## ----gdens_line_alpha_mort, comment="", fig.align='center', cache = FALSE-----
ggplot(aes(x = morts, colour = country), data = sub) + 
  geom_line(stat = "density")


## ----geom_line_qplot_nocol, comment="", fig.align='center', cache=FALSE-------
qplot(x = year, y = morts, colour = country, 
    data = long, geom = "line") + guides(colour = FALSE)


## ----geom_tile_qtile----------------------------------------------------------
qtile = qplot(x = year, y = country, fill = morts, data = sub, 
              geom = "tile") + xlim(1990, 2005) + guides(colour = FALSE)

## ----geom_tile_qtile_show, echo = FALSE---------------------------------------
print(qtile)


## ----geom_tile_rescale--------------------------------------------------------
qtile + scale_fill_gradient( low = "blue", high = "red")


## ----geom_tile_cut------------------------------------------------------------
sub$cat = cut(sub$morts, breaks = c(0, 1, 2, max(sub$morts)))
q2 = qplot(x = year, y = country, fill = cat, data = sub, geom = "tile") + 
  guides(colour = FALSE)

## ----geom_tile_qtile2_show, echo = FALSE--------------------------------------
print(q2)


## ----geom_tile_rescale_brewer-------------------------------------------------
q2 + scale_fill_brewer( type = "div", palette =  "RdBu" )


## ----barplot2, fig.align='center', cache = FALSE, warn = FALSE----------------
cars = read_csv(
  "http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv", 
  col_types = cols(VehBCost = col_double()))
counts <- table(cars$IsBadBuy, cars$VehicleAge)


## ----barplot2_2, fig.align='center', cache = FALSE, warn = FALSE--------------
barplot(counts, main="Car Distribution by Age and Bad Buy Status", xlab="Vehicle Age", col=c("darkblue","red"), legend = rownames(counts))


## ----barplot2a, fig.align='center', cache = FALSE-----------------------------
## Use percentages (column percentages)
barplot(prop.table(counts, 2), 
        main = "Car Distribution by Age and Bad Buy Status",
  xlab="Vehicle Age", col=c("darkblue","red"),
    legend = rownames(counts))


## ----barplot2_stacked_geom, fig.align='center', cache = FALSE-----------------
ggplot(aes(fill = factor(IsBadBuy), x = VehicleAge), 
       data = cars) + geom_bar()


## ----make_perc_data, fig.align='center', cache = FALSE------------------------
perc = cars %>% 
  group_by(IsBadBuy, VehicleAge) %>% 
  tally() %>% ungroup
head(perc)


## ----norm_bar_1---------------------------------------------------------------
perc_is_bad = perc %>% 
  group_by(VehicleAge) %>% mutate(perc = n / sum(n))
ggplot(aes(fill = factor(IsBadBuy), 
           x = VehicleAge, 
           y = perc), 
       data = perc_is_bad) + geom_bar(stat = "identity")


## ----norm_bad_buy-------------------------------------------------------------
perc_yr = perc %>% 
  group_by(IsBadBuy) %>% mutate(perc = n / sum(n))
ggplot(aes(fill = factor(VehicleAge), 
           x = IsBadBuy, 
           y = perc), 
       data = perc_yr) + geom_bar(stat = "identity")


## ----ghist_chick, comment="", fig.align='center', cache = FALSE---------------
qplot(x = weight, 
      fill = factor(Diet),
      data = ChickWeight, 
      geom = c("histogram"))


## ----ghist_chick_alpha, comment="", fig.align='center', cache = FALSE---------
qplot(x = weight, fill = Diet, data = ChickWeight, 
      geom = c("histogram"), alpha=.7)


## ----gdens_chick, comment="", fig.align='center', cache = FALSE---------------
qplot(x= weight, fill = Diet, data = ChickWeight, 
      geom = c("density"), alpha= .7)


## ----gdens_chick_alpha, comment="", fig.align='center', cache = FALSE---------
qplot(x= weight, colour = Diet, data = ChickWeight, 
      geom = c("density"), alpha=.7)


## ----gdens_alpha_gg, comment="", fig.align='center', cache = FALSE------------
ggplot(aes(x= weight, colour = Diet), 
  data = ChickWeight) + geom_density(alpha=.7)


## ----gdens_line_alpha, comment="", fig.align='center', cache = FALSE----------
ggplot(aes(x = weight, colour = Diet), data = ChickWeight) + 
  geom_line(stat = "density")


## ----spaghetti, comment="", fig.align='center', cache=FALSE-------------------
qplot(x=Time, y=weight, colour = factor(Chick), 
      data = ChickWeight, geom = "line")


## ----fac_spag, comment="", fig.align='center', cache=FALSE--------------------
qplot(x = Time, y = weight, colour = factor(Chick), 
      facets = ~Diet, data = ChickWeight, geom = "line")


## ----fac_spag_noleg, comment="", fig.align='center', cache=FALSE--------------
qplot(x=Time, y=weight, colour = factor(Chick), 
      facets = ~ Diet,  data = ChickWeight, 
        geom = "line") + guides(colour=FALSE)


## ----fac_spag2, comment="", fig.align='center', cache=FALSE-------------------
ggplot(aes(x = Time, y = weight, colour = factor(Chick)), 
    data = ChickWeight) + geom_line() + 
    facet_wrap(facets = ~Diet) + guides(colour = FALSE)


## ----plot1, comment="",  fig.align='center',cache = FALSE---------------------
library(dplyr)
sweden = mort %>% 
  filter(country == "Sweden") %>% 
  select(-country)
year = as.numeric(colnames(sweden))
plot(as.numeric(sweden) ~ year)


## ----plotEx2, comment="",  fig.align='center',cache = FALSE-------------------
plot(as.numeric(sweden) ~ year,
      ylab = "# of morts per family", main = "Sweden", type = "l")


## ----plotEx3, fig.align='center', cache = FALSE-------------------------------
plot(as.numeric(sweden) ~ year,
      ylab = "# of morts per family", main = "Sweden",
     xlim = c(1760,2012), pch = 19, cex=1.2,col="blue")


## ----plotEx_sub, fig.align='center', cache = FALSE----------------------------
plot(as.numeric(sweden) ~ year,
      ylab = "# of morts per family", main = "Sweden",
     subset = year < 2015, pch = 19, cex=1.2,col="blue")


## ----barplot3, fig.align='center', cache = FALSE------------------------------
# Stacked Bar Plot with Colors and Legend    
barplot(counts, main="Car Distribution by Age and Bad Buy Status",
  xlab="Vehicle Age", col=c("darkblue","red"),
    legend = rownames(counts), beside=TRUE)


## ----boxplots, comment="", fig.align='center', cache=FALSE--------------------
boxplot(weight ~ Diet, data=ChickWeight, outline=FALSE)
points(ChickWeight$weight ~ jitter(as.numeric(ChickWeight$Diet),0.5))


## ----box_ex, eval=FALSE-------------------------------------------------------
## boxplot(weight ~ Diet, data=ChickWeight, outline=FALSE)


## ----pal, fig.align='center', cache = FALSE-----------------------------------
palette("default")
plot(1:8, 1:8, type="n")
text(1:8, 1:8, lab = palette(), col = 1:8)


## ----pal2, fig.align='center', cache = FALSE----------------------------------
palette(c("darkred","orange","blue"))
plot(1:3,1:3,col=1:3,pch =19,cex=2)


## ----pal5, fig.align='center', cache=FALSE------------------------------------
library(RColorBrewer)
palette(brewer.pal(5,"Dark2"))
plot(weight ~ jitter(Time,amount=0.2),data=ChickWeight,
     pch = 19,  col = Diet,xlab="Time")


## ----leg1, fig.align='center', cache=FALSE------------------------------------
palette(brewer.pal(5,"Dark2"))
plot(weight ~ jitter(Time,amount=0.2),data=ChickWeight,
                pch = 19,  col = Diet,xlab="Time")
legend("topleft", paste("Diet",levels(ChickWeight$Diet)), 
        col = 1:length(levels(ChickWeight$Diet)),
       lwd = 3, ncol = 2)


## ----circ, comment="", fig.align='center', cache=FALSE------------------------
circ = read_csv("http://johnmuschelli.com/intro_to_r/data/Charm_City_Circulator_Ridership.csv")
palette(brewer.pal(7,"Dark2"))
dd = factor(circ$day)
plot(orangeAverage ~ greenAverage, data=circ, 
     pch=19, col = as.numeric(dd))
legend("bottomright", levels(dd), col=1:length(dd), pch = 19)


## ----circ2, comment="", fig.align='center', cache=FALSE-----------------------
dd = factor(circ$day, levels=c("Monday","Tuesday","Wednesday",
            "Thursday","Friday","Saturday","Sunday"))
plot(orangeAverage ~ greenAverage, data=circ,
     pch=19, col = as.numeric(dd))
legend("bottomright", levels(dd), col=1:length(dd), pch = 19)

