### Getting and Cleaning Data Assignment 2

Using the UCI HAR Dataset, 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
(those with mean() or std() in the feature name. )
3. Uses descriptive activity names to name the activities in the data set. (walking, walking_upstairs, etc)
4. Appropriately labels the data set with descriptive variable names. 
(this was done just by getting the features.txt)
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
(simplied dataframe, with X1.walking, etc as colnames, then the feature name as rownames)


