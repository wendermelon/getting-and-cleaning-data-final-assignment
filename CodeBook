The data set that was prepared in run run_analysis.R is data that comes from a study that collected activity data from 30 subjects 
that performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone 
(Samsung Galaxy S II) on the waist.

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

All the data for this assignment was obtained from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data sets include 561 metrics that were recorded in the core data files: X_train.txt and X_test.txt because the subjects were split into training and test groups.  The activity type for each data record are contained in y_train.txt and y_test.txt for training and testing, respectively.  The subject id's are contained in subject_train.txt and subject_test.txt.

There is a separate file with the metric names: features.txt (561 labels for the 561 columns in X_train.txt and X_test.txt) and a separate file with the activity labels (activity_labels.txt) because y_train.txt and y_test.txt are just numeric values that correspond to the 6 different activities.

run_analysis.R does the following:
1. gets just the subject of metrics of interest (mean and std)
2. associates the subject id with the data
3. associates the activity with the data
4. associates the activity label with the activity
5. brings train and test data together
6. calculates an average of all the metric values for each subject and activity type as the final tidy data set
7. writes out the final tidy data set into a txt file
