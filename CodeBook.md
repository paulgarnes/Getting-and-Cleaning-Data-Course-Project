# Getting and Cleaning Data Course - Project CodeBook

## This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.

1. The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
2. The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3. The run_analysis.R script works like this:
+ Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in trainData, trainLabel and trainSubject variables respectively.
+ Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in testData, testLabel and testsubject variables respectively.
+ Merge testData to trainData to create joinData; merge testLabel to trainLabel to create joinLabel; concatenate testSubject to trainSubject to create joinSubject.
+ Read the features.txt file from the "/data" folder and store the data in a variable called features.
+ Data cleansing is needed on this data set so perfrom those functions and export the cleanedData out to "tidyData.txt" file in current working directory.
+ Generate a second separate tidy data set and call it "tidyDataWithMeans.txt"