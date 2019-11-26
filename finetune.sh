# This script trains/fine-tunes our existing LSTM model.

# --continue_from should point to the extracted .lstm model of the model we want to continue fine-tuning from. This should be extracted by a call to extract_lstm.sh.

# --model_output should point to where we want our output to be

# --traineddata should point to our base .traineddata file from tessdata best

# --train_listfile should point to our eng.training_files.txt generated from generate_training_data.sh

# --max_iterations is the number of iterations to perform the fine-tuning.
# If this is too high, our model may be too fine-tuned that it will only recognize the given font.
# If this is too low, our model may struggle to recognize text of this font.
# A good number for this is 400 (recommended by YouTube tutorial).

if [ $# -eq 0 ]
then
	echo 'No arguments passed, first argument must specify output name prefix.'
	exit 1
fi

echo 'Executing "finetune.sh"...'
echo "\n"

# save .keep file to retain directory structure in Git
shopt -s extglob
rm -rf Output/!('.keep')
OMP_THREAD_LIMIT=8 lstmtraining \
	--continue_from eng.lstm \
	--model_output "Output/${1}" \
	--traineddata Trained\ Data/eng.traineddata \
	--train_listfile Train/eng.training_files.txt \
	--max_iterations 400
