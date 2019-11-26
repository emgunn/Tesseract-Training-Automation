# This script generates training data for a list of fonts.

# Make sure that the fonts are installed on your OS before running this.

# --fontlist requires the name of the font on your system, not the name of the font file.

# --langdata_dir should point to the directory that contains langdata_lstm
#You can clone this folder from https://github.com/tesseract-ocr/langdata_lstm

# --tessdata_dir should point to the tessdata directory found inside our main tesseract directory, which should exist after installing tesseract

# --maxpages is the number of pages of training data we want to generate. A good number for this is 200 (recommended by YouTube tutorial).

# --output_dir should point to where we want our training files to be

if [ $# -eq 0 ]
then
	echo 'No arguments supplied, first argument must be a system-recognized font name that has been installed on this operating system.'
	exit 1
fi

echo 'Executing "generate_training_data"...'
echo "\n"

# retain directory structure in Git
shopt -s extglob
rm -rf Train/!('.keep')
tesstrain.sh --fonts_dir Fonts \
	--fontlist "$1" \
	--lang eng \
	--linedata_only \
	--langdata_dir langdata_lstm \
	--tessdata_dir ~/Desktop/tesseract-4.1.0/tessdata \
	--save_box_tiff \
	--maxpages 10 \
	--output_dir Train
