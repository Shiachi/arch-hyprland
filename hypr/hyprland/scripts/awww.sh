#!/usr/bin/bash
sleep 3s #Delay startup until all monitors are ready.
primary_monitor="HDMI-A-1" 
secondary_monitor="DVI-D-1"
base_wallpaper_dir="/mnt/Files/Fan Art/Zpixiv/R/wall"
transition_args="--transition-type outer --transition-step 86 --transition-fps 75"
last_hour=""

history_file_1="/tmp/wallpaper_history_1.txt"
history_file_2="/tmp/wallpaper_history_2.txt"
touch "$history_file_1"
touch "$history_file_2"


while true; do

    current_hour=$(date +%H)

    if [ "$current_hour" != "$last_hour" ]; then
    
        wallpaper_subdir=""

        case $current_hour in
            06|07|08|09|10|11)
                wallpaper_subdir="Morning"
                ;;
            12|13|14|15|16|17)
                wallpaper_subdir="Day"
                ;;
            18|19|20)
                wallpaper_subdir="Sunset"
                ;;
            *)
                wallpaper_subdir="Night"
                ;;
        esac

        current_wallpaper_dir="$base_wallpaper_dir/$wallpaper_subdir"

        if [ -d "$current_wallpaper_dir" ]; then
            wallpaper_1=$(find "$current_wallpaper_dir" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)
            wallpaper_2=$(find "$current_wallpaper_dir" -type f \( -name "*.jpg" -o -name "*.png" \) | grep -vF "$wallpaper_1" | shuf -n 1)


            echo "$wallpaper_1" >> "$history_file_1"
            echo "$wallpaper_2" >> "$history_file_2"

            echo "--- Session History---"
            tail -n 4 "$history_file_1"
            echo "-----------------------------------------"
            tail -n 4 "$history_file_2"
            
            awww img "$wallpaper_1" --outputs "$primary_monitor" $transition_args 
            awww img "$wallpaper_2" --outputs "$secondary_monitor" $transition_args

            matugen image -t scheme-tonal-spot -c ~/.config/matugen/secondary.toml "$wallpaper_2" 
            matugen image -t scheme-tonal-spot "$wallpaper_1" 

            

        else
            echo "Error: Directory $current_wallpaper_dir not found."
        fi
        last_hour=$current_hour
    fi
    
    sleep 60s

done