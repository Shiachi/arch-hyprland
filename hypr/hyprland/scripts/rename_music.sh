#!/bin/bash

shopt -s nullglob

echo --- Reading files ---
loop_split=0

for cue_file in *.cue; do
    ((loop_split++))
    echo $loop_split

    unclean_cue=$(ls *.cue | grep -v '^clean' | head -n 1) 
    unsplit_flac=$(ls *.flac | grep -v '^[0-9]' | head -n 1) 

    echo --- $unclean_cue --- $unsplit_flac ---

    if [[ -n "$unsplit_flac" && ! "$unsplit_flac" =~ ^[0-9] ]]; then
        echo "$cue_file + $unsplit_flac"
        echo --- Cleaning cue ---
        grep -E "^\s*(FILE|TRACK|INDEX|TITLE|PERFORMER)" "$unclean_cue.cue" | sed -E 's/:7[5-9]/:74/g' > clean_cue.cue

        echo "--- Split tracks ---"
        if shnsplit -f clean_cue.cue -o flac -t "${loop_split}-%n" "$unsplit_flac"; then
            echo "--- Add tag from clean cue to split tracks ---"
            cuetag.sh clean_cue.cue "${loop_split}"-[0-9]*.flac           
        else
            echo "ERROR: shnsplit dont works with $unsplit_flac"
        fi

        echo ---delete clean cue file ---
        rm clean_cue.cue
        
    else
        echo "Error: $cue_file dint has a pair"
    fi
done

echo --- open picard for edit tags ---
picard [0-9]*.flac -e CLUSTER -e LOOKUP all
echo --- close picard ---

echo --- rename split tracks ----
for file in [0-9]*.flac; do
  track_number=$(metaflac --show-tag=TRACKNUMBER "$file" | cut -d= -f2)
  title=$(metaflac --show-tag=TITLE "$file" | cut -d= -f2)
  disc=$(metaflac --show-tag=DISCNUMBER "$file" | cut -d= -f2)

  if [ -z "$disc" ]; then disc="1"; fi

  disc=$(printf "%02d" "$disc")
  track_number=$(printf "%02d" "${track_number:-0}")

  title=$(echo "$title" | tr '/' '-' | tr -d '?*:"<>|\\')

  new_name="${disc}-${track_number}. ${title} .flac"
  
  if [ "$file" != "$new_name" ]; then
    mv -v "$file" "$new_name"
  fi
done

echo --- finish ----