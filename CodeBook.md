# CodeBook
This CodeBook describes the variables, the data, and any transformations or work that you performed to clean up the data.
The original data source

    Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The original dataset includes the following files:

    'README.txt'

    'features_info.txt': Shows information about the variables used on the feature vector.

    'features.txt': List of all features.

    'activity_labels.txt': Links the class labels with their activity name.

    'train/X_train.txt': Training set.

    'train/y_train.txt': Training labels.

    'test/X_test.txt': Test set.

    'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

    'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

    'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

    'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

    'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


Transformation details

There are 5 parts:

    Merge the training and the test sets to create one combind data set.
    Extract only the measurements on the mean and standard deviation.
    Use descriptive activity names to name the activities in the data set.
    Appropriately labels the data set with descriptive activity names.
    Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How run_analysis.R implements the above steps:

    Requires plyr and reshape2 libraries.
    Load both test and train data.
    Load the features and activity labels.
    Extract the mean and standard deviation column names and data.
    Process the data. There are two parts processing test and train data respectively.
    Merge data set.
    Write tidy data set out for upload to Github and Coursera

Tidy Dataset Details
    
    Activities: 
    WALKING
    WALKING_UPSTAIRS
    WALKING_DOWNSTAIRS
    SITTING
    STANDING
    LAYING
    
        Features:
     [1] "tBodyAccMeanX"                "tBodyAccMeanY"               
     [3] "tBodyAccMeanZ"                "tBodyAccStdX"                
     [5] "tBodyAccStdY"                 "tBodyAccStdZ"                
     [7] "tGravityAccMeanX"             "tGravityAccMeanY"            
     [9] "tGravityAccMeanZ"             "tGravityAccStdX"             
    [11] "tGravityAccStdY"              "tGravityAccStdZ"             
    [13] "tBodyAccJerkMeanX"            "tBodyAccJerkMeanY"           
    [15] "tBodyAccJerkMeanZ"            "tBodyAccJerkStdX"            
    [17] "tBodyAccJerkStdY"             "tBodyAccJerkStdZ"            
    [19] "tBodyGyroMeanX"               "tBodyGyroMeanY"              
    [21] "tBodyGyroMeanZ"               "tBodyGyroStdX"               
    [23] "tBodyGyroStdY"                "tBodyGyroStdZ"               
    [25] "tBodyGyroJerkMeanX"           "tBodyGyroJerkMeanY"          
    [27] "tBodyGyroJerkMeanZ"           "tBodyGyroJerkStdX"           
    [29] "tBodyGyroJerkStdY"            "tBodyGyroJerkStdZ"           
    [31] "tBodyAccMagMean"              "tBodyAccMagStd"              
    [33] "tGravityAccMagMean"           "tGravityAccMagStd"           
    [35] "tBodyAccJerkMagMean"          "tBodyAccJerkMagStd"          
    [37] "tBodyGyroMagMean"             "tBodyGyroMagStd"             
    [39] "tBodyGyroJerkMagMean"         "tBodyGyroJerkMagStd"         
    [41] "fBodyAccMeanX"                "fBodyAccMeanY"               
    [43] "fBodyAccMeanZ"                "fBodyAccStdX"                
    [45] "fBodyAccStdY"                 "fBodyAccStdZ"                
    [47] "fBodyAccMeanFreqX"            "fBodyAccMeanFreqY"           
    [49] "fBodyAccMeanFreqZ"            "fBodyAccJerkMeanX"           
    [51] "fBodyAccJerkMeanY"            "fBodyAccJerkMeanZ"           
    [53] "fBodyAccJerkStdX"             "fBodyAccJerkStdY"            
    [55] "fBodyAccJerkStdZ"             "fBodyAccJerkMeanFreqX"       
    [57] "fBodyAccJerkMeanFreqY"        "fBodyAccJerkMeanFreqZ"       
    [59] "fBodyGyroMeanX"               "fBodyGyroMeanY"              
    [61] "fBodyGyroMeanZ"               "fBodyGyroStdX"               
    [63] "fBodyGyroStdY"                "fBodyGyroStdZ"               
    [65] "fBodyGyroMeanFreqX"           "fBodyGyroMeanFreqY"          
    [67] "fBodyGyroMeanFreqZ"           "fBodyAccMagMean"             
    [69] "fBodyAccMagStd"               "fBodyAccMagMeanFreq"         
    [71] "fBodyBodyAccJerkMagMean"      "fBodyBodyAccJerkMagStd"      
    [73] "fBodyBodyAccJerkMagMeanFreq"  "fBodyBodyGyroMagMean"        
    [75] "fBodyBodyGyroMagStd"          "fBodyBodyGyroMagMeanFreq"    
    [77] "fBodyBodyGyroJerkMagMean"     "fBodyBodyGyroJerkMagStd"     
    [79] "fBodyBodyGyroJerkMagMeanFreq"           
