# install.packages("translateR")
# install.packages("textcat")
# install.packages("SnowballC")
# install.packages("tm")

# works with "Applied Survey.csv", not universal at the moment
getCorpus <- function(survey.csv) {
  library(translateR)
  library(textcat)
  library(tm)
  library(SnowballC)
  
  # Read in csv
  applied.survey <- read.csv(survey.csv, stringsAsFactors = F)
  
  # Retrieve only the English responses
  languages <- textcat(applied.survey$Applied.Survey)
  applied.survey.english <- applied.survey[languages == "english",]
  test.english <- data.frame(applied.survey.english)
  english.repsonses <- data.frame(test.english[3:12745,])
  colnames(english.repsonses) <- c("What can J&J do to improve the recruiting process?")
  
  # create corpus, docs correspond to one response
  corpus <- Corpus(VectorSource(english.repsonses$`What can J&J do to improve the recruiting process?`))
  
  # cleaning the corpus, other functions available
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, stemDocument)
  
  corpus
}

