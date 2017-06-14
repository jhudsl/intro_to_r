## ----return2, comment="",prompt=TRUE-------------------------------------
return2 = function(x) {
  return(x[2])
}
return2(c(1,4,5,76))

## ----return2a, comment="",prompt=TRUE------------------------------------
return2a = function(x) {
  x[2]
}
return2a(c(1,4,5,76))

## ----return2b, comment="",prompt=TRUE------------------------------------
return2b = function(x) x[2]
return2b(c(1,4,5,76))

## ----return2c, comment="",prompt=TRUE------------------------------------
return2c = function(x,n) x[n]
return2c(c(1,4,5,76), 3)

## ----sqdif, comment="",prompt=TRUE---------------------------------------
sqdif <- function(x=2,y=3){
     (x-y)^2
}

sqdif()
sqdif(x=10,y=5)
sqdif(10,5)

## ----top, comment="",prompt=TRUE-----------------------------------------
top = function(mat,n=5) mat[1:n,1:n]
my.mat = matrix(1:1000,nr=100) 
top(my.mat) #note that we are using the default value for n 

## ----top3, comment="",prompt=TRUE----------------------------------------
matList = list(x = matrix(1:25,nc=5),y=matrix(26:50,nc=5))
lapply(matList, function(x) x[1:2,1:2])

## ----sapply1, comment="", prompt=TRUE------------------------------------
sapply(matList, dim)
sapply(matList, class)

## ----sapply2, comment="", prompt=TRUE------------------------------------
myList = list(a=1:10, b=c(2,4,5), c = c("a","b","c"),
                d = factor(c("boy","girl","girl")))
tmp = lapply(myList,function(x) x[1])
tmp
sapply(tmp, class)

## ----sapplyDf, comment="", prompt=TRUE, message=FALSE--------------------
library(readr)
circ = read_csv(paste0("http://johnmuschelli.com/intro_to_r/",
  "data/Charm_City_Circulator_Ridership.csv"))
sapply(circ,class)

