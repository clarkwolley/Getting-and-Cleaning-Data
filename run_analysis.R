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

# basic program processing
if (!file.exists("./data")) {
  dir.create("./data")
}

# download dataset
fileUrl <-
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  # curl most be used if using a Mac
  download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")

# Unzip Dataset to /data directory
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")


# Merging the training and the test sets to create one data set:
# read in training tables
xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjectTrain <-
  read.table("./data/UCI HAR Dataset/train/subject_train.txt")


# read in testing tables
xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjectTest <-
  read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# reading features data
features <- read.table('./data/UCI HAR Dataset/features.txt')

# reading activity labels
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# assigning column names
colnames(xTrain) <- features[, 2]
colnames(yTrain) <- "activityId"
colnames(subjectTrain) <- "subjectId"
colnames(xTest) <- features[, 2]
colnames(yTest) <- "activityId"
colnames(subjectTest) <- "subjectId"
colnames(activityLabels) <- c('activityId', 'activityType')

# merging all data in one set
mrgTrain <- cbind(yTrain, subjectTrain, xTrain)
mrgTest <- cbind(yTest, subjectTest, xTest)
combinedSet <- rbind(mrgTrain, mrgTest)

# extracting only the measurements on the mean and standard deviation for each measurement
colNames <- colnames(combinedSet)

# vector for defining ID, mean and standard deviation
mean_and_std <- (
  grepl("activityId" , colNames) |
  grepl("subjectId" , colNames) |    
  grepl("mean.." , colNames) |
  grepl("std.." , colNames)
)

# make nessesary subset from combinedSet
meanAndStdSet <- combinedSet[, mean_and_std == TRUE]

# use descriptive activity names to name the activities in the data set
activityNamesSet <- merge(meanAndStdSet,
                              activityLabels,
                              by = 'activityId',
                              all.x = TRUE)

# Please upload the tidy data set created in step 5 of the instructions.
# Please upload your data set as a txt file created with write.table()
# using row.name=FALSE (do not cut and paste a dataset directly into the
# text box, as this may cause errors saving your submission).

tidyDataset <-aggregate(. ~ subjectId + activityId, activityNamesSet, mean)
tidyDataset <-tidyDataset[order(tidyDataset$subjectId, tidyDataset$activityId), ]
write.table(tidyDataset, "tidyDataset.txt", row.name = FALSE)