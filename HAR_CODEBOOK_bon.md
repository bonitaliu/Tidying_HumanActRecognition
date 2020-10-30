# HAR Codebook

HAR_tall.txt contains the following variables:

* participant_ID - numeric identifier for the subject  
* activity_label - description of activities for which measures were taken  
* activity_number - numeric identifier for each activity e.g. 1 = Walking, 4 = Sitting...  
* measure_name - variables containing the mean() or std() of observed activity  
* value - values corresponding to each observation of each measure_name  

HAR_pt_activity_summary.txt contains the following variables:

* participant_ID - numeric identifier for the subject  
* activity_label - activity for which measures were taken  
* measure_name - variables containing the mean() or std() of observed activity  
* avg_measure - mean values corresponding to each measure_name, for each participant and activity  

From the original dataset, we used the following files:

* activity_labels.txt - containing labels for activity number and description  
* features.txt - containing list of 561 variable names used to set the column names for the x_ data files  
* subject_test.txt and subject_train.txt - containing participant ID  
* x_test.txt and x_train.txt - containing 561 columns or variables with raw and summarized measurements from the various sensors  
* y_test.txt and y_train.txt - containing single column of activity codes (1:6)  

Data transformations:

Please refer to r_analysis.R document for details on how and why each transformation was done at each stage.


  
