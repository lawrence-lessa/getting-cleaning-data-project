---
title: "README - Getting and Cleaning Data Project - Coursera"
author: "Lawrence Lessa"
date: "22 de dezembro de 2015"
output: html_document
---

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis. 
The resulting data set will contain the average of each variable for each activity and each subject in a file called **Final_Data_Set.txt**.

The project contains:  
 1) a tidy data set as described below. (Data set file: **Final_Data_Set.txt**),    
 2) a link to a Github repository with your script for performing the analysis (<https://github.com/lawrence-lessa/getting-cleaning-data-project.git>), and  
 3) a code book that describes the variables, the data, and any transformations or work that you performed 
   to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 

The script is called **"run_analysis.R"**.  
The script will not execute if it doesn't identify the **"UCI HAR Dataset" directory** and can't load (or install) the **"plyr"** library.

It has two options for execution:  

 1) Default execution where there has to be a "UCI HAR Dataset" directory with the extrated data from the following zip file <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.
 
 2) The script executes the download and extracts the data to a new directory. This can be executed by uncommenting the step zero of the script.
```
## ################################################################################################################# ##
## 0) Download the zipped data and extract to local directory.
## ###################################################################################################################
# #Create a local directory
# if(!file.exists("./GettingCleaningData_Project")){dir.create("GettingCleaningData_Project");print("GettingCleaningData_Project directory created.")}
# setwd("./GettingCleaningData_Project")
# 
# zipped_file <- "./getdata_projectfiles_UCI HAR Dataset.zip"
# output_folder <- "."
# download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#              ,destfile=zipped_file)
# 
# unzip(zipped_file, 
#       exdir=output_folder)
```

**Below are described the contents of the downloaded zip file used to create the tidy data set.  **

**Contents of directory UCI HAR Dataset**  

* directory "test". Contains:  
    a) file "subject_test.txt": An identifier of the subject who carried out the experiment. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    b) file "X_test.txt": A 561-feature vector with time and frequency domain variables.  
    c) file "y_test.txt": Its activity IDs.    

* directory "train". Contains:  
    a) file "subject_train.txt": An identifier of the subject who carried out the experiment. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    b) file "X_train.txt": A 561-feature vector with time and frequency domain variables.  
    c) file "y_train.txt": Its activity IDs.    

* file 'activity_labels.txt': Links the activity IDs with their corresponding activity names.
* file "features.txt": Links the feature vector (files x_train.txt and y_train.txt) with it's labels.
* file "features_info.txt": detailed information on the features.
* file "README.txt": general information.

.