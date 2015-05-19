### This script creates a tidy data set from the 
### Human Activity Recognition Using Smartphones Data Set,
### when run from the working directory, and assuming
### that the original data are in a subdirectory
### called "UCI HAR Dataset"

library(dplyr)

### Read the various data files ###

# First, training files: X, y, subject
X_train <- read.table("UCI HAR Dataset/train/X_train.txt",
                     sep = "", quote = "", strip.white = TRUE)
y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# Second, test files: X, y, subject
X_test <- read.table("UCI HAR Dataset/test/X_test.txt",
                     sep = "", quote = "", strip.white = TRUE)
y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Third, files containing labels for features and activities
features <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep=" ")
features <- as.character(features$V2)

activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep=" ")
activity_labels <- as.character(activity_labels$V2)

### The following sections corresponds to the project requirements ###

### 1. Merge the training and the test sets to create one data set ###

y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)
data <- rbind(X_test, X_train)

### 2. Extract only the measurements on the mean and standard deviation   ###
### for each measurement.                                                 ###

# find names containing "mean()" or "std"
selectedFeatures <- grepl("mean\\(\\)|std", features)

# reduce dataset to contan only those features
data <- data[, selectedFeatures]

# glue on the y (activity) and subject variables
data <- cbind(data, y, subject)

### 3. Use descriptive activity names to name the activities in the data set ###

data[, 67] <- factor(data[, 67], seq(6), activity_labels)

### 4. Appropriately labels the data set with descriptive variable names. ###

names(data) <- c(as.vector(features[selectedFeatures]), "activity", "subject")

### 5. From the data set in step 4, creates a second, independent tidy data ###
### set with the average of each variable for each activity and each subject ###

tidyData <- aggregate(data[, 1:66], list(data$activity, data$subject), mean)

# save tidy dataset
write.table(tidyData, file = "tidyData.txt", row.name=FALSE)
