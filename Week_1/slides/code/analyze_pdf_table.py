#!/usr/bin/env python3
"""
PDF Table Analysis Script
Analyzes the table structure in Exercise 2.1 of the worksheet PDF
"""

import sys
import fitz  # PyMuPDF
import pandas as pd
from typing import List, Dict, Any

def analyze_pdf_table(pdf_path: str) -> None:
    """
    Analyze the PDF file and extract table information from Exercise 2.1
    """
    try:
        # Open the PDF
        doc = fitz.open(pdf_path)
        print(f"PDF opened successfully. Total pages: {doc.page_count}")

        # Look for Exercise 2.1 - likely on page 2 (index 1)
        target_pages = [1, 2] if doc.page_count > 2 else [0, 1]

        for page_num in target_pages:
            if page_num >= doc.page_count:
                continue

            page = doc[page_num]
            print(f"\n=== ANALYZING PAGE {page_num + 1} ===")

            # Extract text to find Exercise 2.1
            text = page.get_text()
            if "Exercise 2.1" in text or "2.1" in text:
                print("Found Exercise 2.1 on this page!")

                # Extract text blocks for detailed analysis
                text_blocks = page.get_text("dict")

                # Look for table-related content
                print("\n--- TEXT CONTENT ANALYSIS ---")
                lines = text.split('\n')
                for i, line in enumerate(lines):
                    if any(keyword in line.lower() for keyword in ['variable', 'type', 'reasoning', 'table']):
                        print(f"Line {i}: {line.strip()}")

                # Try to extract tables using PyMuPDF's table detection
                print("\n--- TABLE DETECTION ---")
                try:
                    tables = page.find_tables()
                    print(f"Found {len(tables)} tables on page {page_num + 1}")

                    for table_idx, table in enumerate(tables):
                        print(f"\nTable {table_idx + 1}:")
                        print(f"  Bounding box: {table.bbox}")
                        print(f"  Rows: {table.row_count}, Columns: {table.col_count}")

                        # Extract table data
                        try:
                            table_data = table.extract()
                            print("  Table content:")
                            for row_idx, row in enumerate(table_data):
                                print(f"    Row {row_idx}: {row}")
                        except Exception as e:
                            print(f"  Error extracting table data: {e}")

                except Exception as e:
                    print(f"Error with table detection: {e}")

                # Analyze drawing objects (lines, rectangles) for table structure
                print("\n--- DRAWING OBJECTS ANALYSIS ---")
                drawings = page.get_drawings()
                print(f"Found {len(drawings)} drawing objects")

                # Filter for horizontal and vertical lines that might be table borders
                horizontal_lines = []
                vertical_lines = []
                rectangles = []

                for drawing in drawings:
                    for item in drawing["items"]:
                        if item[0] == "l":  # line
                            x1, y1, x2, y2 = item[1:5]
                            if abs(y1 - y2) < 1:  # horizontal line
                                horizontal_lines.append((x1, y1, x2, y2))
                            elif abs(x1 - x2) < 1:  # vertical line
                                vertical_lines.append((x1, y1, x2, y2))
                        elif item[0] == "re":  # rectangle
                            rectangles.append(item[1:5])

                print(f"  Horizontal lines: {len(horizontal_lines)}")
                print(f"  Vertical lines: {len(vertical_lines)}")
                print(f"  Rectangles: {len(rectangles)}")

                # Analyze line coordinates for potential table issues
                if horizontal_lines or vertical_lines:
                    print("\n--- LINE COORDINATE ANALYSIS ---")

                    if horizontal_lines:
                        print("Horizontal lines (x1, y1, x2, y2):")
                        for i, line in enumerate(horizontal_lines[:10]):  # Show first 10
                            print(f"  {i+1}: {line}")
                            # Check if line spans full width
                            line_width = abs(line[2] - line[0])
                            print(f"      Width: {line_width:.2f}")

                    if vertical_lines:
                        print("Vertical lines (x1, y1, x2, y2):")
                        for i, line in enumerate(vertical_lines[:10]):  # Show first 10
                            print(f"  {i+1}: {line}")
                            # Check if line spans full height
                            line_height = abs(line[3] - line[1])
                            print(f"      Height: {line_height:.2f}")

                # Get page dimensions for comparison
                page_rect = page.rect
                print(f"\nPage dimensions: {page_rect.width} x {page_rect.height}")

        doc.close()

    except Exception as e:
        print(f"Error analyzing PDF: {e}")
        return

def main():
    pdf_path = "/Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025/Week_1/worksheets/week0_wednesday_worksheet.pdf"

    print("PDF Table Structure Analysis")
    print("=" * 50)

    analyze_pdf_table(pdf_path)

if __name__ == "__main__":
    main()