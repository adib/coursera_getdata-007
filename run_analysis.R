#!/usr/bin/env R

#' Cleans up "Human Activity Recognition Using Smartphone" dataset.
#' Merges the training and test data in the aforementioned data set
#' to extract its mean and standard deviation.
#' 
#' This code is under the simplified BSD license; please refer to LICENSE.txt for details.

#--- Configurations

#' Root folder of the input data relative to the current working directory. 
inputFolder <- "data-raw/UCI HAR Dataset"

#' Root folder of the output data relative to the current working directory
outputFolder <- "data-tidy"

#' File name of the resulting tidy data set.
tidyValuesFilename <- "average-values.txt"

#' The length (in bytes) of each numeric field in the fixed-width input data.
numberWidth <- 16

#---

library(assertthat)
library(data.table)
library(LaF)
library(dplyr)

is.dir(inputFolder)
is.readable(inputFolder)

if (!file.exists(outputFolder)) {
    dir.create(outputFolder)
}

activityLabels <- fread(paste(inputFolder,"activity_labels.txt",sep=.Platform$file.sep))
setnames(activityLabels,c("activity_id","activity_label"))

features <- fread(paste(inputFolder,"features.txt",sep=.Platform$file.sep),header=FALSE)
featureCount <- nrow(features)
selectedColumns <- features[grep(".*(mean|std).*",V2)]


readDataset <- function(folder,labelFilename,signalFilename,subjectFilename) {
    subjectFrame <- fread(paste(inputFolder,folder,subjectFilename,sep=.Platform$file.sep),header=FALSE)
    labelFrame <- fread(paste(inputFolder,folder,labelFilename,sep=.Platform$file.sep),header=FALSE)
    signalFrame <- laf_open_fwf(paste(inputFolder,folder,signalFilename,sep=.Platform$file.sep),column_widths=rep(numberWidth,featureCount),column_types=rep("double",featureCount))
    
    selectedSignalFrame <- signalFrame[,selectedColumns$V1]
    names(selectedSignalFrame) <- selectedColumns$V2
    
    setnames(labelFrame,"activity_id")
    labelFrame <- left_join(labelFrame,activityLabels,by="activity_id")
    
    cbind(subject_id=subjectFrame$V1,activity_label=labelFrame$activity_label,selectedSignalFrame)
}


combineDatasets <- function() {
    trainDataset <- readDataset("train","y_train.txt","X_train.txt","subject_train.txt")
    testDataset <- readDataset("test","y_test.txt","X_test.txt","subject_test.txt")
    rbind(trainDataset,testDataset)
}


summarizedDataset <-   combineDatasets() %>% 
                        group_by(subject_id,activity_label) %>%
                        summarise_each_q(funs(mean),selectedColumns$V2)
summarizedNames <- c("subject_id","activity_label",paste("mean:",selectedColumns$V2))
setnames(summarizedDataset,summarizedNames)
write.table(summarizedDataset,file=paste(outputFolder,tidyValuesFilename,sep=.Platform$file.sep),row.names=FALSE,sep="\t")
