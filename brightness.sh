#!/bin/sh

#base directory of your backlight
basedir="/sys/class/backlight/"

#get the current brightness
handler=$basedir$(ls $basedir)"/"

#get current brightness
old_brightness=$(cat $handler"brightness")

#get maximum brightness
max_brightness=$(cat $handler"max_brightness")

#apply change in brightness
new_brightness=$(($old_brightness $1))

if (($new_brightness < $max_brightness)); then
	echo $new_brightness
elif (($new_brightness > $max_brightness)); then
	echo brightness too high, maximizing
	new_brightness=$max_brightness
	echo $new_brightness
elif (($new_brightness < $(2))); then
	echo brightness too low, minimizing
	new_brightness=0
	echo $new_brightness
else 
	echo unexpected failure
fi

sudo chmod 666 $handler"brightness"
echo $new_brightness > $handler"brightness"
