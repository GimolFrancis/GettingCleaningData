###Project    : Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living
## Created on : 03-Sep-2017
## Purpose    : Course Project
## Complete below 5 steps
 # 1.Merges the training and the test sets to create one data set.
 # 2.Extracts only the measurements on the mean and standard deviation for each measurement.
 # 3.Uses descriptive activity names to name the activities in the data set
 # 4.Appropriately labels the data set with descriptive variable names.
 # 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### TASK-1. Merges the training and the test sets to create one data set.
## Files are available in "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#create directory for the project
if(!file.exists("./projectData")) {dir.create("./projectData")}

# download input files 
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, destfile = "./projectData/Dataset.zip")

#unzip the files to the directory
unzip(zipfile = "./projectData/Dataset.zip", exdir="projectData")

#check the files in the folder
list.files(path = "./projectData", recursive = TRUE)

##reading input files
#reading training file
x_training<-read.table("./projectData/UCI HAR Dataset/train/X_train.txt")
y_training<-read.table("./projectData/UCI HAR Dataset/train/Y_train.txt")
subj_training<-read.table("./projectData/UCI HAR Dataset/train/subject_train.txt")

#reading testing file
x_testing<-read.table("./projectData/UCI HAR Dataset/test/X_test.txt")
y_testing<-read.table("./projectData/UCI HAR Dataset/test/Y_test.txt")
subj_testing<-read.table("./projectData/UCI HAR Dataset/test/subject_test.txt")

##Tidying the files
#training
#Check columns in the files
colnames(x_training)
colnames(y_training)
colnames(subj_training)

## To have the data readable, its good to have the TASK 4 completed at this stage.
## TASK-4.Appropriately labels the data set with descriptive variable names.

#read Master files from the folder
featuresList<-read.table("./projectData/UCI HAR Dataset/features.txt")
colnames(featuresList)
colnames(featuresList) <- c('SubCode','SubDesc')

#need to rename the columns with the activty and Feature code for training
colnames(x_training)<-featuresList[,2]
colnames(y_training)<-"actCode"
colnames(subj_training)<-"subCode"

#testing
#need to rename the columns with the activty and Feature code for testing
colnames(x_testing)<-featuresList[,2]
colnames(y_testing)<-"actCode"
colnames(subj_testing)<-"subCode"

## Merging  files 
#Training
mergeTrainingList <- cbind(x_training,y_training,subj_training)

#Testing
mergeTestingList <- cbind(x_testing,y_testing,subj_testing)

# merging both Training and Testing files
merge_ALL <- rbind(mergeTrainingList,mergeTestingList)
colNames<- colnames(merge_ALL)

### TASK-2.Extracts only the measurements on the mean and standard deviation for each measurement.

mean_and_std<-(grepl("actCode",colNames)|grepl("subCode",colNames)|grepl("mean",colNames)|grepl("std",colNames))

mean_and_std_subset<- merge_ALL[,mean_and_std==TRUE]

### 3.Uses descriptive activity names to name the activities in the data set

##Get the Activity Description from activity_labels.txt
activityList<-read.table("./projectData/UCI HAR Dataset/activity_labels.txt")
colnames(activityList)
colnames(activityList) <- c('actCode','actDesc')

# installs everything you need to use sqldf with SQLite
install.packages("sqldf")

# load sqldf into workspace
library(sqldf)

#Merge / Join new dataset with Activity Labels
mean_and_std_subset_Act <- sqldf("SELECT * FROM mean_and_std_subset JOIN activityList USING(actCode)")
colnames(mean_and_std_subset_Act)

#check number of rows in mean_and_std_subset and mean_and_std_subset_Act if inner join is correct
nrow(mean_and_std_subset)
nrow(mean_and_std_subset_Act)

### TASK-5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Generate independent tidy dataset with average of each variable
dsTidyDataset <- aggregate(.~subCode+actCode+actDesc,mean_and_std_subset_Act,mean)

#write tidy dataset to a text file
write.table(dsTidyDataset,"dsTidyDataset.txt",row.name=FALSE)







