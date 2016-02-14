Getting and Cleaning Data
=========================

## Code Book ##
A detailed description of the source data that we used can be found in the
`README.txt`, `features_info.txt` and `features.txt` files contained in the link
above.

We were asked to:

1.	merge six files, `subject.test`, `subject.train`,`X_test`, `X_train`,
	`y_test` and `y_train` to create a single data set,

2.	extract the columns that referred to either the mean or standard deviation
	of several variables,

3.	modify the column names to make them more explicit: for example,
	`tBodyAcc-mean()-X` and `fBodyAcc-std()-Y` were modified to
	`time.Body.Acc.mean.X` and `fft.Body.Acc.std.Y` respectively (as the 't' and
	'f' prefixes stood for 'time' and 'Fast Fourier transform' respectively, and
	R doesn't like hyphens and parentheses in its variable and column names),

4.	summarised the data for each variable by `activity` within `subject.id` by
	calculating the mean of each measurement and

5.	write the summary into a space separated values file, `summary.txt`.

The result of this work was going from a merged data set of 61,794 observations
of 565 variables to a final set of 180 observations of 68 variables.

### Variables ###

*	**subject_id**: an integer in the range 1 to 30 that identifies the
	individuals in the original experiments.

*	**activity**: one of the six activities that the individuals were asked to
	carry out while being measured.  They are 'LAYING', 'SITTING', 'STANDING',
	'WALKING', 'WALKING_DOWNSTAIRS' and 'WALKING_UPSTAIRS'.

As for the remaining 66 variables,

*	the suffixes '**X**', '**Y**' and '**Z**' indicate the three axes that
	movement and related values were measured in.

*	'**mean**' and '**std**' denote mean and standard deviation respectively.

*	the prefixes '**time**' and '**FFT**' stand for 'time' and 'Fast Fourier
	Transform'.

The interested reader is referred to the `README.txt` and `features\_info.txt`
that can be downloaded from the link above for further descriptions of the
variables as they are, sadly, beyond the author.

Please see the `README.md` file for details of the files in the repository.
