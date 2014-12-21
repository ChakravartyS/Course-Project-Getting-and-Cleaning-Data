## ---- run_analysis.R Housekeeping
setwd ("D:/Coursera/03 Getting and Cleaning Data/Week 3/Course Project")

pkg.to.load.chr <- c ("plyr", "dplyr")
lapply (pkg.to.load.chr, library, character.only = TRUE)

UCI.HAR.path.chr <- "UCI\ HAR\ Dataset"
all.data.df.name.chr <- "all.data.df"

x.train.file.name.chr <- paste (UCI.HAR.path.chr, "/train/X_train.txt", sep = "")
y.train.file.name.chr <- paste (UCI.HAR.path.chr, "/train/y_train.txt", sep = "")
subject.train.file.name.chr <- paste (UCI.HAR.path.chr, "/train/subject_train.txt", sep = "")

x.test.file.name.chr <- paste (UCI.HAR.path.chr, "/test/X_test.txt", sep = "")
y.test.file.name.chr <- paste (UCI.HAR.path.chr, "/test/y_test.txt", sep = "")
subject.test.file.name.chr <- paste (UCI.HAR.path.chr, "/test/subject_test.txt", sep = "")

features.file.name.chr <- paste (UCI.HAR.path.chr, "/features.txt", sep = "")
activity.labels.name.chr <- paste (UCI.HAR.path.chr, "/activity_labels.txt", sep = "")

if (! (exists (all.data.df.name.chr))) {
        ## ---- Download & Unzip UCI HAR .zip Dataset                
        UCI.HAR.zip.file.url <- 
                "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        UCI.HAR.zip.file.name.chr <- "UCI_HAR_Dataset.zip"
        
        download.file (UCI.HAR.zip.file.url, destfile = UCI.HAR.zip.file.name.chr)
        unzip (UCI.HAR.zip.file.name.chr)
}
    
## ---- Read Train & Test Files and Reference Files
        x.train.df <- read.table (x.train.file.name.chr)
        y.train.df <- read.table (y.train.file.name.chr)
        subject.train.df <- read.table (subject.train.file.name.chr)
        
        x.test.df <- read.table (x.test.file.name.chr)
        y.test.df <- read.table (y.test.file.name.chr)
        subject.test.df <- read.table (subject.test.file.name.chr)
        
        features.df <- read.table (features.file.name.chr)
        names (features.df) <- c ("Feature.Id", "Feature.Name")
        
        activity.labels.df <- read.table (activity.labels.name.chr)
        names (activity.labels.df) <- c("Activity.Id", "Activity.Name")
                
## ---- Merge Training and Test Datasets into Single Datasets
        x.data.df <- rbind (x.train.df, x.test.df)
        y.data.df <- rbind (y.train.df, y.test.df)

        subject.df <- rbind (subject.train.df, subject.test.df)
        names (subject.df) <- c("Subject.Id")

## ---- Replace Activity Ids in y.data.df with Corresponding Activity Names 
        y.data.df [, 1] <- activity.labels.df [y.data.df [, 1], 2]
        names (y.data.df) <- c ("Activity.Id")
                        
## ---- Scrub Names of Features for Use as Column Names
        features.df $ Feature.Name <- gsub ("-mean", "Mean", features.df $ Feature.Name)
        features.df $ Feature.Name <- gsub ("-std", "Std", features.df $ Feature.Name)
        features.df $ Feature.Name <- gsub ("[-()]", "", features.df $ Feature.Name)
        features.df $ Feature.Name <- gsub (",", ".", features.df $ Feature.Name)
        
## ---- Determine Mean and Standard Deviation Measurements
        mean.std.features.int <- grep ("Mean|Std\\(\\)", features.df [, 2])
        
## ---- Select Mean and Standard Deviation Measurements in x.data.df
        x.data.df <- x.data.df [, mean.std.features.int]
        
## ---- Assign Scrubbed Column Names in x.data.df
        names (x.data.df) <- features.df [mean.std.features.int, 2]
        
## ---- Combine "x", "y" and "subject" Data Sets by Columns
        all.data.df <- cbind (x.data.df, y.data.df, subject.df)


## ---- Create Independent Tidy Data Set with Mean of Variables for Each Activity & Subject
        tidy.data.df <- ddply (all.data.df, 
                               c ("Subject.Id","Activity.Id"), 
                               numcolwise (mean))

        tidy.data.file.name.chr <- "Run_Analysis_R_Tidy_Data.txt"
        write.table (tidy.data.df, 
                     file = tidy.data.file.name.chr, 
                     row.name = FALSE, 
                     sep = ",")
        
## --------------------------------------------------------------------------------------