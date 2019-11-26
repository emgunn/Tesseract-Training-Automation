# This script combines our previous trained data with our current checkpoint.

if [ $# -eq 0 ]
then
	echo 'No arguments passed, first argument must specify name of font.'
	exit 1
fi

echo 'Executing "combine.sh"...'
echo "\n"

lstmtraining --stop_training \
	--continue_from "Output/${1}_checkpoint" \
	--traineddata Trained\ Data/eng.traineddata \
	--model_output "Output/${1}.traineddata"
