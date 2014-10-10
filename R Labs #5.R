##################################################################
##################################################################
### R Tutorials
### Lab #5
##################################################################
##################################################################

rm(list=ls())
setwd("~/Desktop")

# Adjency matrix
    # directed graph - one was street
    # undirected graph - two way street EG adjency matrix

# 1. build a function that samples 3,000 random rows
# 2. average degree - build function that calculates agerage degree 
    # sum by row / n
# 3. build function that calls those functions (1 and 2)
# 4. call function 3 10,000 times
    # replicate - rep()
    # for loop
    # aaply
    # foreach

# true false if the row is in there and use this to calculate the row sums 

### K-means
# use set.seed to make sure you replicate
wine <- read.table("wine.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)
require(useful)
corner(wine)
head(wine)

set.seed(278613) # in order to replicate results

wineK3 <- kmeans(x=wine, centers=3, nstart=5) # nstart will do the whole five times and averege the results

wineK3 <- kmeans(x=wine, centers=3)
wineK3$cluster # each row is in each cluster
wineK3$centers # centers for each cluster
wineK3$totss # points within a cluster should be more similar than points ouside cluster
    # total sum of squares
wineK3$size # how many points are in each cluster

# How do you know how many clusters are appropriate
    # Hardigans rule - measure between sum of squares and within sum of squares
wineBest <- FitKMeans(x=wine, max.clusters=20, seed=278613)
head(wineBest)
wineBest
wineK3$tot.withinss # look up hardigans rule to compute the formula
PlotHartigan(wineBest)
    # Gap Statistics - bootstrap best way to do things
require(cluster)
theGap <- clusGap(x=wine, K.max=20, FUNcluster=pam) 
# clusGap() - calculate with bootstrap to see which is the best number of clusters
plot(theGap) # look at the plot at 5 cluster they are the closest at the ideal
            # this is the green line - the blue line

# this ratio is - blue line
wineK3$betweenss / wineK3$withinss
# calculate expected/ideal throught the bootstrap - green line

### K-medoinds - is the meadian, an actual point
x <- c(1,4,5)
mean(x)
median(x)
# partition around medoids
winePAM <- pam(x=wine, k=5)
plot(winePAM)

# daisy() calculate different distance matrices in order to deal with categorical data

require(parallel)
require(doParellel)
cl <- makeCluster(2) # make cluster
registerDoParallel(cl) # register cluster

answer <- foreach(i=1:100, .combine="c") %dopar% # .combine = "c" create a vector with the results
                                                 # %dopar% does it in parallel
{
  i*2
}
answer

stopCluster(cl)
