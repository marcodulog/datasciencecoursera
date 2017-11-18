# Getting and Cleaning Data Project ReadMe

### Summary
The purpose of this assignment is to demonstrate how to get and clean data using R.  The dataset used was from this source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Which contains data from UCI collected from accelereometers from the Samsung Galaxy S smartphones.  Full descriptions of the datasets are located here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
### Run instructions
- Ensure that you are connected to the internet
- Make sure that you don't have the directory UCI HAR Dataset in your working directory
- if you don't have libraries for "data.frame" and "sqldf" please get them now
### Assignment Instructions
- You should create one R script called run_analysis.R that does the following.
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
### Files in the GitHub repository
- Readme.md - this file contains explanation of assignment and data files used
- run_Analysis.r - contains the R code to perform the analysis
- GetCleanDataProject.txt - contains the tidy dataset
- Codebook.md - codebook of fields used and some associated codes
### Analysis Files
Therer were many files associated with the zip file above but the following were used in the analysis:
- /test/X_test.txt - vector of measurements only in the test directory
- /train/X_train.txt - vector of measurements only in the train directory
- /test/y_test.txt - activity (code only) associted with the X_test vector
- /train/y_train.txt - activity (code only) associated with the X_train vector
- features.txt - labels for all measurements in x_test, x_train vectors
- /test/subject_test.txt - subject ids associated with x_test vector
- /train/subject_train.txt - subject ids associated with the x_train vector
- /activity_labels.txt - readable codes associated with the activities

