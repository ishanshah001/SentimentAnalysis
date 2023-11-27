## download the package to this machine ##
#install.packages("RedditExtractoR")

## use the library to access reddit API ##
library(RedditExtractoR)

## download all the URLs from reddit that match a keyword
urls <- find_thread_urls(keywords="spiderman")

## take a subset of the URL data that is from the playstation subreddit only ##
spoturls <- subset(urls, subreddit=="playstation")

## get the content from ALL of the urls above ##
onethread <- get_thread_content(spoturls$url)

### make a dataframe of all the comments and write it out to a csv file ###
commentsdf <- onethread$comments
write.csv(commentsdf,"ps5_comments.csv")