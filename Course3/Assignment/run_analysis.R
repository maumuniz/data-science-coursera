#load necessary libraries
library(dplyr)
library(data.table)

#define a function called path to save us from typing the folder name each time
path <- function (x) {
    paste("UCI HAR Dataset/", x, sep = "")
}

#get a list in the folder/subfolders with the .txt files
#containing "train" or "test" in its names and then get
#the file name
listFiles <- list.files(pattern = "_(train|test).txt$", recursive = TRUE)

listFiles <- strsplit(listFiles,"/") %>%
    sapply(function(x){x[2]}) %>%
    split(listFiles,.)

#create the unified folder
if(!file.exists("UCI HAR Dataset/unified/Inertial Signals")){
    dir.create("UCI HAR Dataset/unified/Inertial Signals", recursive = TRUE)
}

#combine the files in the train and test folders into
#new files to be stored in the unified folder
for(i in seq(along.with=listFiles$test)){
    if(!file.exists(gsub("test","unified",listFiles$test[i]))){
        x<-read.table(listFiles$test[i]) %>%
            rbind(read.table(listFiles$train[i]))

        write.table(x,gsub("test","unified",listFiles$test[i]))
    }
}

#data table containing the 561 measurement names
featuresTbl <- path("features.txt") %>%
    read.table(sep=" ",fill = TRUE,col.names = c("idfeature","namefeature")) %>%
    data.table()

#rename the columns after the featuresTbl and extract
#mean and std values
aux <- read.table(path("unified/X_unified.txt"))
setnames(aux,as.character(featuresTbl$namefeature))
aux <- aux[,grep("mean\\(|std",names(aux))]

#read activity list and the labels to create a factor
#vector to add to the dataset
activity <- read.table(path("unified/y_unified.txt"))
activitylabel <- read.table(path("activity_labels.txt"))
activity <- factor(activity$V1,levels = activitylabel$V1,labels = activitylabel$V2)

#add both the activity factors and subject ids into
#a fulldataset variable and save it to a txt file
subjects <- read.table(path("unified/subject_unified.txt"), col.names = "subject_id")

fulldataset <- data.table(cbind(subjects,activity,aux))

if(!file.exists("fulltidydataset.txt")){
    write.table(fulldataset,"fulltidydataset.txt", row.names = FALSE)
}

#apply the mean and group to create the last file to
#be saved as groupeddataset.txt
groupeddataset <- fulldataset[,lapply(.SD, mean),by=list(activity,subject_id)]

if(!file.exists("groupeddataset.txt")){
    write.table(groupeddataset,"groupeddataset.txt", row.names = FALSE)
}