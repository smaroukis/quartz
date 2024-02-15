#!/bin/bash

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

# --------- MAIN -----------

main() {
CONTENT_DIR='../content'
cd "$CONTENT_DIR" || exit

# Call the function to select files based on filter patterns
selected_files=()
while IFS= read -r file; do
    selected_files+=("$file")
done < <(select_files)

# Output the selected files
echo "Selected Files:"
for file in "${selected_files[@]}"; do
    echo " * $file"
done
}