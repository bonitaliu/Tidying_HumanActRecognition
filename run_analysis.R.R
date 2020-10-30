# 1. Load packages

library(tidyr) 
library(dplyr) 
library(tidyverse) 
library(reshape2) 


# 2. Read 'features' and 'activity_label' into R

setwd("C:/Users/asus/Desktop/Working Directory for R/3. Data Cleaning_Week 1 Data/UCI HAR Dataset/")
features <- read.table(file = "features.txt", header = FALSE, sep = " ", col.names = c("feat_num", "feat_descript"))
act_label <- read.table(file = "activity_labels.txt", header = F, sep = " ", col.names = c("act_num", "activity"))


# 3. Read 'test' and 'train' data into R

setwd("C:/Users/asus/Desktop/Working Directory for R/3. Data Cleaning_Week 1 Data/UCI HAR Dataset/test")
subject_test <- read.table(file = "subject_test.txt", header = F, sep = " ", col.names = "subject_ID")
x_test <- read.table(file = "x_test.txt", header = F, col.names = features$feat_descript) # THIS LINE
y_test <- read.table(file = "y_test.txt", header = F, col.names = "act_num") 

setwd("C:/Users/asus/Desktop/Working Directory for R/3. Data Cleaning_Week 1 Data/UCI HAR Dataset/train")
subject_train <- read.table(file = "subject_train.txt", header = F, sep = " ", col.names = "subject_ID")
x_train <- read.table(file = "x_train.txt", header = F, col.names = features$feat_descript) # THIS LINE
y_train <- read.table(file = "y_train.txt", header = F, col.names = "act_num")

# the 2 lines marked THIS LINE - uses feature descriptions to name the 561 columns in x_test and x_train
# this works because the 561 rows of of feature descriptions correspond to the 561 variables in x_test and x_train


# 4. Column-bind datasets to achieve one 'test' dataframe, and one 'train' dataframe

alltest <- cbind(subject_test, x_test, y_test)
alltrain <- cbind(subject_train, x_train, y_train)


# 5. Row-bind 'train' and 'test' dataframes together; remove interim dataframes

HAR <- rbind(alltest, alltrain)

rm(alltest, alltrain, 
   subject_test, x_test, y_test,
   subject_train, x_train, y_train)


# 6. Search for 'mean' and 'std' with Grepl; extract from HAR only column names containing 'mean' and 'std'

#     First, test to see whether searching for 'mean' and 'std' in variable names of HAR gives you the correct variables
#     The below line shows you that using select on 'std' will work fine; however, selecting by 'mean' is insufficient as it returns meanFreq as well so that needs to be unselected
#     HARnames <- variable.names(HAR); HARnames[grepl("mean", HARnames, ignore.case = T)]; HARnames[grepl("std", HARnames, ignore.case = T)]
HAR_subset <- select(HAR, subject_ID, act_num, contains("std"), contains("mean"), -contains("meanFreq"))


# 7. Label activity numbers using activity description; Appropriately label variable names

HAR_subset <- merge(HAR_subset, act_label, by = "act_num") 
# both dataframes have column "act_num" which gets merged; column act_label$activity is added into HAR_subset

HAR_subset <- rename(HAR_subset, participant_ID = subject_ID, activity_number = act_num, activity_label = activity)


# 8. Melt into tall skinny dataset, so we can get mean of variables for each participant and activity

# Activity and ID changed to factors
HAR_subset$participant_ID <- as.factor(HAR_subset$participant_ID)
HAR_subset$activity_number <- as.factor(HAR_subset$activity_number)
HAR_subset$activity_label <- as.factor(HAR_subset$activity_label)
# Reshape the dataset; sort by ID and activity
HAR_tall <- reshape2::melt(HAR_subset, id.vars = c("participant_ID", "activity_label", "activity_number"),
                                       measure.vars = (names(HAR_subset)[3:75]),
                                       variable.name = "measure_name")
HAR_tall <- arrange(HAR_tall, participant_ID, activity_number)
                                      

# 9. Create dataset with average of each variable for each participant and activity

HAR_grouped <- group_by(HAR_tall, participant_ID, activity_label, measure_name)
HAR_summary <- summarise(HAR_grouped, avg_measure = mean(value))
rm(HAR_grouped)


# 10. Final removal of interim variables

rm(act_label, features, HAR)


# 11. Write dataset to file

write.table(HAR_subset, file = "HAR_std_mean.txt", quote = F, 
            sep = " ", row.names = F, col.names = T)
write.table(HAR_tall, file = "HAR_tall.txt", quote = F,
            sep = " ", row.names = F, col.names = T)
write.table(HAR_summary, file = "HAR_pt_activity_summary.txt", quote = F,
            sep = " ", row.names = F, col.names = T)