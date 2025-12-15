#!/usr/bin/bash

primary_monitor="HDMI-A-1" 
secondary_monitor="DP-1"

wallpaper_1="/mnt/Files/Fan Art/Zpixiv/R/wall/Day/illust_86034756_20201201_1357_p0.jpg"

wallpaper_2="/mnt/Files/Fan Art/Zpixiv/R/wall/Day/illust_45646550_20140828_1407_p0.jpg"


transition_args="--transition-type outer --transition-step 86 --transition-fps 75"

awww img "$wallpaper_1" --outputs "$primary_monitor" $transition_args 

matugen image -t scheme-content "$wallpaper_1"

awww img "$wallpaper_2" --outputs "$secondary_monitor" $transition_args