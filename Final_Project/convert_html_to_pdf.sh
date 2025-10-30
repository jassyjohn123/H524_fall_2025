#!/bin/bash

echo "=========================================="
echo "Converting HTML files to PDF..."
echo "=========================================="
echo ""

cd "$(dirname "$0")/PDF_Files"

# Method 1: Try using wkhtmltopdf if available
if command -v wkhtmltopdf &> /dev/null; then
    echo "Using wkhtmltopdf..."
    for html in *.html; do
        if [ -f "$html" ]; then
            pdf="${html%.html}.pdf"
            wkhtmltopdf --enable-local-file-access --print-media-type "$html" "$pdf" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo "✅ Created: $pdf"
            fi
        fi
    done
# Method 2: Try using Chrome/Chromium headless
elif command -v "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" &> /dev/null; then
    echo "Using Google Chrome..."
    for html in *.html; do
        if [ -f "$html" ]; then
            pdf="${html%.html}.pdf"
            "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
                --headless \
                --disable-gpu \
                --print-to-pdf="$pdf" \
                --print-to-pdf-no-header \
                "file://$(pwd)/$html" 2>/dev/null
            if [ -f "$pdf" ]; then
                echo "✅ Created: $pdf"
            fi
        fi
    done
else
    echo "❌ No automatic PDF converter found."
    echo ""
    echo "📋 EASY MANUAL METHOD:"
    echo "   1. The HTML files are already open or in: $(pwd)"
    echo "   2. For EACH .html file:"
    echo "      - Double-click to open in browser"
    echo "      - Click the blue 'Print/Save as PDF' button"
    echo "      - Or press Cmd+P → Save as PDF"
    echo "      - Save in this same folder"
    echo ""
    echo "💡 AUTOMATED OPTION:"
    echo "   Install wkhtmltopdf: brew install wkhtmltopdf"
    echo "   Then run this script again"
fi

echo ""
echo "=========================================="
echo "Done! Check PDF_Files folder for PDFs"
echo "=========================================="

