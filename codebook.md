## Input files

'README.txt' : introduction to the project and data

'features_info.txt': Shows information about the variables used on the feature vector.

'features.txt': List of all features.

'activity_labels.txt': Links the class labels with their activity name.

'train/X_train.txt': Training set with 561 statistical features based on signal data.

'train/y_train.txt': Training labels.

'test/X_test.txt': Test set with 561 statistical features based on signal data.

'test/y_test.txt': Test labels.

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

## Output expected:

A tidy dataset by merging test and train dataset by adding appropriate labels and levels. Produce tidy txt file.

## Code variables:

libraries used: data.table, reshape2

1. activity: 6 obs. of 2 variables
6 activites like walking, walking upstairs, walking downstaris, sitting, standing, laying
2. features: 561 obs. of 2 variables (ex: tBodyAcc-mean()-X..)
3. features_filtered: 1:66 values [filter index of 561 features to retain only mean or std)
4. selected_metrics:  extract corresponding index of features_filtered
5. train: 7352 obs. of 68 variables (read train/X_train.txt)
6. test: 2947 obs. of 68 variables (read test/X_test.txt)
7. trainingActivites: 7352 obs. of 1 variable (levels)
8. testingActivities: 2947 obs. of 1 variable (levels)
9. SubjectTestId: 2947 obs. of 1 variable (class of people. range from 1-30)
10 SubjectTrainingId: 7352 obs. of 1 variable (class)
11. merged: 180 obs. of 68 variables (merged test and train set and Final output after using reshape2 melt & dcast)

## Code run_Analysis.r is commented with detailed explanations
