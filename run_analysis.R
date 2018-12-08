library(dplyr)

#Download the file and unzip files into your working directory
FileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileUrl, destfile = "./SmartphoneSourceData.zip")
unzip("./SmartphoneSourceData.zip")

#Read training data sets
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Read test data sets
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Read features and activity file
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("ActivityID", "Activity")

#Merges the training and the test sets to create one data set.
Merge_X <- rbind(X_train, X_test)
Merge_Y <- rbind(Y_train, Y_test)
Merge_Subject <- rbind(subject_train, subject_test)

#Appropriately labels the data set with descriptive variable names.
colnames(Merge_X) <- features[,2]
colnames(Merge_Y) <- "ActivityID"
colnames(Merge_Subject) <- "SubjectID"
merge_labels <- cbind(Merge_Subject, Merge_Y, Merge_X)

#Extracts only the measurements on the mean and standard deviation for each measurement.
sel_col <- grepl("*mean\\(\\)|*std\\(\\)|ActivityID|SubjectID", names(merge_labels))
sel_data <- Merge_Labels[ , sel_col]

#Uses descriptive activity names to name the activities in the data set.
desc_activity <- merge(sel_data, activity, by="ActivityID") 
desc_activity <- desc_activity[, c(2,ncol(desc_activity), 3:(ncol(desc_activity)-1))]

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- aggregate(.~SubjectID+Activity, desc_activity, mean)
tidy_data <- arrange(tidy_data, SubjectID)
write.table(tidy_data, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)