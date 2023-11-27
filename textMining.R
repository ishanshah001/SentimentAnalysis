#install.packages("tm")
library(tm)

#read into a DF with 
allcomments <- read.csv('withsentiment.csv')

# Data preprocessing
allcomments$comment <- gsub("[^[:alnum:]///' ]","", allcomments$comment)


#If we wish to combine all tweets into one big group then...
#  review_text <- paste(trumptweetsDF$text, collapse=" ")
#  review_source <-VectorSource(review_text)

#Otherwise...
#setup source and corpus

review_source <- VectorSource(allcomments$comment) 
corpus <- Corpus(review_source)

# Cleaning
getTransformations()

#Optional
#create the toSpace content transformer
##Now we can use  this content transformer to eliminate colons and hypens like so:
toSpace = content_transformer( function(x, pattern) gsub(pattern," ",x) )
corpus <- tm_map( corpus, toSpace, "(f|ht)tp(s?)(.*)[.][a-z]+")
corpus <-tm_map(corpus, removePunctuation)
                
corpus <-tm_map(corpus, content_transformer(tolower))
corpus <-tm_map(corpus, stripWhitespace)
corpus <-tm_map(corpus, removeWords, stopwords("english"))

#make a Document Term matrix
dtm <- DocumentTermMatrix(corpus)

inspect(removeSparseTerms(dtm,0.4))
dtm2 <- as.matrix(dtm)

#finding most frequent terms
frequency <- colSums(dtm2)
frequency <- sort(frequency, decreasing=TRUE)
frequency[1:20]

#atleast a frequency of 10
findFreqTerms(dtm,lowfreq = 10)
# word associated with given word
findAssocs(dtm,'spiderman',corlimit=.2)

##### make a wordcloud #####
#install.packages('wordcloud')
library(wordcloud)
words <- names(frequency)
#choose some colors for wordcloud http://www.datavis.ca/sasmac/brewerpal.html
wordcloud(words[1:50],frequency[1:50],colors=brewer.pal(8,"Dark2"))


