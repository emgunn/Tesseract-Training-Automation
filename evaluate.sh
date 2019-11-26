# This script takes a model (we should use eng.lstm extracted by extract_lstm.sh from our eng.traineddata best model) and uses it to evaluate training_files.txt (generated from the generate_training_data.sh script).

# These training files are located in Train/, or wherever was specified as the output directory in generate_training_data.sh.

# The --traineddata flag should point to our original eng.traineddata best model. 

if [ $# -eq 0 ]
then
	echo 'No arguments supplied, first argument must be the path to a LSTM model (.lstm) or checkpoint.'
	exit 1
fi

output="$1"

echo 'Executing "evaluate.sh"...'
echo "\n"

lstmeval --model "$output" \
	--traineddata Trained\ Data/eng.traineddata \
	--eval_listfile Train/eng.training_files.txt
