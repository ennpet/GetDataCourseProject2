library(dplyr)

# root path and helper functions for reading the data

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

# reading the train and test data for subjects, activities and features
subject_train <- read_subject("train")
y_train <- read_y("train")
X_train <- read_X("train")

subject_test <- read_subject("test")
y_test <- read_y("test")
X_test <- read_X("test")

# binding the training and test data by rows
subject <- rbind(subject_train, subject_test)
y <- rbind(y_train, y_test)
x <- rbind(X_train, X_test)

# reading feature and activity label data 
features <- read.csv(paste(rootPath, "features.txt", sep = ""), 
                 header = FALSE, sep = " ")
activities <- read.csv(paste(rootPath, "activity_labels.txt",sep = ""),
                 header = FALSE, sep = " ")

# using make.names function to get rid 
# of duplicate variable names
names(x) <- make.names(features$V2, unique = TRUE, allow_ = TRUE)

# selecting only the columns with mean and standard deviation values
x.mean.std <- select(x, contains(".mean.."), contains(".std.."))

# replacing activities with there corresponding informative labels
y$V1 <- factor(y$V1, levels=activities$V1, labels = activities$V2 )

# setting informative names to subject and activity variables
names(subject) <- "subject_id"
names(y) <- "activity"

# binding subject, activity and feature datasets by columns
x.mean.std <- cbind(subject, y, x.mean.std)

# creating a new dataset with average values for each combination of 
# subject and  activity
x.tidy <- x.mean.std %>%
    group_by(subject_id, activity) %>%
    summarise_each(funs(mean))

# removing extra periods from avariable names, 
# created by the make.names function
names(x.tidy) <-(sub(".mean..", "-mean", names(x.tidy)))
names(x.tidy) <-(sub(".std..", "-std", names(x.tidy)))

# writing the dataset to the file
write.table(x.tidy, "tidy.txt", row.names = FALSE)
