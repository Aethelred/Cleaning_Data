#
#                         Getting and Cleaning Data
#                               Final Project
#

#
#  Load the libraries that we'll be using.
#
library(dplyr)

#
#  First we read the data files
#

#  The data that we'll be processing.
X_test <- read.table("~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt", quote="\"",comment.char="")
X_train <- read.table("~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt", quote="\"",comment.char="")

#  Activites
Y_test <- read.table("~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/test/Y_test.txt", quote="\"",comment.char="")
Y_train <- read.table("~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/train/Y_train.txt", quote="\"",comment.char="")

#  Activity labels
activity_labels <- read.table("~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt", quote="\"",comment.char="")


#  Subject IDs
subject_test <- read.table("~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt", quote="\"",comment.char="")
subject_train <- read.table("~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt", quote="\"",comment.char="")

#
#  Next we get the descriptions for the X_test and X_train observations
#
features <- read.table("~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/features.txt", quote="\"", comment.char="")

#
#  Now we can lable columns which will make it easier to merge tables.
#
names(X_test) <- features[,2]
names(X_train) <- features[,2]
names(activity_labels) <- c("a_code","activity")

names(Y_test) <- "a.code"
names(Y_train) <- "a.code"

names(subject_test) <- "subject.id"
names(subject_train) <- "subject.id"


#  First we glue the test sets together
test <- cbind(subject_test, Y_test, X_test)

#  Then the training sets
train <- cbind(subject_train, Y_train, X_train)

#  Now we can glue the test and training data sets together
final <- rbind(test, train)

#  We can translate the activity codes into activities
final <- merge(activity_labels, final)

#  Next we'll remove all of the parentheses and hyphens and relable the columns
names(final) <- make.names(names(final), unique=TRUE)

#  The data frame has columns that we're not interested in, so we'll find the
#  headings that have either "mean()" or standard deviation ("std()") in them;
#  except that the parentheses have been replaced by dots so we'll search for
#  two dots instead.  While we're at it, we'll also grab the "activity" and
#  "subject_id" headers as well.
our_cols <- grep("activity|subject.id|mean\\.\\.|std\\.\\.", names(final),
                 value=TRUE)


#  Now we can select out the columns we are interested in.
final <- select(final, one_of(our_cols))

#  We change the "t" prefix to "time." and the "f" prefix to "FFT."
our_cols <- sub("^t","time.",our_cols)
our_cols <- sub("^f","FFT.",our_cols)

#  We'll put a dot after "Body", "Acc","Gyro", "Gravity" and "Jerk"
our_cols <- gsub("Body","Body.",our_cols)
our_cols <- gsub("Acc","Acc.",our_cols)
our_cols <- gsub("Gyro","Gyro.",our_cols)
our_cols <- gsub("Gravity","Gravity.",our_cols)
our_cols <- gsub("Jerk","Jerk.",our_cols)

#  Finally, we'll tidy up multiple dots.
our_cols <- gsub("\\.\\.\\.",".",our_cols)  # Triple dots
our_cols <- gsub("\\.\\.",".",our_cols)     # Double dots
our_cols <- sub("\\.$","",our_cols)         # Trailing dots

#  Now we can put our tidy column headings in the data.
names(final) <- our_cols

#  At long last, we can create our tidy data set and write it out.
our_summary <- group_by(final, subject.id,activity) %>%
        summarise_each(funs(mean))
write.table(our_summary,
"~/Workbench/MOOCs/Getting and Cleaning Data/UCI HAR Dataset/summary.txt",
row.names = FALSE)