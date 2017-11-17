require(data.table)
require(sqldf) #i like using sql

###############################################################################
# Object: run_analysis.R
# Date: 11/17/2017
# By: Marco Dulog
# Purpose: 
# You should create one R script called run_analysis.R that does the following.
#
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
###############################################################################

#download and unzip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip")

#load all this data locally
xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
ytest<-read.table("UCI HAR Dataset/test/y_test.txt")
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
feat<-read.table("UCI HAR Dataset/features.txt")
subtest<-read.table("UCI HAR Dataset/test/subject_test.txt")
subtrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
activitylabels<-read.table("UCI HAR Dataset/activity_labels.txt")

# assign the column names to the xtrain and xtest datasets
colnames(xtest)<-feat[,2]
colnames(xtrain)<-feat[,2]
colnames(ytest)<-"activity"
colnames(ytrain)<-"activity"
colnames(subtest)<-"subject"
colnames(subtrain)<-"subject"

#smash the datasets together
# activity + subject + vector
trainmst <-cbind(ytrain, subtrain, xtrain)
testmst <-cbind(ytest, subtest, xtest)

#smash the rows together 
merged<-rbind(trainmst, testmst)

#cleanup unused datasets because my computer doesn't have that much memory
rm(xtest)
rm(xtrain)
rm(ytest)
rm(ytrain)
rm(subtest)
rm(subtrain)
rm(trainmst)
rm(testmst)
rm(feat)

#get only the rows where the selected labels match up
selmerged<-merged[, 
    grepl("activity",names(merged)) |
    grepl("subject",names(merged)) |       
    grepl("mean",names(merged)) | 
    grepl("std",names(merged)) ]


#join the two datasets together using sql
df<-sqldf("select al.v2 as activitylab, sm.*
          from activitylabels al 
          join selmerged sm
          on al.v1 = sm.activity")

#get rid of activity column...wish sql could do that without being wordy
df<-subset(df,select=-c(activity))

#get rid of data not used
rm(selmerged)
rm(merged)

#aggregate the data
df<-aggregate(. ~subject + activitylab,  df, mean)
df<-sqldf("select * from df order by subject, activitylab")

#outpout the data
write.table(df,"GetCleanDataProject.txt", row.names = FALSE)

