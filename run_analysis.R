#CourseProject - GETTING AND CLEANING DATA -24/05/2014

setwd("~/UCI HAR Dataset")

#Obtain the data frames
subjtest<- read.table("test/subject_test.txt")
subjtrain<- read.table("train/subject_train.txt")
xtest<- read.table("test/X_test.txt")
xtrain<- read.table("train/X_train.txt")
ytest<- read.table("test/y_test.txt")
ytrain<- read.table("train/y_train.txt")
features<- read.table("features.txt")

#1.Merge the training and the test sets to create one data set.
dataset1 <- rbind(xtrain, xtest)                     #Row bind the training and test datasets
colnames(dataset1)<- as.character(features[,2])      #name the columns of train+test dataset using features file
subjids <- rbind(subjtrain, subjtest)                #Row bind the subject IDs
activity <- rbind(ytrain, ytest)                     #Row bind the activity IDs
dataset2 <- cbind(subjids,activity,dataset1)         #Column bind subject ids, activity labels to train+test data
colnames(dataset2)[1:2]<- c("Suject_ID", "Activity") #Name the subject ID and activity columns

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
colnames <- as.character(features[,2])                        #create a column name vector
colnames                                                      # observe column names 
dataset3 <-dataset2[,c(1:8, 43:48, 83:88, 123:128, 163:168)]  #Subset to obtain 32 important mean & sd measures of: gravity, tBodyAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk

#3.Use descriptive activity names to name the activities in the data set
dataset3$Activity<- factor(dataset3$Activity, levels = c(1,2,3,4, 5, 6), labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#4.Appropriately labels the data set with descriptive activity names.
colnames(dataset3)[1:8] <- c("subjectid", "activity", "tbodyaccmeanx", "tbodyaccmeany", "tbodyaccmeanz", "tbodyaccsdx", "tbodyaccsdy", "tbodyaccsdz")
colnames(dataset3)[9:14] <- c("tgravaccmeanx", "tgravaccmeany", "tgravaccmeanz", "tgravaccsdx", "tgravaccsdy", "tgravaccsdz")
colnames(dataset3)[15:20] <- c("tbodyaccjerkmeanx", "tbodyaccjerkmeany", "tbodyaccjerkmeanz", "tbodyaccjerksdx", "tbodyaccjerksdy", "tbodyaccjerksdz")
colnames(dataset3)[21:26] <- c("tbodygyromeanx", "tbodygyromeany", "tbodygyromeanz", "tbodygyrosdx", "tbodygyrosdy", "tbodygyrosdz")
colnames(dataset3)[27:32] <- c("tbodygyrojerkmeanx", "tbodygyrojerkmeany", "tbodygyrojerkmeanz", "tbodygyrojerksdx", "tbodygyrojerksdy", "tbodygyrojerksdz")

#5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(plyr)
finaldata <- ddply(dataset3, .(subjectid, activity),  function(datset3) colwise(mean)(dataset3[, 3:32]))

attributes(finaldata)
write.table(finaldata, "tidydata.txt", sep="\t") 
View(finaldata)
