----------------------------------------------
1. Variables:

ftr: This object holds the features list as provided in the file 'features.txt'

data_ts: This object holds the test data values for all the features as provided in the file 'X_test.txt'

data_ts_activity: This object holds the activities related to the test data as provided in the file 'y_test.txt' and is merged in the same step with file 'activity_labels.txt' to assign the corresponding activity label

data_ts_sbj: This object holds the subject IDs for the test data as provided in the file 'subject_test.txt'

data_tr: This object holds the train data values for all the features as provided in the file 'X_train.txt'

data_tr_activity: This object holds the activities related to the train data as provided in the file 'y_train.txt' and is merged in the same step with file 'activity_labels.txt' to assign the corresponding activity label

data_tr_sbj: This object holds the subject IDs for the train data as provided in the file 'subject_train.txt'

data_fin: This object combines test data and train data (data_ts & data_tr, respectively) to make a complete data set with columns containing 'mean' OR 'std' as well as subjectID and activity

tidy_data: This object holds the transformed data set (data_fin) after making all columns except subjectID and activity to be measures

tidy_data_means: This object holds the subjectID and activity and the mean value calculated for each measure (feature) with grouping by subjectID and activity and the measure itself

tidy_data_fin: This object holds the tidy data set after converting the measures in (tidy_data_means) back to columns to have one row per observation


----------------------------------------------
2. Functions Used:

read.csv: To read data set files. Used '' as separator to separate on white spaces.

merge: To add columns to a data set from another data set.

gsub: To remove '.' in column (feature) names (substitute with empty string).

tolower: To make all the characters in the column (feature) names as lower case.

rbind: To combine test and train data sets into one data set.

grep: To get column (feature) names that contain 'mean' or 'std'.

melt: To convert feature columns to measures and have them in a single column (variable) with their values in another column.

select, group_by, summarize: To calculate the mean value for each feature grouped by the subject ID and the activity.

spread: To convert the feature variables to columns.

write.table: To extract the tidy data set in a text file.

