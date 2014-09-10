### Getting and cleaning Human Activity Recognition <br> Using Smartphones Data Set

The script (ru_analysis.R) reads the data set of [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip) and makes new data set using the principles of tidy data.

The packages **dplyr** and **tidyr** are used. 

#### The description of script work
#####(*Look also the comments in script*)
* __Step1.__ Read X_test, X_train, y_test, y_train, subject_test, subject_train, features and activity_labels txt-files and assign them to the corresponding data frames. The raw data from "Inertial Signals" folders are not used.
* __Step2.__ Append test and train data to each other with rbind(), name variables and merge all auxiliary data frames into one with cbind().  
* __Step3.__ Select only columns containing "mean()" or "std()" in names of variables.
* __Step4.__ Replace the identifier of activity with descriptive terms from activity_labels data frame. 
* __Step5.__ Rename features columns with more descriptive variable names
* __Step6.__ Calculate mean value for each feature variables
* __Step7.__ Create tidy data set in narrow form
* __Step8.__ Write data frame in **harus_t.txt** (**h**uman **a**ctivity **r**ecognition **u**sing **s**martphones, postfix **t** is to denote  tidy)

*The description of all harus_t variables is in the CodeBook.md*

####Instructions

1. Download the data set from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
2. Create the **data** folder in your R working directory
3. Put the unzip data set into the **data** folder. It is need to save the structure of data set. It means that **data** folder must contain the sub-folders **test** and **train** with txt files
4. Run script
5. Script writes harus_t.txt into the folder **data**