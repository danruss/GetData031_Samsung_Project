# README

## Summary
This document summarizes the steps used to generate and analyze a cleaned data set for the wearable computing data provided by UCI.

## Dataset
The analysis assumes that you have downloaded and unzipped the following file into your working directory: 
[Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

More information about this dataset can be found here: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Analysis
### R Libraries
The following R libraries were used in this analysis
* dplyr - To work with data tables
* stringr - For performing column replacement to clean up final output

### DataSet Files
For this Analysis, the following files in the ZIP archive were used:
* /train/subject\_train.txt - Identifies the subject ID for each row of data in X\_train and  Y\_train files.
* /train/X\_train.txt - Each row contains 561 columns of data corresponding to a experiment.  
* /train/y\_train.txt - Identifies which activity was being performed (sitting, standing, etc.).  Labels reside in activity\_labels.txt.
* /test/subject\_test.txt - Identifies the subject ID for each row of data in X\_test and  Y\_test files.
* /test/X\_test.txt - Each row contains 561 columns of data corresponding to a experiment.
* /test/y\_test.txt - Identifies which activity was being performed (sitting, standing, etc.).   Labels reside in activity\_labels.txt.
* /features.txt - Labels for the 561 columns in the X\_train and X\_test files.
* /activity\_labels.txt - Activity labels (1 - WALKING, 2 - WALKING_UPSTAIRS, etc.)

