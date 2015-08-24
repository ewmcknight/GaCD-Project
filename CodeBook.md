# Code Book

This document describes the code inside `run_analysis.R`.

## Data source

* source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Description
###  (from the README.txt file in the above source .zip)
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The dataset contains the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Data Transformation

The code uses package `dplyr`

Flow of the "run_analysis.R" script

1. Loading data from the "/UCI HAR Dataset" directory
    i. From the root directory:
        * "features.txt" as `features`
        * "activity_labels.txt" as `activity_labels`
    ii. From the "/test" directory:
        * "subject_test.txt" as `subject_test`
        * "X_test.txt" as `xtest`
        * "Y_test.txt" as `ytest`
    iii. From the "/train" directory:
        * "subject_train.txt" as `subject_train`
        * "X_train.txt" as `xtrain`
        * "Y_train.txt" as `ytrain`
2. Merging data
    i. `xtest`, `ytest`, and `subject_test` are bound as `test` using `features` as the column names
    ii. `xtrain`, `ytrain`, and `subject_test` are bound as `train` using `features` as the column names
    iii. `test` and `train` are bound as `master`
    iv. The "features.txt" contained duplicates. `master` is stripped of these dups
    v. `master` is stripped of all data not related to mean or standard deviation
    vi. `master` is joined with `Activity` to make it more human-readable
3. Summarizing and saving data
    i. `master` is grouped by "Subject" & "Activity" fields
    ii. `master` is summarized using the means of the remaining columns
    iii. Redundancies in "Gyro" column names are eliminated by converting "BodyBody" to "Body"
    iv. The resulting data is saved as "tidydata.txt"

Resulting dataset:
```
> head(tidydata[,1:5], 10)
   Subject           Activity tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean...Z
1        1             LAYING         0.2215982      -0.040513953        -0.1132036
2        1            SITTING         0.2612376      -0.001308288        -0.1045442
3        1           STANDING         0.2789176      -0.016137590        -0.1106018
4        1            WALKING         0.2773308      -0.017383819        -0.1111481
5        1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662
6        1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020
7        2             LAYING         0.2813734      -0.018158740        -0.1072456
8        2            SITTING         0.2770874      -0.015687994        -0.1092183
9        2           STANDING         0.2779115      -0.018420827        -0.1059085
10       2            WALKING         0.2764266      -0.018594920        -0.1055004
```