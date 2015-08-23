library(dplyr)
# setwd("UCI HAR Dataset") # needed if not run from the dataset root

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt", col.names = c("Activity_ID", "Activity"))

subject_test <- read.table("./test/subject_test.txt", col.names = "Subject")
xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/Y_test.txt", col.names ="Activity_ID")
 
subject_train <- read.table("./train/subject_train.txt", col.names = "Subject")
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/Y_train.txt", col.names = "Activity_ID")

# Populate the variable names and bind the subject #'s and activity #'s
test <- xtest
names(test) <- features[,2]
test <- cbind(ytest, test)
test <- cbind(subject_test, test)

train <- xtrain
names(train) <- features[,2]
train <- cbind(ytrain, train)
train <- cbind(subject_train, train)

# Combine the two datasets
master <- rbind(test, train)

# Unfortunately, the "features.txt" contains duplicate column names...
# ...so to clean it up (this only affects the unneeded columns)
master <- master[ , !duplicated(colnames(master))]

master <- master %>%
    select(Subject, Activity_ID, matches("mean|std")) %>%       # select only needed
    left_join(activity_labels) %>%                              # populate Activity
    select(Subject, Activity, everything(), -Activity_ID) %>%   # reorder, remove Activity_ID
    group_by(Subject, Activity) %>%                             # group and summarise
    summarise_each(funs(mean))

# Find/replace the redundant "BodyBody" in column names
names(master) <- gsub("BodyBody", "Body", names(master))

write.table(master, file = "tidydata.txt", row.names = FALSE)
