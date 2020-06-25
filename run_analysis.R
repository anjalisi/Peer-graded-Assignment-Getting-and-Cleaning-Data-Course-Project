###########################################################################################
#STEP 0: Downloading and unzipping dataset
######################################################################################

if(!file.exists("./data"))
{
      dir.create("./data")
}

#Url for downloading the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")

#unzip the dataset
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

####################################################################################
#STEP 1 :Merges the training and the test sets to create one data set.
###################################################################################

#Reading the files

#Reading the training tables
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Reading the test files

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# 1.1.3 Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# 1.1.4 Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

#Assigning colnames
colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#Merging all the data sets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

dim(Merged_Data)


##################################################################################################
#STEP 2 :Extracts only the measurements on the mean and standard deviation for each measurement
##################################################################################################

TidyData <- Merged_Data %>% select(subjectId, activityId, contains("mean"), contains("std"))

##################################################################################################
#STEP 3 : Uses descriptive activity names to name the activities in the data set.
##################################################################################################

TidyData$activityId <- activityLabels[TidyData$activityId, 2]
TidyData$activityId

##################################################################################################
#STEP 4 : Appropriately labels to the data set with descriptive variable names
##################################################################################################
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

TidyData

DataFinal <- TidyData %>%
      group_by(subjectId, activity) %>%
      summarise_all(funs(mean))
write.table(DataFinal, "TidyData.txt", row.name=FALSE)
str(DataFinal)
#Looking at the final data
