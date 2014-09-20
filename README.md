# Human Activity Data Recording Cleanup Script

Given the raw data from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) (Reyes-Ortiz, Jorge L., et. al. 2012), calculate the averages of the raw data's mean and standard deviations group by each test subject's activity.

Delivered by [Sasmito Adibowo](http://cutecoder.org) as part of Coursera class project ["Getting and Cleaning Data"](https://class.coursera.org/getdata-007) by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD.

## Prerequisites

Make sure you have these packages installed in your R runtime:

 * `assertthat`
 * `data.table`
 * `LaF`
 * `dplyr`

## Run Instructions

Since the raw data is included in this repository, all you need to reproduce the result is to remove the output and re-run the script:

 1. Remove tidy data file `average-values.txt` from the `data-tidy` folder.
 2. Set R's current working directory to root directory of this repository.
 3. Run the script `run_analysis.R`.
 4. You should get back the `average-values.txt` tidy data file.

If you need to re-run the script from an alternate folder or change the output file name, the upper part of the script contains some parameters that you can modify:

 * `inputFolder` - The root input folder of the extracted data set.
 * `outputFolder`- Where to place the resulting tidy data.
 * `tidyValuesFilename` – The file name of the resulting data.

## Data Processing 

Plase refer to `CodeBook.md` for a description of the data processing steps taken and the resulting tidy data set.


## License

The script is under the simplified BSD license with attribution. Please refer to file `LICENSE.txt` for the license text.
