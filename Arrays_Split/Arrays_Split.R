## ---- echo = FALSE, message=FALSE----------------------------------------
library(dplyr)
# paste/paste0 will be covered later
circ = read.csv(
  paste0("http://johnmuschelli.com/intro_to_r/data",
         "/Charm_City_Circulator_Ridership.csv"), 
            header = TRUE, as.is = TRUE)

## ------------------------------------------------------------------------
library(matrixStats,quietly = TRUE)
avgs = select(circ, ends_with("Average"))
rowMins(as.matrix(avgs),na.rm=TRUE)[500:510]

## ------------------------------------------------------------------------
ar = array(1:27, c(3,3,3))
ar[,,1]
ar[,1,]

## ----split1, comment="", prompt=TRUE-------------------------------------
dayList = split(circ,circ$day)

## ----lapply1, comment="", prompt=TRUE------------------------------------
# head(dayList)
lapply(dayList, head, n=2)

## ----lapply2, comment="", prompt=TRUE------------------------------------
# head(dayList)
lapply(dayList, dim)

