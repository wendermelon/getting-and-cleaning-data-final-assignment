#Getting and Cleaning Data - Final Assignment

#The purpose of this project is to demonstrate your ability to collect, work with, 
#and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
#You will be graded by your peers on a series of yes/no questions related to the project. 
#You will be required to submit: 
#1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables, the data, and any transformations or 
# work that you performed to clean up the data called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.

#You should create one R script called run_analysis.R that does the following:

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average 
#     of each variable for each activity and each subject.

#Step 1 - Download zipped data set
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "final_assign_data.zip", method = "curl")

#Step 2 - Unzip files and list them
unzip("final_assign_data.zip")
list.files()

#Step 3 - Read through documentation and look at files
# - README.txt
# - features_info.txt
# - features.txt
# - activity_labels.txt

#Step 4 - Read in column names for the data sets X_train.txt and X_test.txt
labels <- read.delim("UCI HAR Dataset/features.txt", header=FALSE, sep=" ",col.names=c("colnum","colname"))

#Step 5 - Look for column names that are just mean or std
colsubset <- grep("mean|std",labels$colname)

colnm <- grep("mean|std",labels$colname, value=TRUE)

#Step 6 - Read in data set X_train.txt
#         Select columns from step 5
#         Name columns with those labels
train <- fread("UCI HAR Dataset/train/X_train.txt", select = colsubset, col.names = colnm)

#Step 7 - Read in data set X_test.txt
#         Select columns from step 5
#         Name columns with those labels
test <- fread("UCI HAR Dataset/test/X_test.txt", select = colsubset, col.names = colnm)

#Step 8 - Read in labels for X_train.txt: y_train
trainlabels <- fread("UCI HAR Dataset/train/y_train.txt", select=c(1),col.names=c("Activity"))

#Step 9 - Read in labels for X_test.txt: y_test
testlabels <- fread("UCI HAR Dataset/test/y_test.txt", select=c(1),col.names=c("Activity"))

#Step 10 - Add Activity column to train
train2 <- cbind(train,Activity=trainlabels$Activity)

#Step 11 - Add Activity column to test
test2 <- cbind(test,Activity=testlabels$Activity)

#Step 12 - Read in subject id's for training data
trainid <- fread("UCI HAR Dataset/train/subject_train.txt", select=c(1),col.names=c("Subject ID"))

#Step 13 - Read in subject id's for testing data
testid <- fread("UCI HAR Dataset/test/subject_test.txt", select=c(1),col.names=c("Subject ID"))

#Step 12 - Add column called "Group" to train and label with "train"
train_final <- cbind(train2,trainid,Group="train")

#Step 13 - Add column called "Group" to test and label with "test"
test_final <- cbind(test2,testid,Group="test")

#Step 14 - Concatenate train_final and test_final
alldat <- rbind(train_final,test_final)

#Step 15 - Read in activity_labels.txt
activitylabels <- fread("UCI HAR Dataset/activity_labels.txt", select=c(1,2),col.names=c("Activity","Activity Description"))

#Step 16 - Add Activity Description column to alldat by joining on Activity
alldat2 <- merge(alldat,activitylabels,by.x="Activity",by.y="Activity",all=FALSE)

#Step 17 - Get the average of each variable for each activity and each subject
library(reshape2)
library(dplyr)

#Step 18 - Get just the relevant columns for summary
allcol <- names(alldat2)
allcol2 <- allcol[-c(1, 81,82,83)]

#Step 19 - Melt the dataset by the variables we want to group by: Subject ID and Activity Description
alldatMelt <- melt(alldat2,id=c("Subject ID","Activity Description"),measure.vars=allcol2)

#Step 20 - Change Subject ID to a factor variable
alldatMelt$"Subject ID" <- as.factor(alldatMelt$"Subject ID")

#Step 21 - Create final tidy dataset by getting the average values by Subject ID and Activity Description
tidy_dataset <- aggregate(alldatMelt$value, list(alldatMelt$"Subject ID", alldatMelt$"Activity Description"), mean)

#Step 22 - Rename columns to be more descriptive
names(tidy_dataset) <- c("Subject","Activity","Mean")

#Step 23 - Write table out
write.table(tidy_dataset, "tidy.txt", row.names = FALSE, quote = FALSE)


