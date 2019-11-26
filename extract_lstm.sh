# This script extracts the .lstm model file from a .trainneddata file.
# The first argument takes a font name listed in fonts, without its extension.

# The script replaces the trained data in 'Trained Data' with the new trained data file.

if [ $# -eq 0 ]
then
	echo 'No arguments passed, first argument must specify a font name that acts as a prefix to a trained data file to extract a LSTM file from.'
	exit 1
fi

echo 'Executing "extract_lstm.sh"...'
echo "\n"

combine_tessdata -e "Output/${1}.traineddata" eng.lstm
mv "Output/${1}.traineddata" Trained\ Data/eng.traineddata
