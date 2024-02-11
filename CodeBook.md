# Code Book
This ins my CodeBook. Not much to say, the comments in the script and the Readme.md file describe everything.

## Names of main tibbles in my script
1. **final_varnames** contains a single column with the name of the 561 variables measured in the study.
2. **final_actnames** contains two columns, the first with integers from 1 to 6 that refer to the activities that each subject in the study carried out, and the second with the activity name that corresponds to each number.
4. **complete_data** contains all observations for each of the 561 variables measured and obtained from the training and test data sets, and includes two other variables: activity and "subject_id" to identify which subject and which activity each observation corresponds to
5. **final_selected_data** contains only the columns of complete_data that are required according to the assignment instructions.
6. **final_data_summarized** is the final data set. In this tibble, the average of each of the variables measured for each subject and for each activity is obtained. The data set is arranged in descending order by activity and then by the id of each subject


## Variable names:
There are 82 variables in the final data set. Three of them are the following:

1. **activities** is the name of the categorical variable whose levels are the 6 activities that each subject carried out in the study.
2. **id_subject** is the name of the variable that is used to identify each of the study subjects using an integer number.
3. **id_activity** is the variable used to identify each of the activities carried out in the study using integers from 1 to 6.
4. **the other 79 variables** take the original variable names for the training and testing data sets, which include 561 variables in total.

*The **run_analysis.R** script includes the necessary comments to understand what transformations were done with the data.*

