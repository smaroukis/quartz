#!/usr/bin/env bash
# Requires:
# - ./index_base.md
# - Folder path e.g. ../content

# Function to select files based on filter patterns
select_files() {
    # Loop through include filters
    for include_pattern in "${include_filters[@]}"; do
        # Append matching files to the list
        for include_file in $include_pattern; do
            # Check if the file matches any exclude pattern
            excluded=false
            for exclude_pattern in "${exclude_filters[@]}"; do
                if [[ $include_file == $exclude_pattern ]]; then
                    excluded=true
                    break
                fi
            done

            # If not excluded, print the file name
            if [ "$excluded" = false ]; then
                echo "$include_file"
            fi
        done
    done
}

# Define file filtering patterns
include_filters=(
    "*.md"
)
exclude_filters=(
    "README.md"
    "index.md"
)


# Check if the provided path is a directory
if [ ! -d "$CONTENT_DIR" ]; then
    echo "Error: $CONTENT_DIR is not a directory."
    exit 1
fi

# Move into the specified directory
cd "$CONTENT_DIR" || exit

# Initialize an array to store the file names and creation dates
declare -a files

# Call the function to select files based on filter patterns
selected_files=()
while IFS= read -r file; do
    selected_files+=("$file")
done < <(select_files)

# Output the selected filenames
echo "Selected Files:"
for file in "${selected_files[@]}"; do
    echo " * $file"
done

# Loop through the selected files
for file in "${selected_files[@]}"; do
    # Get filename for use in making links
    fname=$(basename "$file" .md)

    front_matter=$(awk '/^---$/ && ++c==1 {next} /^---$/ && c==2 {exit} c' "$file")
    # Extract from frontmatter
    if [[ "$front_matter" =~ draft:\ ?true ]]; then
        echo $'\n'+" Skipping '$fname' (draft)"
        continue
    fi 
    date=$(echo "$front_matter" | grep "date:" | awk '{print $2}')
    title=$(echo "$front_matter" | grep "title:" | cut -d ':' -f 2- | sed 's/^[[:space:]]*//')
    
    # Store the file name and creation date in the array
    files+=("$date [[$fname]]")

    # Print the front matter for inspection
    # echo "Front Matter for $file:"
    # echo "$front_matter"
    # echo ""
done

# Sort the array by creation date in descending order
IFS=$'\n' sorted=($(sort -r <<<"${files[*]}"))

# Read the contents of index_base.md from the script directory
base_content=$(<"$SCRIPT_DIR/index_base.md")
base_content+=$'\n\n'

# Append the sorted titles to the base content
for item in "${sorted[@]}"; do
    base_content+="$item"$'\n\n'
done

# Write the final content to index.md in the provided directory
echo "$base_content" > "$CONTENT_DIR/index.md"
echo "Index.md has been created with the titles of .md files in $CONTENT_DIR"

# Return to the original directory where the script was run from
cd "$SCRIPT_DIR" || exit
