#################################################################
# Author: Clark Wolley
# Date:   02/13/2017
# Details: HighLevel Expectations of program
#
# Download data
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each meausrement.
# 3. Use descriptive activity names to name the activities in the data set.
# 4. Appopriately label the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, independent tidy data set with the average
#     of each variable for each activity and each subject.
##################################################################

# load libraries necesssary for program execution
library(plyr)
library(reshape2)

# basic program processing
if (!file.exists("./data")) {
  dir.create("./data")
}

# download dataset
fileUrl <-
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  # curl must be used if using a Mac
  download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")

# unzip Dataset to /data directory
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

# load activity labels + features
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("./data/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# extract only the data on mean and standard deviation
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


# load the datasets
# training datasets
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

# test datasets
test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
combinedData <- rbind(train, test)
colnames(combinedData) <- c("subject", "activity", featuresWanted.names)

# turn activities & subjects into factors
combinedData$activity <- factor(combinedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
combinedData$subject <- as.factor(combinedData$subject)

combinedData.melted <- melt(combinedData, id = c("subject", "activity"))
combinedData.mean <- dcast(combinedData.melted, subject + activity ~ variable, mean)

# write tidy dataset out for consumption
write.table(combinedData.mean, "tidyDataset.txt", row.names = FALSE, quote = FALSE)