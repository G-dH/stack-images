#!/bin/bash
# user script written for Nautilus context menu, but working universaly
# align selected images and stack them to one by averaging (or median) to reduce noise
# © GdH GPL v2 or later
# apt-get install imagemagick hugin-tools exiftool

fname=${1%.*} # name of the first image without extension
prefix="aligned-"
quality=96 # output jpeg compression ratio
# can be imported from script providing "method" variable
[[ "$method" ]] || method=mean # replace "mean" by "median" to use median method for stacking images
        # median is much slower, little less effective in noise reduction
        # but able to eliminate random artefacacts like moving objects
output="$fname-STACKED-$method.jpg" # name of output file

(time  { 
    echo "Trying to align selected images..."
    if ! nice align_image_stack --gpu -a "$prefix" -C "$@" 2>&1 
    #f ! nice align_image_stack --gpu -m -a "$prefix" -C "$@" 2>&1 1 # gpu acceleration if available, -m for perspective correction (problem when too much noise)
        then echo -e "\n\nFailed to align images, result may be blured.\n"
        not_aligned=1
        images="$@"
	echo "$images"
    else images="$prefix*"
    fi

    
    echo -e "\nStacking with $method method..."

    nice convert -verbose -quality $quality $images -evaluate-sequence $method "$output" 2>&1 &&  echo -e "\nCreated stacked image file:\n" `pwd`"/$output" || exit 1

    if [[ ! "$not_aligned" ]]
        then echo -e "\nCleaning...."
             rm -v "$prefix"* 2>&1
    fi
    echo -e "\nCopying EXIF metadata to output..."

    exiftool -tagsFromFile "$1" "$output" -overwrite_original 2>&1

    echo -e "\nComplete!"
    echo -e "\nOutput image file:"
    echo    `pwd`"/$output"
    echo -en "\nProcessing time:"

} ) 2>&1 | zenity --text-info --title "Stack Images - $method" || exit 1 

exit 0
