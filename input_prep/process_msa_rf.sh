#!/bin/bash

input_file="$1"
backup_file="${input_file}.backup"

# Create a backup of the original file
cp "$input_file" "$backup_file"

# Process the data and store the cleaned version in a temporary file
temp_file="${input_file}.temp"
touch "$temp_file"

dump_file="${input_file}.temp"
touch "$dump_file"

while IFS= read -r line; do
  if [[ $line == \>* ]]; then
    header="$line"
  else
    if [[ $line =~ ^[NUCGAT-]+$ ]]; then
      echo "$header" >> "$temp_file"
      echo "$line" >> "$temp_file"
    else
      echo "$header" >> "$dump_file"
      echo "$line" >> "$dump_file"
    fi
  fi
done < "$backup_file"

# Process the last line
if [[ $line =~ ^[NUCGAT-]+$ ]]; then
  echo "$header" >> "$temp_file"
  echo "$line" >> "$temp_file"
else
  echo "$header" >> "$dump_file"
  echo "$line" >> "$dump_file"
fi

# Move the temporary file back to the original file
mv "$temp_file" "$input_file"