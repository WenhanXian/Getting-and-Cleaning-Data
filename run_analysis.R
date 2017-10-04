library(dplyr)

#Reading test Variables
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
 
#Reading training variables
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
 
#Reading feature vector
features<- read.table("./UCI HAR Dataset/features.txt")

#Reading activity labels
activitylabels<- read.table("./UCI HAR Dataset/activity_labels.txt")

#Merging train and test sets
x_data<-rbind(x_test,x_train)
y_data<-rbind(y_test,y_train)
subject_data<-rbind(subject_test,subject_train)

#selecting required features and renaming variables
select_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, select_features]
names(x_data) <- features[select_features, 2]
y_data[, 1] <- activitylabels[y_data[, 1], 2]
names(y_data) <- "activity"
names(subject_data) <- "subject"

#bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)
write.table(all_data, "all_data.txt", row.name=FALSE)

#creates a second, independent tidy data set with the average of each variable for each activity and each subject
#use group_by and summarize_all function
average_data <- all_data %>% group_by(subject,activity) %>% summarize_all(mean)
write.table(average_data, "average_data.txt", row.name=FALSE)

