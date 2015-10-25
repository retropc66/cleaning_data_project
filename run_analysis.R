
# Load libraries required for processing

library("dplyr")

# Set up index vector for activities
activities=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING"
			,"STANDING","LAYING")

# read feature names from features.txt file
features<-read.table("UCI\ HAR\ Dataset/features.txt",sep=" ",header=F)

# Modify feature names to be used as column labels
features[,3]<-gsub("-","_",features[,2])
features[,3]<-gsub("()","",features[,3],fixed=T)

# Identify mean() and std() columns
mean_std_cols<-grep("mean[(]|std[(]",features[,2])

# Read test and training data, combine into a single dataframe
X_test<-read.fwf("UCI HAR Dataset/test/X_test.txt",widths=rep(16,561),col.names=features[,3])
X_train<-read.fwf("UCI HAR Dataset/train/X_train.txt",widths=rep(16,561),col.names=features[,3])
X_data<-rbind(X_train,X_test)

rm(X_test)
rm(X_train)

# Subset only the mean and std columns
X_data<-X_data[,mean_std_cols]

# Read subject IDs and activity IDs for test and training data. Combine.
subj_test<-read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
subj_train<-read.table("UCI HAR Dataset/train/subject_train.txt",col.names="subject")
subject<-rbind(subj_train,subj_test)

activity_train<-read.table("UCI HAR Dataset/train/y_train.txt")
activity_test<-read.table("UCI HAR Dataset/test/y_test.txt")
activity<-rbind(activity_train,activity_test)

# Combine subject, activity, and data into a single data frame

data<-cbind(subject,activity=activities[activity[,1]],X_data)
data[,1]<-as.factor(data[,1])
data[,2]<-as.factor(data[,2])

# Convert to dplyr tbl_df for processing

datat<-tbl_df(data)
rm(data)

# Chain dplyr commands to summarize mean for each measurement by
# activity and subject

data_summary<-datat %>% group_by(subject,activity) %>% summarize_each(funs(mean)) %>% arrange(subject)

write.table(data_summary,file="summarized_data.txt",sep="\t",row.names=F,quote=F)

