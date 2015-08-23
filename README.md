# Getting And Cleaning Data - Course Project

## Introduction

This repo contains my course project to [Coursera](https://www.coursera.org) ["Getting And Cleaning Data"](https://class.coursera.org/getdata-031) course that is part of [Data Science](https://www.coursera.org/specialization/jhudatascience/1) specialization.

About the script and the tidy dataset
-------------------------------------
There is a single script called “run_analysis.R”

This script merges the test and training sets together
Prerequisites for this script:

1. the UCI HAR Dataset must be extracted
2. the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"

After merging testing and training, only the columns containing mean and standard deviation data are used.

The script creates an ouput file names "tidydata.txt"

See`CodeBook.md` for more details


How to use this script
----------------------
1. Obtain source data from [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Unzip preserving directories
1. Clone this repo
2. Run the script from the "UCI HAR Dataset" directory:

$ Rscript run_analysis.R


