# Project: Cleaning Data
Repo for course project - Getting and Cleaning Data

Description of how run_analysis.R works.

Line 4: loads dplyr library, required for summarization of data

Line 7: Initialize a vector of activity names,  with keys matching
		the activity ID in the dataset
		
Lines 11-13: Read the feature names for the columns in the X_test/X_train 
			 files, and create an additional attribute that removes 
			 characters that can't be used in column names for R data frames
			 (specifically -, ( and ))
			 
Line 18: Get the column numbers containing mean() and std() using grep.
		 [(] is in square brackets so that it evaluated literally as an
		 open parenthesis
		 
Lines 21-26: Load the X_train and X_test datasets using read.fwf,
			 using the strings calculated in lines 11-13 as column
			 names. combine into a single data frame using rbind, and
			 delete the partial data sets.

Line 29: Use the column indexes from line 18 to subset only the required 
		 columns (mean and std)
		 
Lines 31-38: Load subject and activity data for test and training datasets.
			 Combine using rbind, ensuring same order of rows (_train before _test)
			 
Lines 42-44: Combine subject, activity, and X_data into a single data frame
			 using cbind. Convery activity ID into activity name using vector
			 from line 7. Convert grouping variables to factors.
			 
Lines 48-49: Convert to dplyr tbl_df and delete original data frame

Line 54: Chain dplyr commands to group by subject and activity and to summarize
		 all other columns by their mean (summarize_each()). Arrange results
		 by subject ID.
		 
Line 56: Write summary table to text file