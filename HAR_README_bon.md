# UCI-HAR README

UCI's Machine Learning Repository holds a collection of datasets available for analysis and research. 

To put data wrangling functions in R into practical use, the **John Hopkins' Getting and Cleaning Data** course assigns the current project which requires performing various data formatting functions (such as summarizing, merging and reshaping) on the **Human Activity Recognition Using Smartphones Data Set** (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The purpose of this project is to demonstrate students' ability to collect, work with, and clean a data set, with the goal of preparing a tidy data that can be used for later analysis. 

For this project, I used packages Dplyr, Reshape2, and Tidyverse in RStudio 3.6.2.

## Assignment

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Solution files for the assignment

These files are saved in solution_datasets.zip (file was too large)

* HAR_tall.txt -- dataset of variables containing 'mean' and 'std' reshaped into tall, skinny dataframe; 751827 obs. of 5 vars.   
* HAR_pt_activity_summary.txt -- dataset with means for each variable, as grouped by participant ID and activity; 13140 obs. of 4 vars.  
* HAR_CODEBOOK_bon -- contains explanations for variables of the above two datasets  
* run_analysis.R -- R Script file that runs the analysis to create HAR_tall.txt, HAR_pt_activity_summary.txt, and HAR_subset.txt  


## Other files that might be useful

* HAR_std_mean.txt -- dataset with only measurements of mean and standard deviation extracted out of full dataset, not yet a tall dataset; 10299 obs. of 74 vars.  
