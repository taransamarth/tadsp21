##### R Task

library(quanteda)

## Pick your favorite celebrity who has a Twitter account. 

# Jeremy Corbyn, @jeremycorbyn

## find the most recent tweet the celebrited liked

jc <- get_favorites("jeremycorbyn", n = 1)

print(jc$text)

##Download their 500 most recent tweets. 

jc <- get_timelines(c("jeremycorbyn"), n = 500)

#Calculate which one got the most ``likes"

jc_top <- jc[which.max(jc$favorite_count),]

print(jc_top$text)

### Create a DFM from the text of these tweets

jc_dfm <- dfm(corpus(jc), remove=stopwords("en"), remove_punct=T)
### After removing stopwords, what word did the celebrity tweet most often?

topfeatures(jc_dfm)

# must (followed by people, government, some emoji, time, support, pay, now, and, finally, workers)
