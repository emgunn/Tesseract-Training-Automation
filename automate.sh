# This script automates the training process for each font located in the Fonts/ folder.
# These fonts must be installed to the system prior to running this script.

#if [ $# -eq 0 ]
#then
#	echo 'No arguments passed, first argument must specify path to a checkpoint or LSTM file to start fine-tuning from.'
#	exit 1
#fi

count=0

echo 'Executing "automate.sh"...'
echo "\n"

date_hash=$(date +"%m-%d-%Y, %T")
output_log="Logs/log_${date_hash}.txt"
temp="Logs/temp_${date_hash}.txt"
echo "Log Summary for automate on ${date_hash}:" >> "${output_log}"

count=0

# for every font file in Fonts/ folder
for file in Fonts/*
do
	echo "Starting training for ${file}..."

	STARTTIME=$(date +%s)

	# get its system-recognized font name 
	name=$(fc-scan "$file" | grep 'fullname:' | cut -d'"' -f4)

	sh generate_training_data.sh "$name"
	
	if [ $count -eq 0 ]
	then	
		# it is possible that eng.lstm does not exist at first iteration
		# so extract eng.lstm for 'Trained Data'/eng.traineddata
		sh extract_init.sh
	fi
	
	echo "${name}:" >> "${output_log}"

	echo "Evaluation pre-training:" >> "${output_log}"
	sh evaluate.sh eng.lstm 2>&1 | tee "$temp"
	grep 'At iteration 0, stage 0, Eval Char error rate=' "$temp" >> "${output_log}"

	count=$((count + 1))

	# creates new output files
	sh finetune.sh "${name}"

	# re-evaluates with new checkpoint
	echo "Evaluation for ${name}_checkpoint:" >> "${output_log}"
	sh evaluate.sh "Output/${name}_checkpoint" 2>&1 | tee "$temp"
	grep 'At iteration 0, stage 0, Eval Char error rate=' "$temp" >> "${output_log}"

	# combines our checkpoint with old trained data
	# sets the new trained data file in 'Output/{font name}.traineddata'
	sh combine.sh "${name}"

	# extract lstm from our new trained data
	# and rename as eng.lstm
	# moves new trained data file and replaces eng.traineddata in 'Trained Data'/
	sh extract_lstm.sh "${name}"

	ENDTIME=$(date +%s)

	TIME_ELAPSED=$(($ENDTIME - $STARTTIME))

	# move the font to /'Finished Fonts'
	mv "$file" "Finished Fonts/$(basename $file)" 

	# print the time it took to process/train from each font
	echo '\n'
	echo "Time it took to process ${name}:"
	printf '%d hours, %d minutes, and %d seconds\n' $((${TIME_ELAPSED}/3600)) $((${TIME_ELAPSED}%3600/60)) $((${TIME_ELAPSED}%60))
	printf '%d hours, %d minutes, and %d seconds\n\n' $((${TIME_ELAPSED}/3600)) $((${TIME_ELAPSED}%3600/60)) $((${TIME_ELAPSED}%60)) >> "${output_log}"
	count=$((count+1))
done

echo "\nTotal fonts trained: ${count}"

rm $temp
