## Getting and Cleaning Data - Course Project

## Problem
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:
* a tidy data set as described below,
* a link to a Github repository with your script for performing the analysis, and
* a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

Source dataset for the project is [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

*  You should create one R script called run_analysis.R that does the following.
*  Merges the training and the test sets to create one data set.
*  Extracts only the measurements on the mean and standard deviation for each measurement.
*  Uses descriptive activity names to name the activities in the data set
*  Appropriately labels the data set with descriptive activity names.
*  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Solution

*  Clone this repository.
*  Change current directory to the destination of the clone repository.
*  Download and unzipped the dataset into the current directory.
*  The plyr & reshape2 packages are required.
*  Only the column names containing `...mean()` and `...std()` were used.
*  Run `Rscript run_analysis.R`.


### Notes

The following files are written to the current directory: tidy_data.txt & tidy_data_average.txt.