##################################################################
##################################################################
### R Tutorials
### Lab #4
##################################################################
##################################################################

rm(list=ls())

# igraph - package for graphs

require(ggplot2)
data(diamonds)
head(diamonds)

# Histogram
ggplot(diamonds, aes(x=price)) + geom_histogram()

# Density plot
ggplot(diamonds, aes(x=price)) + geom_density()
# change color of line
ggplot(diamonds, aes(x=price)) + geom_density(color="grey")
# change color of line and fill color
ggplot(diamonds, aes(x=price)) + geom_density(color="grey", fill="grey")

# Scatter Plot
ggplot(diamonds, aes(x=carat, y=price)) + geom_point()
# alternative
g <- ggplot(diamonds, aes(x=carat, y=price))
g + geom_point()
# color code by CUT
g + geom_point(aes(color=cut))

# Small multiples (break it up in small graphs by clarity)
g + geom_point(aes(color=cut)) + facet_wrap(~clarity)
# Here we change it to as a grid
g + geom_point(aes(color=cut)) + facet_grid(color~clarity)

require(ggthemes) # cool package
g2 <- g + geom_point(aes(color=cut))
g2
g2 + theme_economist() + scale_color_economist() 
g2 + theme_wsj()
g2 + theme_excel()
g2 + theme_tufte()

head(economics)
# plot PCE by DATE
ggplot(economics, aes(x=date, y=pce)) + geom_line()
require(lubridate)
economics$Year <- year(economics$date)
economics$Month <- month(economics$date)
econ2000 <- economics[economics$Year >= 2000,]
ggplot(econ2000, aes(x=Month, y=pce, color=Year)) + geom_line(aes(group=Year))
ggplot(econ2000, aes(x=Month, y=pce, color=factor(Year))) + geom_line()

# Linear Models - one predictor var
require(UsingR)
head(father.son)
ggplot(father.son, aes(x=fheight, y=sheight)) + geom_point()
# Add line for linear model
ggplot(father.son, aes(x=fheight, y=sheight)) + geom_point() + geom_smooth(method="lm")
# Regression (response ~ predictors)
MYlm <- lm(sheight ~ fheight, data=father.son)
MYlm
summary(MYlm)

# Look at the chapter about Markdown
require(xtable) # give you the code for Laitex
xtable(summary(MYlm))

# Linear Models - more predictor vars
data("tips", package="reshape2")
head(tips)
ggplot(tips, aes(x=total_bill, y=tip, color=day, shape=sex)) + geom_point()
mod1 <- lm(tip ~ total_bill + sex + day, data=tips)
summary(mod1)

head(model.matrix(tip ~ total_bill + sex + day, data=tips))
# cut() to bin a continuous variable

require(coefplot)
coefplot(mod1)
head(tips)
mod2 <- lm(tip ~ total_bill + time + size, data=tips)
mod3 <- lm(tip ~ total_bill + day + size + time, data=tips)
coefplot(mod2, outerLWD=2)
coefplot(mod3)
multiplot(mod1, mod2, mod3) # 3 models in one plot

# Cross validation
require(boot)
# dataset with p columns and k rows
# split data in 5 : use 4 to predict 1, repeat until you can predict each of the 5
# 5 fold is the best number
# cv.glm() works for glm models
# set.seed() in order to get the same results
tip1 <- glm(tip ~ total_bill + sex + day, data=tips, family=gaussian(link="identity"))
summary(tip1)
tipCv1 <- cv.glm(data=tips, glmfit=tip1, K=5)
tipCv1$delta

tip2 <- glm(tip ~ total_bill + sex + day + time + size, data=tips, family=gaussian(link="identity"))
tipCv2 <- cv.glm(data=tips, glmfit=tip2, K=5)
tipCv2$delta
