# Getting_and_Cleaning_Data_Project_JHUCourse
In this repository you will find the R script that does everything requested in the course "Getting and Cleaning Data" from Johns Hopkins University, which is taught through Coursera.

In this repository you will find a not very extensive R script called "run_analysis.R". This code does everything indicated in the project of the course "Getting and Cleaning Data", taught by Johns Hopkins University. I have tried to place all the necessary comments within the code to easily understand what the script does.
If you are reviewing the code and the results of said code, keep in mind that both may differ from your work, however, I believe that I have done everything stated in the project instructions.

## Important:
- To run the complete script, you must load the "here" and "tidyverse" libraries into R.
- After I have loaded the necessary libraries, I download the data and unzip it to access the necessary files with functions from the "readr" package.
- Then, I combine all the necessary data into a single tibble, and then select the necessary columns as indicated in the assignment instructions.
- Finally, the script generates a data set sorted by the variables "activity" and "id_subject" in ascending order. The values ​​for all other columns (variables) represent the average according to the subject and the activity that each subject performed.

