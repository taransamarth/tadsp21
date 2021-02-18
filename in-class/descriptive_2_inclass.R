# Descriptive practice


#1. Write two sentences. Save each as a seperate object in R. 

require(quanteda)

s1 <- "This is a sample sentence on which text analysis can be conducted."

s2 <- "Sample sentences for text analysis can include many words, but some may be removed after preprocessing."

#2. Combine them into a corpus

corp1 <- corpus(c(s1,s2))

#3. Make this corpus into a dfm with all pre-processing options at their defaults.

dfm1 <- dfm(corp1)

#4. Now save a second dfm, this time with stopwords removed.

dfm2 <- dfm(corp1, remove=stopwords())

#5. Calculate the TTR for each of these dfms (use textstat_lexdiv). Which is higher?

ttr1 <- textstat_lexdiv(dfm1,measure="TTR")

ttr2 <- textstat_lexdiv(dfm2,measure="TTR")

#6. Calculate the Manhattan distance between the two sentences you've constructed (by hand!)

man_dist <- sum(abs(convert(dfm1,"matrix")[1,]-convert(dfm1,"matrix")[2,]))