#! /bin/bash

# automated playlist downloader using yt-dlp
# downloads videos to a directory without removing existing files as well as writing video names of playlist to a .txt file
# the purpose of writing the .txt file is to compare previous downloads to new downloads and see if any videos have been removed by youtube, etc

set -euo pipefail

start=$(date +%s)

download_dir="your download directory"
playlist_dir="your playlist directory"

cd "$download_dir"
yt-dlp -x --playlist-start 1 "playlist link"

rsync -av --remove-source-files "$download_dir/" "$playlist_dir/"

# write names for playlist to .txt file

outputted_file_name="playlist"

output_directory="your output directory"

counter=1
while true; do
  output_file="${base_output_file}${counter}.txt"
  if [ ! -f "${output_directory}/${output_file}" ]; then
    break
  fi
  ((counter++))
done

cd "$playlist_dir"

for file in *
do

  echo "$file" >> "${output_directory}/${output_file}"
done

echo "FINISHED EXECUTING SCRIPT"

end=$(date +%s)
elapsed=$(( end - start ))
printf "Time Taken: %d seconds.\n" "$elapsed"
printf "Time Taken: %.1f minutes.\n" $(echo "$elapsed / 60" | bc -l)

# you can use this command to write the name of videos in a playlist into a .txt file without an existing directory of downloaded videos:
# yt-dlp --get-title --no-playlist "playlist / video link" > playlist.txt

