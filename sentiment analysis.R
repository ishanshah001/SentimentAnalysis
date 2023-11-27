install.packages("syuzhet")
library(syuzhet)

rawdata <- read.csv('ps5_comments.csv')
comments = rawdata[,c(10)]
sent_syu <- get_sentiment(comments,method="syuzhet")
sent_afinn <- get_sentiment(comments,method="afinn")
sent_bing <- get_sentiment(comments,method="bing")
sent_nrc <- get_sentiment(comments,method="nrc")


finaldata <- cbind(rawdata, sent_syu, sent_afinn, sent_bing, sent_nrc)

write.csv(finaldata,'withsentiment.csv')
