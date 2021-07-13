## 1. Merges the training and the test sets to create one data set.

library(dplyr)
library(tidyr)

##    Load the data into respective tables:
setwd("UCI HAR Dataset")

features <- read.table("features.txt",
                       col.names = c("id","functions"))
activity <- read.table("activity_labels.txt",
                       col.names = c("code","activity_name"))

# Train Data
subject_train <- read.table("train/subject_train.txt",
                            col.names = "subject")

X_train <- read.table("train/X_train.txt",
                      col.names = features$functions)

y_train <- read.table("train/y_train.txt",
                      col.names = "code")

Data_Train <- cbind(subject_train,y_train,X_train)

# Test Data
subject_test <- read.table("test/subject_test.txt",
                           col.names = "subject")

X_test <- read.table("test/X_test.txt",
                     col.names = features$functions)

y_test <- read.table("test/y_test.txt",
                     col.names = "code")

Data_test <- cbind(subject_test,y_test,X_test)

# Final data
Final_data <- rbind(Data_Train,Data_test)


## 2.Extracts only the measurements on the mean and 
##   standard deviation for each measurement. 

tidy_data <- select(Final_data,subject,code,
                    contains("mean"),contains("std"))
# contains() mean and std will look for the column with those strings

## 3. Uses descriptive activity names to name the 
##    activities in the data set

merge_data <- merge(activity,tidy_data,
                    by.x = "code",
                    by.y = "code"
                    )

merge_data <- merge_data[,-1] # removed the column code as no longer needed

tidy_data <- select(merge_data,subject,activity_name,everything())

# Alternate method to do the above mentioned is 
# tidy_data$code <- activity[tidy_data$code, 2]

## 4. Appropriately labels the data set 
##    with descriptive variable names. 
##    names_bkp <- names(tidy_data) 
##    Just took a backup of the names for reference

names(tidy_data)[1:2] <- c("Subject","Activity_Name")
names(tidy_data) <-gsub("^t","Time",names(tidy_data))
names(tidy_data) <-gsub("^f","Frequency",names(tidy_data))
names(tidy_data) <-sub("Acc","Acceleration",names(tidy_data))
names(tidy_data) <-gsub("Gyro","Gyroscope",names(tidy_data))
names(tidy_data) <-gsub("mean","Mean",names(tidy_data))
names(tidy_data) <-gsub("std","STD",names(tidy_data))
names(tidy_data) <-gsub("angle","Angle",names(tidy_data))
names(tidy_data) <-gsub("gravity","Gravity",names(tidy_data))
names(tidy_data) <-gsub("\\...X","-X",names(tidy_data))
names(tidy_data) <-gsub("\\...Y","-Y",names(tidy_data))
names(tidy_data) <-gsub("\\...Z","-Z",names(tidy_data))

## 5. From the data set in step 4, creates a second, independent 
##    tidy data set with the average of each variable for each
##    activity and each subject.

tidy_set <-tidy_data %>%
  group_by(Subject,Activity_Name) %>%
  summarise_all("mean") 

write.table(tidy_set,"tidy_set.txt",row.names = FALSE)