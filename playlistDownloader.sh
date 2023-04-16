#! /bin/bash

# automated playlist downloader using yt-dlp
# downloads videos to a directory without removing existing files as well as writing video names of playlist to a .txt file
# the purpose of writing the .txt file is to compare previous downloads to new downloads and see if any videos have been removed by youtube, etc

# omit <> when filling in links!
# but do not remove ""

# just copy paste the code if you have multiple playlists, different directories and such

set -euo pipefail

start=$(date +%s)

download_dir="your download directory"
destination_dir="the destination directory"

cd "$download_dir"
# omit -x if you do not want only the audio
yt-dlp -x --playlist-start <number> <playlist / video link>

# change the /*.opus in the loop if you want any other types of files

for file in "$download_dir"/*.opus; do
  filename=$(basename "$file")
  if [ -f "$destination_dir/$filename" ]; then
    rm "$file"
  else
    mv "$file" "$destination_dir/"
  fi
done

# write names of music into .txt file

base_output_file="music" # preferably make this the name of your playlist

output_directory="<your output directory>" # where the .txt file will be outputted

counter=1
while true; do
  output_file="${base_output_file}${counter}.txt"
  if [ ! -f "${output_directory}/${output_file}" ]; then
    break
  fi
  ((counter++))
done

cd "$destination_dir"

for file in *
do

  echo "$file" >> "${output_directory}/${output_file}"
done

echo "FINISHED EXECUTING SCRIPT"

end=$(date +%s)
elapsed=$(( end - start ))
printf "Time Taken: %d seconds.\n" "$elapsed"

# you can use this command to write the name of videos in a playlist into a .txt file without an existing directory of downloaded videos
# do not omit the > here:
# yt-dlp --get-title --no-playlist "playlist / video link" > playlist.txt

