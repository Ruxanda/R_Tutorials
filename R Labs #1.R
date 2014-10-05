##################################################################
##################################################################
### R Tutorials
### Lab #1
##################################################################
##################################################################

rm(list=ls())

1 + 1
2 * 2
1 + 2 + 3
4 / 2
4 / 3

# PEMDAS
4 * 6 + 5
(4 * 6) + 5
4 * (6 + 5)
2^3

# VARIABLES
x <- 2
x
y = 5
y
3 -> z
z
a <- b <- 7
a
b
a <- 3 -> b
a
b
assign("j", 4)
j

# removes variables
rm(j)
rm(a, b)

theVariable <- 17
thevariable # error did not CAP VARIABLE

x <- 2
class(x) # numeric
is.numeric(x)

i <- 5L
class(i) # integer
is.integer(i) # TRUE
is.numeric(i) # TRUE

x <- "data"
x
class(x) # character
nchar(x) # number of charcters
nchar("Hello")
nchar(432)

date1 <- as.Date("2013-09-10")
date1
as.numeric(date1) # number of days since Jan 1, 1970
date2 <- as.POSIXct("2013-09-10 20:14:37")
date2
as.numeric(date2) # number of secounds since Jan 1, 1970
date3 <- as.POSIXlt("2013-09-10 20:14:37")
date3
attributes(date3)

# lubridate - package for dates

# logical var TRUE FALSE
k <- TRUE
k
T
T <- 7
T

TRUE * 5
FALSE * 5

2 == 3 # chech if they are equal
2 < 3
2 <= 3
2 != 3 # chech if they are NOT equal

"data" == "stats"
"data" < "stats" # d is before s

x <- c(1,2,3,4,5,6,7,8,9,10)
x
length(x)
# add 2 to each number of x
x + 2
x * 3
x^2
sqrt(x)

1:10
10:1

x <- 1:10
y <- -5:4
x + y
x^y
x/y # something divided by zero equals infinity

x + c(1,2)
x + c(1,2,3) 
x < 5
x < y
any(x<y)
x < c(1, 2)

?mean
apropos("mea")

q <- c("Hockey", "Basketball", "Ultimate Frisbee", 'Tennis', 'Soccer', "Curling", "Snooker", "Field Hockey", "Cricket")
q
nchar(q)
q2 <- c(q, "Hockey", "Soccer", "Hockey")
q2
q2F <- as.factor(q2)
levels(q2F)
as.numeric(q2F)

x
x[1]
x[-1] # remove the first number
x[-2] # remove the second number
x[c(1,2)]
x[c(1,3,1)] # show the first, third, first numbers

r <- c(One="a", Two="b", Three="c")
r
r["Two"]
w <- 1:3
w
names(w) <- c("a", "b", "c")
w

x
mean(x)
sum(x) / length(x)

seq(from=1, to=10, by=2)
seq(1, 10, by=2)

z <- c(1, 2, NA, 8, 3, NA, 3)
z
mean(z) # cannot take the mean of a vector with NA
is.na(z)
mean(z, na.rm=TRUE)
mean(z[-c(3,6)])
z2 <- z
z2[c(3,6)] <- 0
z2
mean(z2)
y <- c(1, NULL, 3)
y
d <- NULL
is.null(d)


