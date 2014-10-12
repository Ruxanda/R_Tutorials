##################################################################
##################################################################
### R Tutorials
### Lab #6
##################################################################
##################################################################

rm(list=ls())
setwd("~/Desktop")

### Decision Trees

load("credit.rdata")
head(credit)
ls()
View(credit)

require(rpart) # for partitioning of the space

creditTree <- rpart(Credit ~ CreditAmount + Age + CreditHistory + Employment, data=credit)
creditTree

require(rpart.plot) # for visualising trees

rpart.plot(creditTree, extra=4)

##################################################################################

### Random Forest

# Ansamble method - fitting the trees a bunch of different ways and combning them

require(randomForest)

creditFormula <- Credit ~ CreditHistory + Purpose + Employment + Duration + Age + CreditAmount
creditFormula

creditForest <- randomForest(creditFormula, data=credit) # does not work

require(useful)
require(devtools)
install_github("useful", "jaredlander")

# Build matrices for random forest
creditX <- build.x(formula=creditFormula, data=credit)
head(creditX)  
creditY <- build.y(formula=creditFormula, data=credit)
head(creditY)
  
# Random forest
creditForest <- randomForest(x=creditX, y=creditY)
creditForest

# Predict
predict(creditForest, newdata=creditNew)

##################################################################################

### Elastic Net

# Book: "Elements of statistical learning" Hastings, Freedman, Triptianny

require(glmnet)

acs <- read.table("acs_ny.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)
View(acs)

acs$Income <- with(acs, FamilyIncome >= 150000)
table(acs$Income)

acsFormula <- Income ~ NumBedrooms + NumChildren + NumPeople + NumRooms + NumUnits + NumVehicles + NumWorkers + OwnRent +
  YearBuilt + ElectricBill + FoodStamp + HeatingFuel + Insurance + Language - 1 # no intercept

acsX <- build.x(acsFormula, data=acs, contrasts=FALSE) 
head(build.x(acsFormula, data=acs))
unique(credit$CreditHistory)
head(build.x(acsFormula, data=acs, contrasts=FALSE))
# for a categorical variable with 4 categories there are only 3 dummies
# if we do contracts= FALSE will create 4 dummies
# because we are basiens we do not care and we want all 4

acsY <- build.y(acsFormula, data=acs)

acs1 <- cv.glmnet(x=acsX, y=acsY, family="binomial", nfold=5)
acs1$lambda.min # what minimazes
plot(acs1)
plot(acs1$glmnet.fit)

coef(acs1, s="lambda.min") 
# the variables with numbers get kepted in, and the variables with dots get thrown out for this lambda
# now we can take these var with betas and put them in a regular glm model in order to get confidence interval

coef(acs1, s="lambda.1se") 
# this is the parsemonious model, with one standard deviation from the lambda minimum
# we can take these variables and put them in a regular glm model now
# the parsemonious model (lambda.1se) have less variables than the lambda minimum model


