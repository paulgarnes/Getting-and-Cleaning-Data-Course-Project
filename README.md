# Getting and Cleaning Data - Course Project

## This file describes how the "run_analysis.R script" works.

1. Download and extract the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Rename the folder as "data" 

3. Place "data" folder and the "run_analysis.R" script in your current working directory

4. Execute "run_analysis.R". The code generates two text files:
+ tidyData.txt
+ tidyDataWithMeans.txt 

5. Open the final file in MSExcel or in RStudio with the following code: data <- read.table("data_with_means.txt")
