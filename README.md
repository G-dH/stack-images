# stack-images

The script can be used to reduce noise in photos by taking several pictures and merging them together by averaging, or to remove moving objects from an image using the median method. The images are aligned before merging so you can use hand-held shots. Primarily created as a Nautilus script, but it also works independently - takes files (paths) as arguments. Method is determined by setting the *method* variable, it can be done in another script which will then *source* (.) this script.
It's basically a command line tool, but it uses the *zenity* window to show progress of the task.

**Installation of dependencies (Ubuntu):**

    apt-get install imagemagick hugin-tools exiftool

Result from extremly dark hand-held images from phone camera. Stacked 8,16,32 and 59 images, first line original, second adjusted and sharpened.

![image stacking](https://1.bp.blogspot.com/-LSAfuxvKFRU/X94iXvfmjgI/AAAAAAAAHes/0gmKvwKEss4QtTA3hUrPcOP4B5laVb8iQCLcBGAsYHQ/s1439/multiexpozice.jpeg)
