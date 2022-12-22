# Florentin LAVAUD (florentin.lavo@gmail.com)
# MSc in Economics, Dissertation


##################################################################################################################
# let's outline how this code is organised: 

### 1/  Speeches 
#          - A function that extracts all pdf in a directory and converts them in text
#          - A program that stores all created text files into a directory
#          - Preprocessing & tokenization of all text
#          - Creation of a Document term matrix

### 2/ Tweets 
#          - A function that extracts all tweets
#          - Preprocessing & tokenization of all tweets
#          - Creation of a Document term matrix

  
### 3/ Cosine
#          - Merge of the two Document term matrix 
#          - Calculation of cosine similarity index


# Download and install packages 

### 1/  Speeches
install.packages(c("pdftools", "dplyr", "stringr", "httr", "jsonlite","magrittr","tokenizers","tidytext"
                   ,"tm","data.table"))
library(pdftools)
library(dplyr)
library(stringr)
library(httr)
library(jsonlite)
library(magrittr)
library(tokenizers)
library(tidytext)
library(tm)
library(data.table)

### 2/ Tweets

install.packages(c("academictwitteR","rtweet","tidyverse","tidytext","dplyr","stringr","SnowballC"
                   , "magrittr","tm","wordcloud","rtweet","tokenizers"))

library(academictwitteR)
library(rtweet)
library(tidyverse)
library(tidytext)
library(dplyr)
library(stringr)
library(SnowballC)
library(magrittr)
library(tm)
library(wordcloud)
library(rtweet)
library(tokenizers)

### 3/ Cosine 
install.packages("slam")
install.packages("tm")
library(slam)
library(tm)

##############################################################################################################

###################
## 1/ SPEECHES ## 
##################

# We download all pdf text and stored it in a file.
# First we have to create a convert function from pdf to text

convertpdf2txt <- function(dirpath){
  files <- list.files(dirpath, full.names = T)
  x <- sapply(files, function(x){
    x <- pdftools::pdf_text(x) %>%
      paste(sep = " ") %>%
      stringr::str_replace_all(fixed("\n"), " ") %>%
      stringr::str_replace_all(fixed("\r"), " ") %>%
      stringr::str_replace_all(fixed("\t"), " ") %>%
      stringr::str_replace_all(fixed("\""), " ") %>%
      paste(sep = " ", collapse = " ") %>%
      stringr::str_squish() %>%
      stringr::str_replace_all("- ", "") 
    return(x)
  })
}
# We apply the function and define a directory
txts <- convertpdf2txt("C:\\Users\\flore\\OneDrive\\Bureau\\DUBLIN\\MSc\\Dissertation\\scraping speeches\\Speeches")

# Save the .text + add names to txt files
names(txts) <- paste("text", 1:length(txts), sep = "")

# Save result i.e. all pdf in a text format
lapply(seq_along(txts), function(i)writeLines(text = unlist(txts[i]),
                                              con = paste("C:\\Users\\flore\\OneDrive\\Bureau\\DUBLIN\\MSc\\Dissertation\\scraping speeches\\text", names(txts)[i],".txt", sep = "")))


#list all the files in the folder
listfile <- list.files("C:\\Users\\flore\\OneDrive\\Bureau\\DUBLIN\\MSc\\Dissertation\\CODE CLEAN\\Speeches_ongoing",pattern = "txt",full.names = T, recursive = TRUE)

#extract the  files with folder name texttext
Text <- listfile[grep("texttext",listfile)]

#combined all the text files in listfile_text1 and store in 'Data'
for (i in 1:length(Text)){
  if(i==1){
    assign(paste0("Data"), read.table(listfile[i],header = FALSE, sep = ","))
  }
  
  if(!i==1){
    
    assign(paste0("Test",i), read.table(listfile[i],header = FALSE, sep = ","))
    Data <- rbind(Data,get(paste0("Test",i)))
    rm(list = ls(pattern = "Test"))
  }
}

rm(list = ls(pattern = "list.+?"))

# Let's download all text file
list_of_files <- list.files(path = "C:\\Users\\flore\\OneDrive\\Bureau\\DUBLIN\\MSc\\Dissertation\\CODE CLEAN\\Speeches_ongoing", recursive = TRUE,
                            pattern = "\\.txt$", 
                            full.names = TRUE)
