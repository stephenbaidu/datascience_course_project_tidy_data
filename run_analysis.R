library(plyr)
library(reshape2)

# Dataset directory
dataset.dir <- "./UCI HAR Dataset/"

# Main dataset
dataset <- list()

message("Loading features ...")
file_path <- paste0(dataset.dir, "features.txt")
dataset$features <- read.table(file_path, col.names=c('id', 'name'), stringsAsFactors=FALSE)

message("Loading activity_labels ...")
file_path <- paste0(dataset.dir, "activity_labels.txt")
dataset$activity_labels <- read.table(file_path, col.names=c('id', 'Activity'))

# Helper function for loading test and train data
load.data <- function(label) {
  file_path   <- paste0(dataset.dir, label, "/", "subject_", label, ".txt")
  file_path_x <- paste0(dataset.dir, label, "/", "X_", label, ".txt")
  file_path_y <- paste0(dataset.dir, label, "/", "y_", label, ".txt")
  return (cbind(
    subject = read.table(file_path,col.names="Subject"),
          y = read.table(file_path_y, col.names="Activity.ID"),
          x = read.table(file_path_x))
  )
}

message("Loading test data ...")
dataset$test <- load.data("test")

message("Loading train data ...")
dataset$train <- load.data("train")

# Helper function to rename features
rename.features <- function(col) {
  col <- gsub("tBody", "Time.Body", col)
  col <- gsub("tGravity", "Time.Gravity", col)

  col <- gsub("fBody", "FFT.Body", col)
  col <- gsub("fGravity", "FFT.Gravity", col)

  col <- gsub("\\-mean\\(\\)\\-", ".Mean.", col)
  col <- gsub("\\-std\\(\\)\\-", ".Std.", col)

  col <- gsub("\\-mean\\(\\)", ".Mean", col)
  col <- gsub("\\-std\\(\\)", ".Std", col)

  return(col)
}

# Get the tidy data
message("Creating tidy data ...")
tidy_data <- rbind(dataset$test, dataset$train)[,c(1, 2, grep("mean\\(|std\\(", dataset$features$name) + 2)]

# Rename activities to be descriptive
names(tidy_data) <- c("Subject", "Activity.ID", rename.features(dataset$features$name[grep("mean\\(|std\\(", dataset$features$name)]))
tidy_data <- merge(tidy_data, dataset$activity_labels, by.x="Activity.ID", by.y="id")
tidy_data <- tidy_data[,!(names(tidy_data) %in% c("Activity.ID"))]

# Create tidy data set with the averages
tidy_data_average <- ddply(melt(tidy_data, id.vars=c("Subject", "Activity")), .(Subject, Activity), summarise, Mean.Samples=mean(value))

# Write the result to a file
message("Writing the tidy_data and tidy_data_average to file...")
write.csv(tidy_data,         file = "tidy_data.txt",         row.names = FALSE)
write.csv(tidy_data_average, file = "tidy_data_average.txt", row.names = FALSE)

message("Processing completed!")
