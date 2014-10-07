##################################################################
##################################################################
### R Tutorials
### Lab #3
##################################################################
##################################################################

aaa <- readHTMLTable(doc="http://www.nuforc.org/webreports/ndxsCircle.html", stringsAsFactors = FALSE)
head(aaa, 5)
aaa2 <- as.data.frame(aaa)

ufo$DateTime <- as.Date(ufo$Date, format="%m/%d%y")
# chron package <1970 is read as 2012

# take year out of a function
require(lubridate)
ufo$Year <- year(ufo$Date)

# how many ufo sighting are in each year
aggregate(formula=Date~Year, FUN=lenght, data=ufo)

# how to get it into a database
write.table(x=ufo, file="ufo.csv", sep=",", row.names=FALSE)

##############################################################
require(stringr)
require(XML)

presidents2 <- readHTMLTable("http://www.loc.gov/rr/print/list/057_chron.html",
                            which=3, as.data.frame=TRUE, skip.rows=1,
                            header=TRUE, stringsAsFactors=FALSE)
head(presidents2)
setwd("~/Desktop")
load("presidents.rdata")
head(presidents)
dim(presidents)
presidents <- presidents[1:64, ]
presidents$YEAR

# split column up
yearList <- str_split(string=presidents$YEAR, pattern="-")
yearList

yearMatrix <- data.frame(Reduce(rbind, yearList))
head(yearMatrix, 100)

# first 3 characters of the first presidents name
str_sub(string=presidents$PRESIDENT, start=1, end=3)
# 4 to 8 characters of the first presidents name
str_sub(string=presidents$PRESIDENT, start=4, end=8)

# names with JOHN in them
str_detect(string=presidents$PRESIDENT, pattern="John")
johnpos <- str_detect(string=presidents$PRESIDENT, pattern="John")
presidents$PRESIDENT[johnpos]
str_detect(string=presidents$PRESIDENT, pattern=ignore.case("John"))
str_extract(string=presidents$PRESIDENT, pattern="(J|j)ohn")

# load data
load("warTimes.rdata")
head(warTimes)

theTimes <- str_split(string=warTimes, pattern="(ACAEA)|-", n=2) # n=2 only two year
theTimes
which(str_detect(string=warTimes, pattern="-"))
warTimes[which(str_detect(string=warTimes, pattern="-"))]

theStart <- sapply(X=theTimes, FUN=function(x) x[1])
theStart

str_extract(string=theStart, pattern="January")
theStart[str_detect(string=theStart, pattern="January")]

str_extract(string=theStart, pattern="[0-9][0-9][0-9][0-9]")
str_extract(string=theStart, pattern="[0-9]{4}") # 4 digits
str_extract(string=theStart, pattern="\\d{4}")
str_extract(string=theStart, pattern="[0-9]{1,3}") # one, two or three digits

str_extract(string=theStart, pattern="^\\d{4}") # 4 digits at the begining
str_extract(string=theStart, pattern="^\\d{4}$") # start at the begining, has 4 digits, and ends after 4 digits

str_extract(string=theStart, pattern="^\\d{4}.*?\\d{4}$")
# start ... 4 digits ... "." forany character ... * unlimited times ... ? don't be greedy ...  4 digits ... end

str_replace(string=theStart, pattern="\\d", replacement="x")
str_replace_all(string=theStart, pattern="\\d", replacement="x") # replaces all within a single string

str_replace(string=theStart, pattern="\\d{4}", replacement="x")
str_replace_all(string=theStart, pattern="\\d{1,4}", replacement="x")

commands <- c("<a href = index.html>The link is here</a>",
              "<b>This is bold text</b>")
commands
str_replace(string = commands, pattern = "<.+?>(.+?)<.+?>", replacement = "\\1")
