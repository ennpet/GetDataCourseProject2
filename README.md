# Getting and Cleaning Data - Course Project 2
ennpet  
27. september 2015  

# Goal 1 - Merging the training and the test sets to create one data set.

To merge the data sets i have created helper functions to read the
data from files that take the type (training or test) as a parameter and 
read the data in temporary variables.


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
rootPath <- "UCI HAR Dataset/"

read_subject <- function (type){
    read.csv(paste(rootPath, type, "/", "subject_", type, ".txt", sep = ""), header = FALSE)
}

read_X <- function (type){
    read.table(paste(rootPath, type, "/", "X_", type, ".txt", sep = ""), header = FALSE, 
    colClasses = rep("numeric", 561))
}

read_y <- function (type){
    read.csv(paste(rootPath, type, "/", "y_", type, ".txt", sep = ""), header = FALSE)
}

subject_train <- read_subject("train")
y_train <- read_y("train")
X_train <- read_X("train")

subject_test <- read_subject("test")
y_test <- read_y("test")
X_test <- read_X("test")
```

Then I merged training and test data sets for subjects, activities 
and features by rows.

```r
subject <- rbind(subject_train, subject_test)
y <- rbind(y_train, y_test)
x <- rbind(X_train, X_test)
```

# Goal 3 - Using descriptive activity names to name the activities in the data set

To assign descriptive activity names I have read the "activity_labels.txt" file 
to a data set and used this data set to factor activities with their corresponding labels.


```r
activities <- read.csv(paste(rootPath, "activity_labels.txt",sep = ""),
                 header = FALSE, sep = " ")

y$V1 <- factor(y$V1, levels=activities$V1, labels = activities$V2 )
```

# Goal 4-  Appropriately label the data set with descriptive variable names. 

To label variable names i have read the "features.txt" file to a data set
and used make.names() function to assign names to variables. The original
feature labels have duplicate entries and the make.names() function
makes the duplicate names unique by adding suffixes.

```r
features <- read.csv(paste(rootPath, "features.txt", sep = ""), 
                 header = FALSE, sep = " ")
names(x) <- make.names(features$V2, unique = TRUE, allow_ = TRUE)
```

Then I have added descriptive names to subject and activity data sets.

```r
names(subject) <- "subject_id"
names(y) <- "activity"
```

# Goal 1 - finishing merging the datasets

Now I have mearged the subject, activity and feature datasets by columns.

```r
x <- cbind(subject, y, x)
```

# Goal 2 - extracting only the measurements on the mean and standard deviation for each measurement. 


```r
x.mean.std <- select(x, subject_id, activity, contains(".mean.."), contains(".std.."))
```


# Goal 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

I have grouped the resulting data set by subject and activity and
summerized it using the mean() function.


```r
x.tidy <- x.mean.std %>%
    group_by(subject_id, activity) %>%
    summarise_each(funs(mean))
```

Then I have removed extra periods in the feature variable names (made by make.name() function)
and saved the data set to a file.

```r
names(x.tidy) <-(sub(".mean..", "-mean", names(x.tidy)))
names(x.tidy) <-(sub(".std..", "-std", names(x.tidy)))

write.table(x.tidy, "tidy.txt", row.names = FALSE)
```
