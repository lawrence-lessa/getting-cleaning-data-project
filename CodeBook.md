---
title: "Getting and Cleaning Data - Course Project Codebook - Coursera"
author: "Lawrence Lessa"
date: "December 22 2015"
output: html_document
---
==============================================================

## Data Source

The data originated from the **Human Activity Recognition Using Smartphones Dataset**.  
- [Link to DataSet](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
- [Link to DataSet Definition](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."  

## Data set

The final dataset was created by joining two similar datasets (for training and testing purposes).
Then, the dataset was filtered to consider only the required features (the mean and standard deviation measurements)

```
Complete_Data_Set[,grepl("mean[()]",names(Complete_Data_Set))],
Complete_Data_Set[,grepl("std[()]",names(Complete_Data_Set))])
```

This expression extracted 66 features from the original data set that were combined with the subject identifier and activity label to produce the intermediate data set.

### Final data set

The final data set contains the average of all feature standard deviation and mean values of the raw dataset.

Original variable names were modified in the following way:

 1. Replaced `BodyBody` with `Body`
 2. Replaced `-std` with `Std`
 3. Replaced `-mean` with `Mean`
 4. Removed parenthesis `-()`
