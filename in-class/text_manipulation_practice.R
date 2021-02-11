# Manipulating text in R

#1. Find a sentence online. Save it as a string. 

require(quanteda)
require(stringr)

s1 <- "The data focus on summarized aggregates of counts and characteristics associated with surnames, and the data do not in any way identify any specific individuals."

#2. Select only the third word of the sentence. Save it as a new string.

word1 <- str_split(s1, boundary("word"))[[1]][3]

#3. Choose a letter that appears in your sentence. Use the gsub command to replace all instances of that letter with a period. 

gsub('a', '.', s1)