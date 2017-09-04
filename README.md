# GettingCleaningData
Getting and Cleaning Data Course Project

###Project    : Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living
## Purpose    : Course Project
## Complete below 5 steps
 # 1.Merges the training and the test sets to create one data set.
 # 2.Extracts only the measurements on the mean and standard deviation for each measurement.
 # 3.Uses descriptive activity names to name the activities in the data set
 # 4.Appropriately labels the data set with descriptive variable names.
 # 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Merged 3 types of files for both subject category Training and Testing
Assigned column names for easy analysis

Later Merged both category to get a single dataset

Extracted columns with std and mean values

Activity Labels are assigned with Reference data using sqldf with INNER JOIN clause

created a different dataset with the average of each vriable

New dataset is pused to a text file.


