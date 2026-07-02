#!/bin/bash

shopt -s nullglob

echo --- Reading files ---
unclean_cue=$(ls *.cue | grep -v '^clean' | head -n 1) 
unsplit_flac=$(ls *.flac | grep -v '^[0-9]' | head -n 1) 

echo --- $unclean_cue --- $unsplit_flac ---

echo --- Cleaning cue ---
grep -E "^\s*(FILE|TRACK|INDEX|TITLE|PERFORMER)" "$unclean_cue" | sed -E 's/:7[5-9]/:74/g' > clean_cue.cue