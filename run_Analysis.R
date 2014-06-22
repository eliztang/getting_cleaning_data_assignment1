# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Merges the training and the test sets to create one data set.
train.dataset = read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
train.subject = read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
train.label = read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
head(train.dataset)
test.dataset = read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
test.subject = read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
test.label = read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
head(test.dataset)
dataset = rbind(train.dataset,test.dataset)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
features = read.table("UCI HAR Dataset//features.txt", header=FALSE)
# Appropriately labels the data set with descriptive variable names.
colnames(dataset) = features$V2
mean.columns = grep("mean()", features$V2)
std.columns = grep("std()", features$V2)
dataset = dataset[,c(mean.columns, std.columns)]

# Uses descriptive activity names to name the activities in the data set
# WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
label = rbind(train.label, test.label)
label[label$V1 ==1, "activity"] = "walking"
label[label$V1 ==2, "activity"] = "walking_upstairs"
label[label$V1 ==3, "activity"] = "walking_downstairs"
label[label$V1 ==4, "activity"] = "sitting"
label[label$V1 ==5, "activity"] = "standing"
label[label$V1 ==6, "activity"] = "laying"

subject = rbind(train.subject, test.subject)
colnames(subject) = "subject"
activity = label$activity
all.dataset = cbind(subject, activity, dataset)
colnames(all.dataset)

# Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 
library(plyr)
split.dataset = split(all.dataset, list(all.dataset$subject, all.dataset$activity))
simplied = sapply(split.dataset, function(xx) {
  colMeans(xx[,-c(1,2)])
})
simplied = data.frame(simplied)
write.csv(simplied, file="simpliedData.csv")
