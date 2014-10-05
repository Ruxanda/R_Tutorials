##################################################################
##################################################################
### R Tutorials
### Lab #2
##################################################################
##################################################################

rm(list=ls())

### Matrix
theMatrix <- matrix(1:9, nrow=3)
theMatrix
mat2 <- matrix(c(1,4,2,5), nrow=2)
mat2
mat3 <- matrix(c(1,4,2,5), nrow=2, byrow=TRUE)
mat3

# Sum by column (margin=2)
apply(X=theMatrix, MARGIN=2, FUN=sum)
colSums(theMatrix)

# Sum by row (margin=1)
apply(X=theMatrix, MARGIN=1, FUN=sum)
rowSums(theMatrix)

# What if we have NA's in the matrix
theMatrix[2,1] <- NA
theMatrix
apply(X=theMatrix, MARGIN=1, FUN=sum) # on the row with NA our sum will return NA
apply(X=theMatrix, MARGIN=1, FUN=sum, na.rm=TRUE) # exclude NA's so we can calculate sum by row
rowSums(theMatrix) # same problem with NA's
rowSums(theMatrix, na.rm=TRUE) # remove NA's

# LIST with 4 vectors A B C D
theList <- list(A=matrix(1:9, 3), B=1:5, C=matrix(1:4,2), D=2)
theList

# lapply will sum all the elements inside each vector (A, B, C, D)
lapply(X=theList, FUN=sum)

# sapply will sum all the elements inside each vector (A, B, C, D) and return one vector
sapply(X=theList, FUN=sum)

# Create a Data Frame
theDF <- data.frame(A=1:10, B=10:1)
theDF
lapply(X=theDF, FUN=sum)
sapply(X=theDF, FUN=sum)

# Create two lists to check if thet are identical
firstList <- list(A=matrix(1:16, 4), B=matrix(1:16, 2), C=1:5)
firstList
secondList <- list(A=matrix(1:16, 4), B=matrix(1:16, 8), C=15:1)
secondList
mapply(FUN=identical, firstList, secondList) # result as a vector
mapply(FUN=identical, firstList, secondList, SIMPLIFY=FALSE) # result as a list

# How many characters in each name
theNames <- c("George", "John", "Thomas")
theNames
nchar(theNames)
lapply(theNames, nchar)
sapply(theNames, nchar)

dim(theMatrix) # number of rows and columns
nrow(theMatrix) # gives the number of rows
nrow(theNames) # NULL
NROW(theMatrix)
NROW(theNames)
NROW(1:5)

# Build Functions
simpleFunc <- function(x,y)
{
  NROW(x) + NROW(y)
}
# in R the return statement is optional
simpleFunc
mapply(FUN=simpleFunc, firstList, secondList)

library(ggplot2)
require(ggplot2) # invisibly return TRUE or FALSE

data(diamonds)
head(diamonds) # gives first 6 rows
head(x=diamonds, n=10) # gives first 10 rows

aggregate(formula = price ~ cut, data = diamonds, FUN = mean)
aggregate(formula = price ~ cut + color, data = diamonds, FUN = mean)

aggregate(formula = cbind(price, carat) ~ cut, data = diamonds, FUN = mean)
aggregate(formula = cbind(price, carat) ~ cut + color, data = diamonds, FUN = mean)

require(plyr)
head(baseball)
?baseball
baseball$sf[baseball$year < 1954] <- 0
baseball$hbp[is.na(baseball$hbp)] <- 0
baseball <- baseball[baseball$ab >= 50, ]

baseball$OBP <- with(data=baseball, expr=(h + bb + hbp) / (ab + bb + hbp + sf))
head(baseball)

obp <- function(data)
{
  OBD = with(data=data, expr = sum(h + bb + hbp) / sum(ab + bb + hbp + sf))
}

head(obp(baseball))

# ddply - first letter is the input (d=data frame)
#       - second letter is the output (d=data frame)
careerOBP <- ddply(.data=baseball, .variables="id", .fun=obp)
head(careerOBP)

# sort decreasing by V1
sortedOBP <- careerOBP[order(careerOBP$V1, decreasing=TRUE), ]
head(sortedOBP)

# join V1 to the original dataframe
baseball <- join(x=baseball, y=careerOBP[, c("id", "V1")], by="id")
head(baseball)

# llply will be in the notes
#       - first letter is the input (l=list)
#       - second letter is the output (l=list)
# WIDE FORMAT - lots of rows
# LONG FORMAT - few rows that are very long
llply(.data=theList, .fun=sum)
laply(.data=theList, .fun=sum)
sapply(X=theList, FUN=sum)
theMatrix <- matrix(1:9, nrow=3)
solve(theMatrix) # homework

# print statements
paste("theMatrix:", "3", sep = "")
sprintf("theMatrix: %s", 3)

require(reshape2)
head(airquality)

# wide to long (melting)
airMelt <- melt(data=airquality, id.vars=c("Month", "Day"), value.name="Value", variable.name="Metric")
head(airMelt)
tail(airMelt)

# long to wide (decast)
airCast <- dcast(data=airMelt, formula = Month + Day ~ Metric, value.var="Value")
head(airCast)

### look inside function
reshape2:::melt.data.frame

