# Code Book

## Raw Data

The raw data was taken from [Coursera's course files](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
) and extracted into the `data-raw` folder using Mac OS X's built-in data decompression utility. There are two reasons why this was done:

 * The need to provide raw data as part of the package [as described by Jeff Leek](https://github.com/jtleek/datasharing).
 * Github has a limitation that prevents uploading single large files.

## Tidy Data

The resulting data set is the mean of each measurement's average and standard deviation values that are grouped by each participant's activity. It is written in file `average-values.txt` within folder `data-tidy` tab-separated value file with a header row.

Column number	| Data type		| Description 
----------------|---------------|--------------
1				| categorical	| The identifier of the subject performing the test
2				| categorical	| The activity that the subject is performing
3 – 79			| continuous	| The mean of each sensor values's mean and standard deviation given the test subject and activity.

## Data Processing steps

Script `run_analysis.R` goes through these steps to tidy the raw data.

 1. Reads both the training and test data sets of the original data and re-combine them into one data set.
 2. Selects just the variables that are means or standard deviations.
 3. Groups those sensor values by test subject and activity type to calculate their averages.
 4. Lookups the activity labels and maps these labels to their numeric equivalent in the raw data sets.
 6. Re-label the sensor values to indicate that these are the means of the originals.
 5. Writes the output as a tab-separated file with headers.


