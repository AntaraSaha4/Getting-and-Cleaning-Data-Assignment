---
title: "CodeBook"
output: html_document
css : style.css
---

# **Introduction**:

The purpose of writing this codebook is to describe the variables, the data and any transformations or work that performed to clean up the data mentioned in below link:

<http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.

The above mentioned data collected from the accelerometers from the Samsung Galaxy S smartphone.The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

# **Dataset**:
From the above mentioned link you will download a zip file. Extract the data into `UCI HAR Dataset` folder.
The dataset includes the following files:
=========================================

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/subject_train.txt': List of subjects participate in generating training data.
* 'train/subject_test.txt': List of subjects participate in generating test data.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

## **Table and Variables Descriptions**:

*   **`feature.txt`**: `561 rows and 2 columns`,Column name given are `id & functions`
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These signals were used to estimate variables of the feature vector for each pattern: `-XYZ` is used to denote 3-axial signals in the X, Y and Z directions.

*   **`activity_labels.txt`**: `6 rows and 2 columns`, Column name given are `code & activity_name`. This file contain the different activities performed by the participants.

*   **`train/subject_train.txt`**: `7,353 rows and 1 column`, Column name given is `subjects`. It contain the lists of all participants for training data.

*   **`train/X_train.txt`**: `7,353 rows and 561 columns`, Here, Column name are assigned from the variable `functions` generated from `feature.txt` file. It contain the data related to train participants for those variables.

*   **`train/y_train.txt`**: `7,353 rows and 1 column`, Column name given is `code`. It contain the lists of activity code performed by the participants.

*   **`test/subject_test.txt`**: `2,948 rows and 1 column`, Column name given is `subjects`. It contain the lists of all participants for test data.

*   **`test/X_train.txt`**: `2,948 rows and 561 columns`, Here, Column name are assigned from the variable `functions` generated from `feature.txt` file. It contain the data related to test participants for those variables.

*   **`test/y_train.txt`**: `2,948 rows and 1 column`, Column name given is `code`. It contain the lists of activity code performed by the participants.

# **Transformation**

The **Run_analysis.R** script performing the below mentioned steps:

1. **Merges the training and the test sets to create one data set.**

In this step we load all the files mentioned above to (**features,activity,subject_train,X_train,y_train,subject_test,X_test,y_test**) objects respectively.
Then I merged the data as below: 

  * **Data_Train**: using cbind function on *subject_train,X_train,y_train*.
  * **Data_test**:  using cbind function on *subject_test,X_test,y_test*.
  * **Final_data**  using rbind function on *Data_Train,Data_test*. It contains `10299 rows, 563 column`


2. **Extracts only the measurements on the mean and standard deviation for each measurement.**

  * **tidy_data** : Created a new dataset with subject, code and columns which contain 'mean' and 'std'.                      It result in `10299 rows and 88 columns`

3. **Uses descriptive activity names to name the activities in the data set.**
    
  * **merge_data**: To get the activity name for respective code. I merge the data from `tidy_data` &                         `activity` based on column `code`. Removed the column `code` and assigned the data                        back to `tidy_data` from `merge_data` with activity name and other columns.
  
4. **Appropriately labels the data set with descriptive variable names.**
    
  Formatted the column name as follows:
  
  *   Capitalize the first letter of `subjects` and `activity_name`.
  *   Updated column names starting with `t` to `Time`.
  *   Updated column names starting with `f` to `Frequency`.
  *   Updated column names contain `Acc` to `Acceleration`.
  *   Updated column names contain `Gyro` to `Gyroscope`.
  *   Updated column names contain `mean` to `MEAN`.
  *   Updated column names contain `std` to `STD`.
  *   Updated column names contain `angle` to `Angle`.
  *   Updated column names contain `gravity` to `Gravity`.
  *   Updated column names contain `\\...X` to `-X`.
  *   Updated column names contain `\\...Y` to `-Y`.
  *   Updated column names contain `\\...Z` to `-Z`.
  
5.  **From the data set in step 4, creates a second, independent tidy data set with the average of each         variable for each activity and each subject.**

  *   **tidy_set**: Created a set from `tidy_data` group by `subject` and `activity_name` taking average                      on all the columns using `summarise_all` function. 
  *   **tidy_set.txt** : export data from object `tidy_set` to this file using `write.table` function. It                          contain `180 rows and 88 columns`.

Finally, we got our clean data in `tidy_set.txt` for further analysis.
