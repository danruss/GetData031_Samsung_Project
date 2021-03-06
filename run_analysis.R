# You should create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Download the following data source and place it in your R working directory
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Activity labels are:
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING

SubDir <- "UCI HAR Dataset"

#Load dplyr which makes it easier to manage our data frames
library(dplyr)
#Load stringr library which gives us access to str_replace_all function for later column renaming
library(stringr)

#Merge training and test data sets to create one data set
trainSubject <- read.table(paste(SubDir,"/train/subject_train.txt",sep=""))
trainX <- read.table(paste(SubDir,"/train/X_train.txt",sep=""))
trainY <- read.table(paste(SubDir,"/train/y_train.txt",sep=""))
testSubject <- read.table(paste(SubDir,"/test/subject_test.txt",sep=""))
testX <- read.table(paste(SubDir,"/test/X_test.txt",sep=""))
testY <- read.table(paste(SubDir,"/test/y_test.txt",sep=""))

#concatenate the data tables by row
subject <- rbind(trainSubject, testSubject)
X <- rbind(trainX, testX)
Y <- rbind(trainY, testY)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
# To do this, need to get labels on our data since the column names contain mean(), std(), etc. as part of their name
featureLabels <- read.table(paste(SubDir, "/features.txt", sep=""))
#Use transpose to change our feature label rows to columns and then apply as column names for the X table (features)
colnames(X) <- t(featureLabels[2])

#Get the activity labels
activityLabels <- read.table(paste(SubDir, "/activity_labels.txt", sep=""))
colnames(Y) <- "Activity"
colnames(activityLabels) <- c("Activity", "ActivityLabel")
#Join our activities (Y) with activity labels 
activities <- merge(Y, activityLabels, by = "Activity")

#Label the Subject column
colnames(subject) <- "Subject"

#Combine the labeled data to one data table
fullData <- cbind(subject, activities, X)

#Do the extraction for column names with mean and std in them
meanStdData <- fullData[,grep("((Subject|ActivityLabel)|((mean|std)\\(\\)))", colnames(fullData))]

#Summarize the data grouping by Subject and Activity
summaryData <- 
  meanStdData %>%
  group_by(Subject,ActivityLabel) %>%
  summarise_each(funs(mean))

#colnames(summaryData)
#expand column name abbreviations to friendly names
# t -> Time (prefix 't' to denote time) 
# f -> Frequency (Note the 'f' to indicate frequency domain signals). 
# Gyro -> Gyroscope
# Acc -> Acceleration
# Mag -> Magnitude
# mean() -> Average
# std() -> StandardDeviation

tempColumnNames <- colnames(summaryData)
tempColumnNames <- str_replace_all(tempColumnNames, "^t", "Time-")
tempColumnNames <- str_replace_all(tempColumnNames, "^f", "Frequency-")
tempColumnNames <- str_replace_all(tempColumnNames, "Gyro", "Gyroscope")
tempColumnNames <- str_replace_all(tempColumnNames, "Acc", "Acceleration")
tempColumnNames <- str_replace_all(tempColumnNames, "Mag", "Magnitude")
tempColumnNames <- str_replace_all(tempColumnNames, "mean\\(\\)", "Average")
tempColumnNames <- str_replace_all(tempColumnNames, "std\\(\\)", "StandardDeviation")
colnames(summaryData) <- tempColumnNames

write.table(summaryData, file="SamsungSummaryData.txt", row.name=FALSE)