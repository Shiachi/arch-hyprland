#!/bin/bash

shopt -s nullglob

echo --- Reading files ---
unclean_cue=$(ls *.cue | grep -v '^clean' | head -n 1) 
unsplit_flac=$(ls *.flac | grep -v '^[0-9]' | head -n 1) 

echo --- $unclean_cue --- $unsplit_flac ---

echo --- Cleaning cue ---
grep -E "^\s*(FILE|TRACK|INDEX|TITLE|PERFORMER)" "$unclean_cue" | sed -E 's/:7[5-9]/:74/g' > clean_cue.cue

echo "--- Split tracks ---"
shnsplit -f clean_cue.cue -o flac -t "%n" "$unsplit_flac"

echo "--- Add tag from clean cue to split tracks ---"
cuetag.sh clean_cue.cue [0-9]*.flac  

echo ---delete clean cue file ---
rm clean_cue.cue