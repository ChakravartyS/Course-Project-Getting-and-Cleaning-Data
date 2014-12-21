## CodeBook.md

### Introduction
The script run_analysis.R performs sequential functions to carry out the instructions specified for the project -
* Housekeeping is conducted to set up the various environmental variables and loading libraries
* A single zipped data set is downloaded from the secure URL and unzipped to a series of files
* The extracted files are loaded into appropriate data frames for manipulation and analysis
* The Names of Features are scrubbed to generate R-compatible meaningful column names
* The Names of Features are also screened for computation of Mean and Standard Deviation
* Only the Mean and Standard Deviation compatible columns are selected from X-Data
* Y-Data column name is changed to Activity.Name via a lookup using Activity.Id
* Train and Test components of X-Data, Y-Data and Subject are combined into a single data set
* A secondary Tidy Data Set is produced with column means organised by Subject.Id and Activity.Id
* A Tidy Data Set is written to "Run_Analysis_R_Tidy_Data.txt"
* The R code run_analysis.R, CodeBook.md and README.md are loaded to GitHub

### Data
* The input data files include X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt, subject_test.txt, features.txt and activity_labels.txt
* After appropriate processing, a large data set is produced by combining the train and test versions of x_data, y_data and subject_data
* A tidy data set Run_Analysis_R_Tidy_Data.txt as derived from islarge data set, is produced as output

### R Script
* R version 3.1.2 (2014-10-31) -- "Pumpkin Helmet" was used to develop the code on a 64-bit machine running Windows 8.1
* Detailed comments have been included to clarify the steps
* Google style guide recommendations have been adopted to a large extent
* Indentation has been used to improve readability of the code