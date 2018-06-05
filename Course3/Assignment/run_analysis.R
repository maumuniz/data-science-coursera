library(dplyr)
library(data.table)

path <- function (x) {paste("UCI HAR Dataset/", x, sep = "")}

#featuresTbl <- readLines(path("features.txt")) %>%
#       gsub("-"," ",.) %>%
#       textConnection() %>%
#       read.table(fill=TRUE)

featuresTbl <- path("features.txt") %>%
        read.table(sep=" ",fill = TRUE)

listFiles <- list.files(pattern = "_(train|test).txt$", recursive = TRUE)

listFiles <- strsplit(listFiles,"/") %>%
    sapply(function(x){x[2]}) %>%
    split(listFiles,.)

assign()
gsub("test","unified",listFiles$test)


x<-read.table(listFiles$test[1])
fileConn<-file(gsub("test","unified",listFiles$test[1]))





