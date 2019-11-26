#!/bin/bash

# This script installs each font into the system directory.


if [ $# -eq 0 ]
then
	echo 'No arguments passed. First argument must be path to a directory that contains font files (.otf, .ttf).'
	exit 1
fi

path="$1"

[[ "${path}" != */ ]] && path="${path}/"

# for file in files
for file in "$path"*
do

	if [[ $file == *.ttf ]] || [[ $file == *.otf ]]
	then
		# update permissions to make fonts readable globally
		# so they can be installed on the system
		sudo chmod 744 "${file}"
		sudo cp "${file}" /usr/share/fonts/tesseract/
		echo "Installing ${file} to system..."	
	fi

done

printf "\n"
# refresh font cache
#fc-cache -fv

