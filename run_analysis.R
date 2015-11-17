#read label files
features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

#Correcting errors in file
features$V2<-(sub("BodyBody", "Body", features$V2, fixed = TRUE))


#read training and testing files
subject_train<-read.table("train/subject_train.txt", col.names = "Subject")
x_train<-read.table("train/X_train.txt")
y_train<-read.table("train/y_train.txt", col.names = "Activity")

subject_test<-read.table("test/subject_test.txt", col.names = "Subject")
x_test<-read.table("test/X_test.txt")
y_test<-read.table("test/y_test.txt", col.names = "Activity")

#create merged dataset
merged_X_data<-rbind(x_train,x_test)
colnames(merged_X_data)<-features$V2

merged_y_data<-rbind(y_train, y_test)

#Converting to factor to create levels and assign level labels with Activity data
merged_y_data$Activity<-as.factor(merged_y_data$Activity)
levels(merged_y_data$Activity)<-activity_labels$V2

merged_subject_data<-rbind(subject_train, subject_test)

merged_data<-cbind(merged_subject_data, merged_y_data, merged_X_data)

#Extract variables with mean() and std() in description
tidy_data<-merged_data[, c(1,2, grep("mean()", names(merged_data), fixed = TRUE), grep("std()", names(merged_data), fixed = TRUE))]

#Calculate average of each variable for each activity and each subject
final_tidy_data<-aggregate(tidy_data[,c(-1,-2)], by= list(tidy_data$Subject, tidy_data$Activity), FUN=mean)

#Rename group columns created due to aggregate function to Subject and Activity
names(final_tidy_data)[c(1,2)]<-names(tidy_data)[c(1,2)]

names(final_tidy_data)[c(-1,-2)]<-sub("Acc", "Acceleration", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("Mag", "Magnitude", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("Gyro", "Gyroscope", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("tBody", "TimeDomainBody", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("fBody", "FrequencyDomainBody", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("tGravity", "TimeDomainGravity", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("fGravity", "FrequencyDomainGravity", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("mean()", "Average", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("std()", "StandardDeviation", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("-X", "-Xaxis", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("-Y", "-Yaxis", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)
names(final_tidy_data)[c(-1,-2)]<-sub("-Z", "-Zaxis", names(final_tidy_data)[c(-1,-2)], fixed = TRUE)

