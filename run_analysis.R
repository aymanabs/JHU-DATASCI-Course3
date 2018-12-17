setwd('C://JHU_DataSci_Course3')


# load feature names
ftr <- read.csv(file='.//UCI HAR Dataset//features.txt',sep = '',header = FALSE)


#------------ Test data
# load test data with feature names
data_ts <- read.csv(file = './/UCI HAR Dataset//test//X_test.txt',sep = '',header = FALSE,col.names = ftr[,2])

# merge test activity IDs with activity labels
data_ts_activity<-merge(read.csv(file = './/UCI HAR Dataset//test//y_test.txt',sep = '',header = FALSE,col.names = c('activityid')),read.csv(file='.//UCI HAR Dataset//activity_labels.txt',sep = '',header = FALSE,col.names = c('activityid','activity')),by = 'activityid',all = TRUE)

# add activities to test data
data_ts$activity<-data_ts_activity[,"activity"]

# load subject IDs for test data
data_ts_sbj <- read.csv(file = './/UCI HAR Dataset//test//subject_test.txt',sep = '',header = FALSE,col.names = c('subjectid'))

# add subject IDs to test data
data_ts$subjectid <- data_ts_sbj[,'subjectid']

# remove . from test feature names and make them lower cases
names(data_ts)<-gsub('\\.','',tolower(names(data_ts)))


#------------ Train data
# load train data with feature names
data_tr <- read.csv(file = './/UCI HAR Dataset//train//X_train.txt',sep = '',header = FALSE,col.names = ftr[,2])

# merge train activity IDs with activity labels
data_tr_activity<-merge(read.csv(file = './/UCI HAR Dataset//train//y_train.txt',sep = '',header = FALSE,col.names = c('activityid')),read.csv(file='.//UCI HAR Dataset//activity_labels.txt',sep = '',header = FALSE,col.names = c('activityid','activity')),by = 'activityid',all = TRUE)

# add activities to train data
data_tr$activity<-data_tr_activity[,"activity"]

# load subject IDs for train data
data_tr_sbj<-read.csv(file = './/UCI HAR Dataset//train//subject_train.txt',sep = '',header = FALSE,col.names = c('subjectid'))

# add subject IDs to train data
data_tr$subjectid <- data_tr_sbj[,'subjectid']

# remove . from train feature names and make them lower cases
names(data_tr)<-gsub('\\.','',tolower(names(data_tr)))


#------------ Final data set
# final data set combining train and test data with subjectid and activity columns as well as mean and std columns
data_fin<-rbind(data_tr[,c(grep('subjectid',names(data_tr), value = TRUE),grep('activity',names(data_tr), value = TRUE), grep('mean',names(data_tr), value = TRUE), grep('std',names(data_tr), value = TRUE))],data_ts[,c(grep('subjectid',names(data_ts), value = TRUE),grep('activity',names(data_ts), value = TRUE), grep('mean',names(data_ts), value = TRUE), grep('std',names(data_ts), value = TRUE))])

# Checks on the final data set
head(data_fin,n=1)
tail(data_fin,n=1)


#------------ Preparing tidy data set
# Installing package reshape2 to melt the data set and move the features to a column with feature names
install.packages('reshape2')
library(reshape2)

# Meting the final dataset to consider the features as measures while subject ID and activity to be IDs
tidy_data <- melt(data_fin,id = names(data_fin)[(1:2)],measure.vars = names(data_fin)[-(1:2)])


# Installing package dplyr to summarize the data set into means of features
install.packages('dplyr')
library(dplyr)

# Summarize the data into means of each feature grouped by subject ID and activity
tidy_data_means<- tidy_data %>%
  select(names(tidy_data)) %>%
  group_by(subjectid, activity,variable) %>%
  summarize(mean = mean(value))

# Sort the observation by subject ID, activity, and variable (feature) name
tidy_data_means<-arrange(tidy_data_means,subjectid,activity,variable)


# Installing package tidyr to spread the variable (feature) columnt into separate columns for each feature
install.packages('tidyr')
library(tidyr)

# Spread the variable (feature) columnt into separate columns for each feature in the final data set
tidy_data_fin<-tidy_data_means %>% spread(variable, mean)

head(tidy_data_fin)
tail(tidy_data_fin)

# Extracting the tidy data set to a text file
write.table(tidy_data_fin,file = './/tidy_data_set.txt',row.name=FALSE) 

