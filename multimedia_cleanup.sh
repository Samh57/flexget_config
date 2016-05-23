#!/bin/sh

mount_point="/dev/sda2"
use_pcent=`df -k --output=pcent $mount_point | sed 's/%//g' | tail -1`
min_free_pcent=90
dir_movies="/multimedia/Movies"
dir_tv_shows="/multimedia/Movies"

while [ $use_pcent -gt $min_free_pcent ]; do
	 file_to_delete=`find $dir_movies -type d -printf '%T+;%p\n' | sort | head -n 1 | cut -d ";" -f 2`
	 rm -rf $file_to_delete
done
