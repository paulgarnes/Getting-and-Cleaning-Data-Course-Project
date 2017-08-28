# STEP 1: Merges the training and the test sets to create one data set.

# Make sure the working directory is set correctly. 
# In RStudio, Click Session >> Set Working Directory >> Choose Directory ...
# ...or you can set in using R script as below, for example:
# setwd("3 - Getting and Cleaning Data/Peer Assessment/")

# read the training  and test data from the six (6) text files
trainData <- read.table("./data/train/X_train.txt")
dim(trainData) # (7,352 rows; 561 columns)
trainLabel <- read.table("./data/train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./data/train/subject_train.txt")
testData <- read.table("./data/test/X_test.txt")
dim(testData) # (2,947; 561 columns)
testLabel <- read.table("./data/test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("./data/test/subject_test.txt")
# combine the related training dataset with the related test dataset
joinData <- rbind(trainData, testData)
dim(joinData) # (10,299 rows; 561 columns)
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) # (10,299 rows; 1 column)
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) # (10,299 rows; 1 column)


# STEP 2: Extracts only the measurements on the mean and  
# standard deviation for each measurement. 

features <- read.table("./data/features.txt")
dim(features)  # (561 rows; 2 columns)
meanAndStandardDeviation <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanAndStandardDeviation) # 66 will become the number of columns
joinData <- joinData[, meanAndStandardDeviation]
dim(joinData) # (10,299 rows; 66 columns)
names(joinData) <- gsub("\\(\\)", "", features[meanAndStandardDeviation, 2]) # remove parentheses "()"
names(joinData) <- gsub("-", "", names(joinData)) # remove hyphen "-" in column names 
names(joinData) <- gsub("mean", "Mean", names(joinData)) # Make Upper Case 'M'
names(joinData) <- gsub("std", "Std", names(joinData)) # Make Upper Case 'S'


# STEP 3: Uses descriptive activity names to name 
# the activities in the data set.

activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"


# STEP 4: Appropriately labels the data set with 
# descriptive activity names. 

names(joinSubject) <- "subject"
tidyData <- cbind(joinSubject, joinLabel, joinData)
dim(tidyData) # (10,299 rows; 68 columns)
write.table(tidyData, "tidyData.txt", row.name=FALSE) # export the 1st dataset


# STEP 5: Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 

subjectLen <- length(table(joinSubject)) # 30 in all
activityLen <- dim(activity)[1] # 6 in all
columnLen <- dim(tidyData)[2]
result <- matrix(NA, nrow = subjectLen * activityLen, ncol = columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(tidyData)
row <- 1
for(i in 1:subjectLen) {
        for(j in 1:activityLen) {
                result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == tidyData$subject
                bool2 <- activity[j, 2] == tidyData$activity
                result[row, 3:columnLen] <- colMeans(tidyData[bool1&bool2, 3:columnLen])
                row <- row + 1
        }
}
head(result)
write.table(result, "tidyDataWithMeans.txt", row.name=FALSE) # export the 2nd dataset