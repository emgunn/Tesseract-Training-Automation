#if [ $# -eq 0 ]
#then
#	echo 'No arguments passed, first argument should specify a trained data file to extract a .lstm file from.'
#	exit 1
#fi

echo 'Executing "extract_init.sh"...'
echo "\n"

#sh combine.sh "$1"

#combine_tessdata -e "Output/${1}.traineddata" eng.lstm

combine_tessdata -e Trained\ Data/eng.traineddata eng.lstm
