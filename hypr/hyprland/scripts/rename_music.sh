
echo --- Reading files ---
unclean_cue=$(ls *.cue | grep -v '^clean' | head -n 1) 
unsplit_flac=$(ls *.flac | grep -v '^[0-9]' | head -n 1) 

echo --- $unclean_cue --- $unsplit_flac ---
