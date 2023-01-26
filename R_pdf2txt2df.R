
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

txts <- convertpdf2txt("C:\\Users\\flore\\OneDrive\\Bureau\\DUBLIN\\MSc\\Dissertation\\scraping speeches\\Speeches")

# Save the .txt + add names to txt files
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

