# Codebook
ennpet  
28. september 2015  

## Data set information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Information about the variables in the original datasets

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

## New data set

New data set contains only average values of the measurements on the mean and 
standard deviation for each measurement and for each subject and activity combination

## Added variables

- subject_id: The identifier of the subject

- activity: Activities labeled according to the 'activity_labels.txt'

## Transformed variable names 

From the original data set were extracted only variables with mean and 
standart deviation values for measurments - the varaiables 
that contains "-mean()" or "-std()" substrings.

These parts of variable names are transformed to "-mean" and "-std"
accordingly

