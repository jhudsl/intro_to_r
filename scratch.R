df = mtcars
for (icar in c("mpg", "cyl")) {
  newcol = paste0(icar, "2")
  df[, newcol] = df[, icar] ^2
}

for (icar in c("mpg", "cyl", "am")) {
  newcol = paste0(icar, "2")
  if (icar == "mpg") {
    df[, newcol] = df[, icar] ^2.5
  } else {
    df[, newcol] = df[, icar] ^2
  }
}

myears =  seq(2009, 2015)
for (iyear in myears){
  
  
}
make2 = function(df, icar = "mpg") {
  newcol = paste0(icar, "2")
  df[, newcol] = df[, icar] ^2
  return(df)
}

df = make2(df, icar = "disp")

# if (any(df$mpg > 100)) {
#   stop("NO one gets that good of gas mileage")
# }


if (any(df$mpg > 30)) {
  stop("NO one gets that good of gas mileage")
}

print("I kept going")






# Direct Labeling
# summ = avg %>% 
#   group_by(line) %>% 
#   slice(1)
# first_plot + 
#   geom_text(aes(label = line), 
#             data  = summ,
#             colour = "black")