#list_of_files # warning code not important
# Create a data frame based on several sources:
All_text <- rbindlist(sapply(list_of_files, fread, simplify = FALSE), fill=TRUE)
# Write data as character
df_aschar = as.character(All_text)
# Write now as a vector
corpus <- VCorpus(VectorSource(df_aschar))
# Clean up the corpus
corpus <- tm_map(corpus, removePunctuation)
# corpus <- tm_map(corpus, PlainTextDocument) => because https://stackoverflow.com/questions/47410866/r-inspect-document-term-matrix-results-in-error-repeated-indices-currently-not
corpus <- tm_map(corpus, removeWords)
corpus <- tm_map(corpus, stemDocument)
corpus1 <- tm_map(corpus, removeNumbers)

# Then create the term document matrix
tdm_speeches <- TermDocumentMatrix(corpus1)
dtm_speeches <- DocumentTermMatrix(corpus1)
str(inspect(dtm_speeches))


###################
## 2/ SCRAPING ## 
  ##################
  
  
  # Download tweets 
  oil_tweet <- get_all_tweets(
    query = "#OOTT",
    start_tweets = "2021-12-14T08:00:00Z", 
    end_tweets = "2021-12-14T10:00:00Z", 
    bearer_token = "AAAAAAAAAAAAAAAAAAAAAKzJcwEAAAAAd%2F%2BqOk%2B%2B0cLVb15r4P8kB65jb20%3DfcK6BFgk1nVhzvyvI2iZewOhweKhMmybSXp7sbXoJEyMGo3JKu",
    data_path = "C:\\Users\\flore\\OneDrive\\Bureau\\DUBLIN\\MSc\\Dissertation\\CODE CLEAN",
    lang = "en",
    n =1000000 ,
    page_n = 100
  )
  
  # it's only working after 01/2017 !
  #https://github.com/cjbarrie/academictwitteR/issues/192
  
  # First, we have to remove http elements
  oil_tweet$stripped_text <- gsub("http:","",oil_tweet$text)
  #oil_tweet$stripped_text <- iconv(oil_tweet$stripped_text, "ASCII", "UTF-8", sub="byte")
  #oil_tweet$stripped_text =str_replace_all(oil_tweet$stripped_text,"[^[:graph:]]", " ") 
  oil_tweet$stripped_text <- iconv(oil_tweet$stripped_text, 'UTF-8', 'ASCII') # https://stackoverflow.com/questions/9637278/r-tm-package-invalid-input-in-utf8towcs
  oil_tweet$stripped_text <- gsub("http:","",oil_tweet$stripped_text)
 
  
  # Then we can use tidytext package to convert text to lowercase, remove punctuation, and add an ID for each tweet 
  oil_tweets_clean <- oil_tweet %>%
    dplyr::select(stripped_text) %>%
    unnest_tokens(word, stripped_text)
  # Remove all stop words
  cleaned_tweet_words <- oil_tweets_clean %>%
    anti_join(stop_words)
  
  # Further cleaning
  corpus <- VCorpus(VectorSource(oil_tweets_clean))
  corpus <- tm_map(corpus, content_transformer(tolower))
  # corpus <- tm_map(corpus, PlainTextDocument)
# https://stackoverflow.com/questions/47410866/r-inspect-document-term-matrix-results-in-error-repeated-indices-currently-not
# PlantextDocument wasn't working so we substitute tolower to content_transformer(tolower) https://stackoverflow.com/questions/25638503/tm-loses-the-metadata-when-applying-tm-map/25639656#25639656
  
  corpus <- tm_map(corpus, removePunctuation)
  stopwords("english")[1:10] # check what we're removing 
  corpus <- tm_map(corpus, removeWords, c("#ENTER A WORD#", stopwords("english")))
  corpus2 <- tm_map(corpus, stemDocument)
  
  # Create a term document matrix:
  tdm_tweets <- TermDocumentMatrix(corpus2)
  dtm_tweets <- DocumentTermMatrix(corpus2)
  str(inspect(tdm_tweets))
  
  ###################
  ## 2/ COSINE ## 
  ##################
  
  dtmnew <- DocumentTermMatrix(c(corpus1, corpus2))
  inspect(dtmnew) 
  dim(tdm_speeches) # size of corpus speeches
  dim(tdm_tweets) # size of corpus tweets
  dim(dtmnew) # check the size to define index properly
  index <- sample(1:3188)
  dtmnew1 <- dtmnew[index, ]
  dtmnew2 <- dtmnew[-index, ]
  
  cosine_sim <- tcrossprod_simple_triplet_matrix(dtmnew1, dtmnew2)/sqrt(row_sums(dtmnew1^2) %*% t(row_sums(dtmnew2^2)))
  mean(cosine_sim)
  
  

  