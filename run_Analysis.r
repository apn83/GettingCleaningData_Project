# load the required libraries
library("data.table")
library("reshape2")

# Load activity text file + feature text file
path <- getwd()
activity <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("sno", "activityName"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt")
                  , col.names = c("ind", "featureLabels"))
#filter the feature labels with only mean or std 
features_filtered <- grep("(mean|std)\\(\\)", features[, featureLabels])
selected_metrics <- features[features_filtered, featureLabels]
# remove the function class () from labels
selected_metrics <- gsub('[()]', '', selected_metrics)

# Load train datasets => read X_train.txt, add labels and class to it.
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, features_filtered, with = FALSE]
colnames(train)
data.table::setnames(train, colnames(train), selected_metrics)
trainingActivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
SubjectTrainId <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("SubId"))
train <- cbind(SubjectTrainId, trainingActivities, train)

# Load test datasets => similar to trian dataset, read test dataset. It is important to note that col.names
# should both be same in train and test activity for successful merging
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, features_filtered, with = FALSE]
data.table::setnames(test, colnames(test), selected_metrics)
testingActivities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt")
                        , col.names = c("Activity"))
SubjectsTestId <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("SubId"))
test <- cbind(SubjectsTestId, testingActivities, test)
# Check for same number of columns to merge the datasets in row-wise fashion
dim(train)
dim(test)
# merge datasets and add labels
merged <- rbind(train, test)
# Convert classLabels to activityName basically. 
merged[["Activity"]] <- factor(merged[, Activity]
                                 , levels = activity[["sno"]]
                                 , labels = activity[["activityName"]])
merged[["SubId"]] <- as.factor(merged[, SubId])
# melt the table on Subject ID and Activity columns
merged <- reshape2::melt(data = merged, id = c("SubId", "Activity"))
# Aggregate mean values based on Subject Id and Activity
merged <- reshape2::dcast(data = merged, SubId + Activity ~ variable, fun.aggregate = mean)
# write the table as output
data.table::fwrite(x = merged, file = "Wearable_computing_dataTidy.csv", quote = FALSE)
write.table(merged, file = "dataTidy.txt", row.names = FALSE)
