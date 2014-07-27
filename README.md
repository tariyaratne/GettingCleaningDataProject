### How the script works...
========================================

#1. The first step is to combine all the training and the test sets to create one large dataset.  The training and test sets for results(xtrain and xtest), subject IDs (subjtrain and subjtest),
and activity lables (ytrain and ytest) should be "row binded" in order to append the data into one vertically aligned dataset.  The features dataset comprise lables for
all the measures tested  which should form the column labels in the single large dataset.  To form the single large dataset the appended datasets for results, subject IDs and activity labels
should be "column binded".   

dataset1 <- rbind(xtrain, xtest)                     #Row bind the training and test datasets
colnames(dataset1)<- as.character(features[,2])      #name the columns of train+test dataset using features file
subjids <- rbind(subjtrain, subjtest)                #Row bind the subject IDs
activity <- rbind(ytrain, ytest)                     #Row bind the activity IDs
dataset2 <- cbind(subjids,activity,dataset1)         #Column bind subject ids, activity labels to train+test data
colnames(dataset2)[1:2]<- c("Suject_ID", "Activity") #Name the subject ID and activity columns


#2.The second step is to extract only the measurements on the mean and standard deviation for each measurement. 

colnames <- as.character(features[,2])                        #create a column name vector
colnames                                                      # observe column names 
dataset3 <-dataset2[,c(1:8, 43:48, 83:88, 123:128, 163:168)]  #Subset to obtain 30 important mean & sd measures of: gravity, tBodyAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk


#3. The third step is to use the descriptive activity names to name the activities in the data set

dataset3$Activity<- factor(dataset3$Activity, levels = c(1,2,3,4, 5, 6), labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


#4.The fourth step is to appropriately labels the data set with descriptive activity names.

colnames(dataset3)[1:8] <- c("subjectid", "activity", "tbodyaccmeanx", "tbodyaccmeany", "tbodyaccmeanz", "tbodyaccsdx", "tbodyaccsdy", "tbodyaccsdz")
colnames(dataset3)[9:14] <- c("tgravaccmeanx", "tgravaccmeany", "tgravaccmeanz", "tgravaccsdx", "tgravaccsdy", "tgravaccsdz")
colnames(dataset3)[15:20] <- c("tbodyaccjerkmeanx", "tbodyaccjerkmeany", "tbodyaccjerkmeanz", "tbodyaccjerksdx", "tbodyaccjerksdy", "tbodyaccjerksdz")
colnames(dataset3)[21:26] <- c("tbodygyromeanx", "tbodygyromeany", "tbodygyromeanz", "tbodygyrosdx", "tbodygyrosdy", "tbodygyrosdz")
colnames(dataset3)[27:32] <- c("tbodygyrojerkmeanx", "tbodygyrojerkmeany", "tbodygyrojerkmeanz", "tbodygyrojerksdx", "tbodygyrojerksdy", "tbodygyrojerksdz")


#5. The fifth step is to create a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(plyr)
finaldata <- ddply(dataset3, .(subjectid, activity),  function(datset3) colwise(mean)(dataset3[, 3:32]))

attributes(finaldata)
write.table(finaldata, "tidydata.txt", sep="\t") 
View(finaldata)



### Code book
========================== 
Note: Only avearage measurments across repeated activities (per subject) for few important measurements are included in the tidydata.txt (these were described in the original features_info.txt file)  
These measurements include, the mean and standard deviation of 3-axial signals in the X, Y and Z directions for gravity, tBodyAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk  

**Variable**   ;				Definition  							
----------------------------------------------------------------------------------------------------------------------  
**subjectid**; 	  	Subject number  											
**activity**;	  	Activity undertaken (walking, walking_upstairs, warlking_downstairs, sitting, standing, laying)  
**tbodyaccmeanx**;     	Time-series Body Acceleration, Mean for X   
**tbodyaccmeany**;   	Time-series Body Acceleration, Mean for Y     
**tbodyaccmeanz**;   	Time-series Body Acceleration, Mean for Z    
**tbodyaccsdx**;       	Time-series Body Acceleration, Standard Deviation for X   
**tbodyaccsdy**;        Time-series Body Acceleration, Standard Deviation for Y   
**tbodyaccsdz**;        Time-series Body Acceleration, Standard Deviation for Z  
**tgravaccmeanx**;      Time-series Graviy, Mean for X   
**tgravaccmeany**;     	Time-series Graviy, Mean for Y   
**tgravaccmeanz**;     	Time-series Graviy, Mean for Z   
**tgravaccsdx**;       	Time-series Graviy, Standard Deviation for X   
**tgravaccsdy**;        Time-series Graviy, Standard Deviation for Y  
**tgravaccsdz**;        Time-series Graviy, Standard Deviation for Z  
**tbodyaccjerkmeanx**; 	Time-series Body Acceleration Jerk, Mean for X  
**tbodyaccjerkmeany**;  Time-series Body Acceleration Jerk, Mean for Y  
**tbodyaccjerkmeanz**;  Time-series Body Acceleration Jerk, Mean for Z  
**tbodyaccjerksdx**;    Time-series Body Acceleration Jerk, Standard Devation for X  
**tbodyaccjerksdy**;    Time-series Body Acceleration Jerk, Standard Devation for Y  
**tbodyaccjerksdz**;   	Time-series Body Acceleration Jerk, Standard Devation for Z  
**tbodygyromeanx**;    	Time-series Body Gyroscope (acceleration), Mean for X  
**tbodygyromeany**;     Time-series Body Gyroscope (acceleration), Mean for Y  
**tbodygyromeanz**;     Time-series Body Gyroscope (acceleration), Mean for Z  
**tbodygyrosdx**;       Time-series Body Gyroscope (acceleration), Standard Deviation for X  
**tbodygyrosdy**;      	Time-series Body Gyroscope (acceleration), Standard Deviation for Y  
**tbodygyrosdz**;       Time-series Body Gyroscope (acceleration), Standard Deviation for Z  
**tbodygyrojerkmeanx**;	Time-series Body Gyroscope (acceleration) Jerk, Mean for X  
**tbodygyrojerkmeany**;	Time-series Body Gyroscope (acceleration) Jerk, Mean for Y  
**tbodygyrojerkmeanz**;	Time-series Body Gyroscope (acceleration) Jerk, Mean for Z  
**tbodygyrojerksdx**;  	Time-series Body Gyroscope (acceleration) Jerk, Standard Deviation for X  
**tbodygyrojerksdy**;  	Time-series Body Gyroscope (acceleration) Jerk, Standard Deviation for Y  
**tbodygyrojerksdz**;	Time-series Body Gyroscope (acceleration) Jerk, Standard Deviation for Z  
