## Script for reading, cleaning and tidying the data set of Human Activity Recognition Using Smartphones
##  Please read README.md for instructions.

library(dplyr)
library(tidyr)

# Read the data set files. 
X_test <- read.table("./data/test/X_test.txt")
X_train <- read.table("./data/train/X_train.txt")

y_test <- read.table("./data/test/y_test.txt")
y_train <- read.table("./data/train/y_train.txt")

subject_test <- read.table("./data/test/subject_test.txt")
subject_train <- read.table("./data/train/subject_train.txt")

features <- read.table("./data/features.txt", stringsAsFactors=FALSE)
activity_labels <- read.table("./data/activity_labels.txt",  stringsAsFactors=FALSE)

# Append test and train data separately for X, y and subject and assign the results 
# to corresponding data frames X_tot, Y_tot, subj_tot ([tot]al) 
X_tot<-rbind(X_test, X_train)
Y_tot<-rbind(y_test, y_train)
subj_tot<-rbind(subject_test, subject_train)

# Naming the variables. For X_tot names of variables are taken from the second column of features data frame
names(X_tot)<-features[,2] 
names(Y_tot)<-"Activity"
names(subj_tot)<-"id_Subject"

# merge all data frames in one
DF<-cbind(subj_tot,Y_tot,X_tot)

# I use dplyr package therefore DF is converted in tbl class
df<-tbl_df(DF)

#remove unneeded data frames to release memory
rm(X_test,X_train, y_test, y_train, subject_test, subject_train)

# select only columns containing "mean()" or "std()" in names of variables 
df1<-select(df,id_Subject, Activity, contains("mean\\(\\)"),contains("std\\(\\)"))

#Encode column Activity as factor and rename levels with labels from activity_labels data frame to 
df1$Activity<-as.factor(df1$Activity)
levels(df1$Activity)<- activity_labels[,2]

# rename columns with more descriptive variable names

L_names<-names(df1) #get list of variables names 
L_names<-sub("\\(\\)","",L_names) # delete parentheses
L_names<-gsub("-","_",L_names) # replace "-" with "_" 
names(df1)<-L_names # set new names to data frame

df2<-group_by(df1, id_Subject, Activity) # group by Activity and subject
df3<-summarise_each(df2, funs(mean)) # calculate mean value for each variables except Activity and id_Subject 

df4<-gather(df3, Feature, Value, -Activity, -id_Subject) # create tidy data set

write.table(df4,"./data/harus_t.txt", row.name=FALSE) # save tidy data set in txt-file