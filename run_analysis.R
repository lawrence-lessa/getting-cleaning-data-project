## Getting and Cleaning Data
## Course Project
## Lawrence Lessa
## December 2015

#setwd("C:/Lawrence/Coursera/Data Science Specialization/3_Getting_and_Cleaning_Data/Project")
#setwd("C:/Lawrence/Coursera/Data Science Specialization/3_Getting_and_Cleaning_Data/Project/Test_Script")

if(require("plyr")){
  print("plyr is loaded correctly")
} else {
  print("trying to install plyr")
  install.packages("plyr")
  if(require(plyr)){
    print("plyr installed and loaded")
  } else {
    stop("could not install plyr")
  }
}

if(require("dplyr")){
  print("dplyr is loaded correctly")
} else {
  print("trying to install dplyr")
  install.packages("dplyr")
  if(require(dplyr)){
    print("dplyr installed and loaded")
  } else {
    stop("could not install dplyr")
  }
}

#setwd("./GettingCleaningData_Project")

# # ###################################################################################################################
# # 0) Download the zipped data and extract to local directory.
# # ###################################################################################################################
# #Create a local directory
# if(!file.exists("./GettingCleaningData_Project")){dir.create("GettingCleaningData_Project"); print("GettingCleaningData_Project directory created.")}
# setwd("./GettingCleaningData_Project")
# 
# zipped_file <- "./getdata_projectfiles_UCI HAR Dataset.zip"
# output_folder <- "."
# download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#              ,destfile=zipped_file)
# 
# unzip(zipped_file, 
#       exdir=output_folder)

if(!file.exists("./UCI HAR Dataset")){ stop("NO 'UCI HAR Dataset' directory");}

####################################################################################################################
# 1) Merges the training and the test sets to create one data set.
####################################################################################################################

## Load the Activities Label
file_Activity_Label = "./UCI HAR Dataset/activity_labels.txt"
Activity_Label <- read.table(file_Activity_Label)
names(Activity_Label) <- c("Activity_ID","ACTIVITY")

## Load the Features Label
file_Features_Label = "./UCI HAR Dataset/features.txt"
Features_Label <- read.table(file_Features_Label)
names(Features_Label) <- c("FEATURE_ID","FEATURE")


## Load the TEST Data Set ##############################################
## Load the Test Subjects
file_Test_Subject = "./UCI HAR Dataset/test/subject_test.txt"
Test_Subject <- read.table(file_Test_Subject)
names(Test_Subject) <- c("SUBJECT")

## Load the TEST Activity
file_Test_Activity = "./UCI HAR Dataset/test/y_test.txt"
Test_Activity <- read.table(file_Test_Activity)
names(Test_Activity)="Activity_ID"

## Load the TEST Set
file_Test_Set = "./UCI HAR Dataset/test/X_test.txt"
Test_Set <- read.table(file_Test_Set)
names(Test_Set) <- Features_Label[order(Features_Label$FEATURE_ID),2]


## Load the TRAIN Data Set ##############################################
## Load the Train Subjects
file_Train_Subject = "./UCI HAR Dataset/train/subject_train.txt"
Train_Subject <- read.table(file_Train_Subject)
names(Train_Subject) <- c("SUBJECT")

## Load the TRAIN Activity
file_Train_Activity = "./UCI HAR Dataset/train/y_train.txt"
Train_Activity <- read.table(file_Train_Activity)
names(Train_Activity)="Activity_ID"

## Load the TRAIN Set
file_Train_Set = "./UCI HAR Dataset/train/X_train.txt"
Train_Set <- read.table(file_Train_Set)
names(Train_Set) <- Features_Label[order(Features_Label$FEATURE_ID),2]

######################################################################
#Create each individual dataset (train and test)
Test_Data_Set <- cbind(Test_Subject, Test_Activity, Test_Set)
Train_Data_Set <- cbind(Train_Subject, Train_Activity, Train_Set)

#Unite the train and test data sets
Complete_Data_Set <- rbind(Test_Data_Set, Train_Data_Set)

####################################################################################################################
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
####################################################################################################################
# Extract a subset of the existing measurements.
# Since there was a doubt over specific measurements (that contained an indication of "mean"), 
#   I've decided to include all the measurements that contained the term "mean".
# Better to include rather than exclude.
#Partial_Data_Set  
Partial_Data_Set <- cbind("SUBJECT" = Complete_Data_Set$SUBJECT, "Activity_ID" = Complete_Data_Set$Activity_ID,
                        Complete_Data_Set[,grepl("mean[()]",names(Complete_Data_Set))],
                        Complete_Data_Set[,grepl("std[()]",names(Complete_Data_Set))])

####################################################################################################################
# 3) Uses descriptive activity names to name the activities in the data set
####################################################################################################################
#include the activity description
#require("plyr")
Partial_Data_Set <- join(Partial_Data_Set,Activity_Label)

####################################################################################################################
# 4) Appropriately labels the data set with descriptive variable names. 
####################################################################################################################
# OK
names(Partial_Data_Set) <- gsub("[)]", "", gsub("[(]", "", gsub("[-]", "", gsub("[-]mean", "Mean", gsub("[-]std", "Std", gsub("BodyBody", "Body", names(Partial_Data_Set)))))))
#names(Partial_Data_Set)
####################################################################################################################
# 5) From the data set in step 4, creates a second, independent tidy data set 
#       with the average of each variable for each activity and each subject.
####################################################################################################################

#write.table(Partial_Data_Set, "./Partial_Data_Set.txt", sep="\t", row.names = FALSE) 
#library(dplyr)
options(dplyr.width = Inf)
FINAL_DATA_SET <- Partial_Data_Set %>%
                  group_by(SUBJECT,ACTIVITY) %>%
                  summarise_each(funs(mean(., na.rm=TRUE)), -Activity_ID) 
                  # %>% glimpse()

write.table(FINAL_DATA_SET, "./Final_Data_Set.txt", sep="\t", row.names = FALSE) 

