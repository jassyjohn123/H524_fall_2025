#!/bin/bash

# Script to split PDF files in the book directory

BOOK_DIR="book"
SPLIT_DIR="book/split"

# Create split directory if it doesn't exist
mkdir -p "$SPLIT_DIR"

echo "Splitting PDF files in $BOOK_DIR directory..."

# Split each PDF file
for pdf_file in "$BOOK_DIR"/*.pdf; do
    if [ -f "$pdf_file" ]; then
        echo "Processing: $(basename "$pdf_file")"
        python3 split_pdf.py "$pdf_file" --pages 50 --output "$SPLIT_DIR"
        echo "---"
    fi
done

echo "All PDF files have been processed. Split files are in: $SPLIT_DIR"