# gettingAndCleaning  
Course project for Getting and Cleaning Data from Coursera  

The script run_analysis.R reads the following data files from a subdirectory named "UCI HAR Dataset":  
* X_train.txt: containing x-values for training 
* y_train.txt: containing y-values/labeled activities 
* subject_train.txt: identifies the subject who performed the activity 
* X_test.txt: The test set with x-values
* y_test.txt: The test set with y-valuses
* subject_test.txt: identifies the subject who performed the activity in test set
* features.txt: names the 561 features with x-values
* activity_labels.txt: names the 6 different activities used for y-values

Part 1 uses rbind() to merge the training and the test sets (for x, y and subjects) by placing them on top of each other.  

Part 2 uses grepl() to find features containg "mean()" and "std", and subsets the data set to contain only those features. Also, the activities (y-values) and subject id's are added to the data set using cbind()  

Part 3 uses factor() and data from activity_labels.txt to create descriptive activity names.  

Part 4 uses names() and data from features.txt to labels the data set with descriptive variable names.

Part 5 creates a tidy dataset by using aggregate() over activity and subject, thus creating mean values of all measurement for each combination of activity and subject. The column Group.1 contains the name of the activity, Group.2 contains the id number for the subject.  

Finally, theres a write.table() function to save the tidy dataset under the name tidyData.txt.
