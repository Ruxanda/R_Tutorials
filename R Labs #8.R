##################################################################
##################################################################
### R Tutorials
### Lab #8
##################################################################
##################################################################

for(i in 1:10)
{
  print(sprintf("This is number %s.", i)) ### sequence of numbers
}

### API
# package in R: httr
# Curl - download packages, API's
# developers.nytimes.com - to register for the key
# developers.nytimes.com/docs/read/article_search_api_v2

# http://api.nytimes.com/svc/search/v2/articlesearch
http://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=...&fq=news_desk:("Sports")&fl=web_url,news_desk,lead_paragraph,word_count,headline$begin_date=20130601&end_date=20131112
# ? means we ask for something
# & asks for something
# fq - field query
# fl - give only these things, not everything

require(rjson)
theQuery <- "http://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fe6fae1bdc7ec79ac4c32f97bf49f03c:13:68404381&fq=news_desk:(\"Sports\")&fl=web_url,news_desk,lead_paragraph,word_count,headline&begin_date=20130601&end_date=20131112"
theQuery
theResults <- fromJSON(file=theQuery)
View(theResults)
str(theResults)
View(theResults$response)
theResults$response$meta
theResults$response$docs
str(theResults$response$docs)
theResults$response$docs[[1]]

require(plyr)
resultsDF <- ldply(theResults$response$docs, as.data.frame)
View(resultsDF)

theQuery <- "http://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fe6fae1bdc7ec79ac4c32f97bf49f03c:13:68404381&fq=news_desk:(\"Sports\")&fl=web_url,news_desk,lead_paragraph,word_count,headline&begin_date=20130601&end_date=20131112&page=1"
theQuery
# the first one is page 0, the second is page 1

resultsSports <- vector("list", 3)
resultsSports

baseQuery <- "http://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fe6fae1bdc7ec79ac4c32f97bf49f03c:13:68404381&fq=news_desk:(\"Sports\")&fl=web_url,news_desk,lead_paragraph,word_count,headline&begin_date=20130601&end_date=20131112&page=%s"

for(i in 0:2)
{
  tempURL <- sprintf(baseQuery, i)
  tempResult <- fromJSON(file=tempURL)
  resultsSports[[i+1]] <- ldply(tempResult$response$docs, as.data.frame)
}

str(resultsSports)
length(resultsSports)
resultsSports[[1]]
resultsSportsAll <- ldply(resultsSports)
View(resultsSportsAll)

### double loop
theString <- "Hello %s, what are you doing for %s?"
sprintf(theString, "Bob", "dinner")

### build function

get.api <- function(section, lastPage=0)
{
  baseQuery <- "http://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=fe6fae1bdc7ec79ac4c32f97bf49f03c:13:68404381&fq=news_desk:(\"%s\")&fl=web_url,news_desk,lead_paragraph,word_count,headline&begin_date=20130601&end_date=20131112&page=%s"
  results <- vector("list", lastPage+1)
  for(i in 0:lastPage)
  {
    tempURL <- sprintf(baseQuery, section, i)
    tempResult <- fromJSON(file=tempURL)
    results[[i+1]] <- ldply(tempResult$response$docs, as.data.frame)
  }
  return(ldply(results))
}

resultsArts <- get.api(section="Arts", lastPage=2)
dim(resultsArts)
names(resultsArts)

resultsSports <- get.api(section="Sports", lastPage=2)
dim(resultsSports)
names(resultsSports)

resultsSports$headline.main <- NULL
resultsSports$headline.kicker <- NULL
resultsSports$headline.print_headline <- NULL

resultsAll <- rbind(resultsSports, resultsArts)
dim(resultsAll)

### Naive Bayes
require(RTextTools)
doc_matrix <- create_matrix(resultsAll$lead_paragraph, language="english", removeNumbers=TRUE, removeStopwords=TRUE, stemWords=TRUE)
doc_matrix
require(useful)
topright(as.matrix(doc_matrix))
View(topright(as.matrix(doc_matrix)))
View(as.matrix(doc_matrix))

textX <- as.matrix(doc_matrix)
nb1 <- naiveBayes(x=textX, y=resultsAll$news_desk)
head(nb1$tables)
class(nb1)
?e1071:::predict.naiveBayes
predict(nb1, as.data.frame(resultsAll))

### MapReduce - Reduce package in R
