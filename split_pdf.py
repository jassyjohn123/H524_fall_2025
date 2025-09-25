#!/usr/bin/env python3
"""
PDF Splitter Script
Splits large PDF files into smaller subfiles with a specified number of pages per file.
"""

import os
import sys
import argparse
from PyPDF2 import PdfReader, PdfWriter

def split_pdf(input_path, pages_per_file=50, output_dir=None):
    """
    Split a PDF file into smaller files.

    Args:
        input_path (str): Path to the input PDF file
        pages_per_file (int): Number of pages per output file
        output_dir (str): Directory to save split files (defaults to same as input)
    """
    if not os.path.exists(input_path):
        print(f"Error: File '{input_path}' not found.")
        return False

    # Setup output directory
    if output_dir is None:
        output_dir = os.path.dirname(input_path)
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Get base filename without extension
    base_name = os.path.splitext(os.path.basename(input_path))[0]

    try:
        # Read the PDF
        reader = PdfReader(input_path)
        total_pages = len(reader.pages)

        print(f"Processing '{input_path}' with {total_pages} pages...")
        print(f"Splitting into files with {pages_per_file} pages each...")

        # Calculate number of output files needed
        num_files = (total_pages + pages_per_file - 1) // pages_per_file

        for file_num in range(num_files):
            writer = PdfWriter()

            # Calculate page range for this file
            start_page = file_num * pages_per_file
            end_page = min(start_page + pages_per_file, total_pages)

            # Add pages to writer
            for page_num in range(start_page, end_page):
                writer.add_page(reader.pages[page_num])

            # Create output filename
            output_filename = f"{base_name}_part_{file_num + 1:03d}_pages_{start_page + 1}-{end_page}.pdf"
            output_path = os.path.join(output_dir, output_filename)

            # Write the file
            with open(output_path, 'wb') as output_file:
                writer.write(output_file)

            print(f"Created: {output_filename} (pages {start_page + 1}-{end_page})")

        print(f"\nSuccessfully split PDF into {num_files} files.")
        return True

    except Exception as e:
        print(f"Error processing PDF: {str(e)}")
        return False

def main():
    parser = argparse.ArgumentParser(description='Split large PDF files into smaller subfiles')
    parser.add_argument('input_file', help='Path to the input PDF file')
    parser.add_argument('-p', '--pages', type=int, default=50,
                       help='Number of pages per output file (default: 50)')
    parser.add_argument('-o', '--output',
                       help='Output directory (default: same as input file)')

    args = parser.parse_args()

    success = split_pdf(args.input_file, args.pages, args.output)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()