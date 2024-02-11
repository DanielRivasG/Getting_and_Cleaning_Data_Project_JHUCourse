# run_analysis.R Script

# Load libraries:
library(tidyverse)
library(here)

# Download files:
if (file.exists("Data.zip") == FALSE) {
  download.file(url ="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "Data.zip")
  unzip("Data.zip")
}
# Read data ####################################################################
# Read test data
dir_Xtest_file <- here("UCI HAR Dataset", "test", "X_test.txt")
Xtest_data <- read_fwf(file = dir_Xtest_file,
                       fwf_empty(dir_Xtest_file))

dir_Ytest_file <- here("UCI HAR Dataset", "test", "y_test.txt")
Ytest_data <- read_csv(file = dir_Ytest_file,
                       fwf_empty(dir_Ytest_file))

dir_Subjtest_file <- here("UCI HAR Dataset", "test", "subject_test.txt")
Subjtest_data <- read_fwf(file = dir_Subjtest_file,
                          fwf_empty(dir_Subjtest_file))


# Read train data
dir_Xtrain_file <- here("UCI HAR Dataset", "train", "X_train.txt")
Xtrain_data <- read_fwf(file = dir_Xtrain_file,
                        fwf_empty(dir_Xtrain_file))

dir_Ytrain_file <- here("UCI HAR Dataset", "train", "y_train.txt")
Ytrain_data <- read_csv(file = dir_Ytrain_file,
                        fwf_empty(dir_Ytrain_file))

dir_Subjtrain_file <- here("UCI HAR Dataset", "train", "subject_train.txt")
Subjtrain_data <- read_fwf(file = dir_Subjtrain_file,
                           fwf_empty(dir_Subjtrain_file))


# Read variable names:
dir_varnames_file <- here("UCI HAR Dataset", "features.txt")
varnames <- read_csv(dir_varnames_file, col_names = FALSE)

final_varnames <- str_split(varnames$X1, pattern = " ", simplify = T) %>% 
  as_tibble %>%
  select(2) %>%
  rename("vars" = V2)


# Read activity names
dir_actnames_file <- here("UCI HAR Dataset", "activity_labels.txt")
actnames <- read_csv(dir_actnames_file, col_names = FALSE)

final_actnames <- str_split(actnames$X1, pattern = " ", simplify = T) %>% 
  as_tibble %>%
  rename("id_activity" = V1, "activity" = V2) %>%
  mutate(id_activity = as.numeric(id_activity))

################################################################################

# combine all data sets ########################################################

# First of all, I will combine xtest_data and xtrain_data:
Xdata <- bind_rows(Xtrain_data, Xtest_data)

# Secondly, I will assign the names in varnames to the names of the Xdata variables,
# but first I make sure Xdata is a tibble:
Xdata <- as_tibble(Xdata)
names(Xdata) <- final_varnames$vars
names(Xdata)

# Third, I combine the values of Ytrain_data and Ytest_data, and also the values 
# of subjtrain_data and subjtest_data:

Ydata <- bind_rows(Ytrain_data, Ytest_data)
Subject_data <- bind_rows(Subjtrain_data, Subjtest_data)

names(Ydata) <- "id_activity"
names(Subject_data) <- "id_subject"

# Finally, I combine Xdata, Ydata and subject_data to have all the data in a 
# single data set:

complete_data <- bind_cols(Xdata, Ydata, Subject_data)

################################################################################

# Selection of columns that refer to the mean or standard deviation ############

selected_data <- complete_data %>%
  select(contains(match = "mean", ignore.case = FALSE) | 
         contains("std", ignore.case = FALSE), id_activity, id_subject)

# with the above code snippet, the columns where "mean()", "meanFreq()" and 
# "std()" appear are preserved.
names(selected_data)

# Up to this point I have complied with numerals 1, 3 and 4 of this assignment:
# I have created a single data set with all the variables, the variable names are
# descriptive and I have selected the columns indicated in the assignment.

# Now I will give a descriptive name to each activity:

final_selected_data <- left_join(selected_data, final_actnames, by = "id_activity")

#################################################################################

# final_data_summarized ####################################################################

final_data_summarized <- final_selected_data %>%
  group_by(activity, id_subject) %>%
  summarise_all(.funs = mean)

names(final_data_summarized)

