# Getting and Cleaning Data - Peer Assessment Project

### Steps followed to Transform the Data
1. **Download the dataset** <br>
The dataset was downloaded under the folder called UCI HAR Dataset. <br>
Code to download the dataset: <br>
```
#Url for downloading the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")

#unzip the dataset
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
```
2. **Assign each data to variables** <br>
   a. features <- features.txt : 561 rows, 2 columns <br>
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.<br>
   b. activities <- activity_labels.txt : 6 rows, 2 columns<br>
List of activities performed when the corresponding measurements were taken and its codes (labels)<br>
   c. subject_test <- test/subject_test.txt : 2947 rows, 1 column<br>
contains test data of 9/30 volunteer test subjects being observed<br>
   d. x_test <- test/X_test.txt : 2947 rows, 561 columns<br>
contains recorded features test data<br>
   e. y_test <- test/y_test.txt : 2947 rows, 1 columns<br>
contains test data of activities’code labels<br>
   f. subject_train <- test/subject_train.txt : 7352 rows, 1 column<br>
contains train data of 21/30 volunteer subjects being observed<br>
   g. x_train <- test/X_train.txt : 7352 rows, 561 columns<br>
contains recorded features train data<br>
   h.y_train <- test/y_train.txt : 7352 rows, 1 columns<br>
contains train data of activities’code labels<br>

3. **Merges the training and the test sets to create one data set**<br>
      a. X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function. <br>
      b. Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function <br>
      c. Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function <br>
      d. Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function <br>
      
4. **Extracts only the measurements on the mean and standard deviation for each measurement** <br>
      a. TidyData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subjectId, activityId and the measurements on the mean and standard deviation (std) for each measurement. <br>
      
5. **Uses descriptive activity names to name the activities in the data set** <br>
      a. Entire numbers in activityId column of the TidyData replaced with corresponding activity taken from second column of the activities variable<br>

6. **Appropriately labels the data set with descriptive variable names**<br>
      a. activity column in TidyData renamed into activities. <br>
      b. All Acc in column’s name replaced by Accelerometer
      c. All Gyro in column’s name replaced by Gyroscope
      d. All BodyBody in column’s name replaced by Body
e. All Mag in column’s name replaced by Magnitude
f. All start with character f in column’s name replaced by Frequency
g. All start with character t in column’s name replaced by Time

7. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**<br>
      a. DataFinal (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
b. Export DataFinal into TidyData.txt file.      