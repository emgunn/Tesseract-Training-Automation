#!/bin/bash

# Deletes the current eng.lstm and replaces the trained data file with the English best data.

echo 'Are you sure you want to reset your LSTM (y/n)? It is recommended to save your .lstm and .traineddata files before proceeding.'

read response

if [ ${response,,} == 'yes' ] || [ ${response,,} == 'y' ]
then
	echo 'Resetting LSTM model...'
	rm eng.lstm
	rm 'Trained Data'/eng.traineddata
	cp 'Trained Data'/'English Best'/eng.traineddata 'Trained Data'/eng.traineddata
	echo 'Reset successfully!'
fi	
