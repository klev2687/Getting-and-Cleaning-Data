This README explains how the run_analysis.R file process the raw data files contained in UCI HAR Dataset folder.
The contents of UCI HAR Dataset should be available in the working directory of your R session. 
The output of run_analysis.R is a tidy data set with the average of each variable for each activity and each subject.

Files required in working directory:
features.txt
activity_labels.txt
test folder containing subject_test.txt, X_test.txt, y_test.txt
test folder containing subject_test.txt, X_test.txt, y_test.txt

The R script follows the following sequence of steps:

1.
Read label files, namely features.txt and activity_labels.txt to features and activity_labels variable respectively

2.
Correct error in features.txt file. Replace "BodyBody" with "Body"

3.
Read files containing training subject data, namely subject_train.txt, X_train.txt and y_train.txt to subject_train, x_train and y_train variables respectively. Column name of subject_train and y_train updated to "Subject" and "Activity during read function respectively.
Read files containing testing subject data, namely subject_test.txt, X_test.txt and y_test.txt to subject_test, x_test and y_test variables respectively. Column name of subject_test and y_train updated to "Subject" and "Activity" during read function respectively.

4.
Merge x_train and x_test and store in merged_X_data variable using rbind function
Assign column names to merged_X_data referencing second column of features data frame.
Merge y_train and y_test and store in merged_y_data variable using rbind function

5.
Convert Activity column of merged_y_data to class factor with levels defined by second column of activity_labels variable. This provides descriptive names to activities.

6.
Merge subject_train, subject_test and store in merged_subject_data variable using rbind function

7.
Merge merged_subject_data, merged_y_data, merged_X_data in specified sequence and store in merged_data variable using cbind function

8.
Extract columns with headers Subject, Activity and containing strings "mean()" and "std()" using the grep function and store in tidy_data variable.

9.
Calculate average of each columns for each activity and each subject and store in final_tidy_data variable using aggregate function with mean for function argument.

10.
Rename columns 1 and 2 to "Subject" and "Activity" referencing column names from tidy_data variable.

11.
Appropriately label the data set with descriptive variable names as follow.

