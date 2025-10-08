#!/bin/bash

# Script to remove emojis from all markdown and text files

echo "Removing emojis from all files..."

# Find all markdown files and remove common emojis
find . -name "*.md" -type f | while read file; do
    echo "Processing: $file"
    
    # Remove common emojis using sed
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's/🔑//g' "$file"
    sed -i 's/🚨//g' "$file"
    sed -i 's/📝//g' "$file"
    sed -i 's/🌐//g' "$file"
    sed -i 's/📤//g' "$file"
    sed -i 's/🧪//g' "$file"
    sed -i 's/🔗//g' "$file"
    sed -i 's/📦//g' "$file"
    sed -i 's/🌍//g' "$file"
    sed -i 's/🤔//g' "$file"
    
    # Remove any remaining emoji-like patterns
    sed -i 's/[[:space:]]*[🔑🚨📝🌐📤🧪🔗📦🌍🤔][[:space:]]*/ /g' "$file"
    
    # Clean up extra spaces
    sed -i 's/  */ /g' "$file"
done

# Also check shell scripts
find . -name "*.sh" -type f | while read file; do
    echo "Processing: $file"
    
    # Remove emojis from shell scripts
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    sed -i 's///g' "$file"
    
    # Clean up extra spaces in echo statements
    sed -i 's/echo -e "$file"
done

echo "Emoji removal completed!"