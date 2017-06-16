####################
# "Basic R" Module - Lab
####################

## In this lab you can use the interactive console to explore 
## 	  but please record your commands here.  
## Remember anything you type here can be "sent" to the console with 
##    Cmd-Enter (OS-X) or Cntr-Enter (Windows/Linux).


# 1. create a new variable called 'my.num' that contains 6 numbers
my.num = c(5,4,7,8,12,14)

# 2. mulitply 'my.num' by 4
my.num * 4 

# 3. create a second variable called 'my.char' that contains 5 character strings
my.char = c("Andrew", "John", "John", "Andrew","John")


# 4. combine the two variables 'my.num' and 'my.char' into a variable called 'both'
both = c(my.num, my.char)

# 5. what is the length of 'both'?
length(both)

# 6. what class is 'both'?
class(both)

# 7. divide 'both' by 3, what happens?
# both / 3
# Error in both/3 : non-numeric argument to binary operator

# 8. create a vector with elements 1 2 3 4 5 6 and call it x
x = c(1,2,3,4,5,6)

# 9. create another vector with elements 10 20 30 40 50 and call it y
y =  c(10,20,30,40,50)

# 10. what happens if you try to add x and y together? why?
x + y

# 11. append the value 60 onto the vector y (hint: you can use the c() function)
y = c(y, 60)

# 12. add x and y together
x + y

# 13. multiply x and y together. pay attention to how R performs operations on vectors of the same length.
x * y

