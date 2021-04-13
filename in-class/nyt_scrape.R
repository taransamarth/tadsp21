
library(jsonlite)
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)
library(tidyverse)

##code adapted from Heather Geiger


NYTIMES_KEY <- ("871ZVCvB5LCfZAV00HPYGsRIfFIrEgEO")

term <- "facebook"
begin_date <- "20200101"
end_date <- "20200401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

initialQuery <- fromJSON(baseurl)

pages_2020 <- vector("list",length=5)

for(i in 0:4){
  nytSearch <- fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% data.frame() 
  pages_2020[[i+1]] <- nytSearch 
  Sys.sleep(10) #I was getting errors more often when I waited only 1 second between calls. 5 seconds seems to work better.
}
facebook_2020_articles <- rbind_pages(pages_2020)



term <- "facebook"
begin_date <- "20210101"
end_date <- "20210401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

initialQuery <- fromJSON(baseurl)

pages_2021 <- vector("list",length=5)

for(i in 0:5){
  nytSearch <- fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% data.frame()
  pages_2021[[i+1]] <- nytSearch
  Sys.sleep(10)
}
facebook_2021_articles <- rbind_pages(pages_2021)





#####in-class practice: 


### save the results of two different queries from the date range jan 1 2021 - APril 1 2021

term <- "supreme court"
begin_date <- "20210101"
end_date <- "20210401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

initialQuery <- fromJSON(baseurl)

scotus <- vector("list",length=5)

for(i in 0:5){
  nytSearch <- fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% data.frame()
  scotus[[i+1]] <- nytSearch
  Sys.sleep(5)
}

scotus <- rbind_pages(scotus)


term <- "president"
begin_date <- "20210101"
end_date <- "20210401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

initialQuery <- fromJSON(baseurl)

president <- vector("list",length=5)

for(i in 0:5){
  nytSearch <- fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% data.frame()
  president[[i+1]] <- nytSearch
  Sys.sleep(5)
}

president <- rbind_pages(president)

### calculate the proportion of the headlines from each search term assigned to a given section name

summary(as.factor(president$response.docs.section_name))/nrow(president)

summary(as.factor(scotus$response.docs.section_name))/nrow(scotus)

## create a combined dfm with the text of all of the lead paragraphs

df <- rbind(subset(president,select=c("response.docs._id", "response.docs.lead_paragraph")) %>% mutate(c = "president"), subset(scotus, select=c("response.docs._id", "response.docs.lead_paragraph")) %>% mutate(c="scotus"))

corp <- corpus(df, text_field = "response.docs.lead_paragraph")

dfm <- dfm(corp, remove_numbers = T, remove=stopwords("en"), remove_punct=T, remove_symbols = T)

## calculate the average Flesch Reading Ease score (hint: use code form descriptive_2.R) for the lead paragraphs from each search term. Which is higher?

df <- cbind(df,textstat_readability(corp)$Flesch) %>% rename("Flesch" = "textstat_readability(corp)$Flesch")

df %>% group_by(c) %>% summarise(avg = mean(Flesch))

## Mean for president is 46.2, mean for supreme court is 35
