#!/bin/sh

mount_point="/dev/sda2"
use_pcent=$(df -k --output=pcent $mount_point | sed 's/%//g' | tail -1)
min_free_pcent=90
dir_movies="/multimedia/Movies"
dir_tv_shows="/multimedia/TV Shows"
dir_music="/multimedia/Music"
i=3

while  use_pcent=$(df -k --output=pcent $mount_point | sed 's/%//g' | tail -1) && test $use_pcent -gt $min_free_pcent
do
        if [ $i -lt 3 ]; then
                file_to_delete=$(find "$dir_tv_shows" -type d -printf '%T+;%p\n' | sort | head -n 1 | cut -d ";" -f 2)
                i=3
        else
                file_to_delete=$(find "$dir_movies" -type d -printf '%T+;%p\n' | sort | head -n 1 | cut -d ";" -f 2)
                i=$(($i - 1))
        fi
        sleep 1
        rm -rf "$file_to_delete"
done
