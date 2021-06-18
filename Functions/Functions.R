## ----return2a, comment=""-----------------------------------------------------
return2a = function(x) x[2]


## ----return2a2, comment=""----------------------------------------------------
return2a(x = c(1,4,5,76))


## ----return2b, comment=""-----------------------------------------------------
return2b = function(x) {
  x[2]
}
return2b(x = c(1,4,5,76))


## ----return2c, comment=""-----------------------------------------------------
return2c = function(x) {
  output = x[2]
  return(output)
}
return2c(x = c(1,4,5,76))


## ----return_n, comment=""-----------------------------------------------------
return_n = function(x, n) x[n]
return_n(x = c(1,4,5,76), n = 3)


## ----return_n2, comment=""----------------------------------------------------
return_n2 = function(x = c(1,2,3), n = 2) x[n]
return_n2()


## ----sqdif, comment=""--------------------------------------------------------
sqdif <- function(x=2,y=3) (x-y)^2

sqdif()
sqdif(x=10,y=5)
sqdif(10,5)


## ----top, message=FALSE-------------------------------------------------------
top = function(df, n=5) df[1:n, 1:n]
bike = jhur::read_bike()

## ---- comment=""--------------------------------------------------------------
top(bike) # Note that we are using the default value for n 


## ----sapply1, comment=""------------------------------------------------------
sapply(bike, class)
sapply(bike$length, log)

