#!/bin/bash

echo "=========================================="
echo "H524 Final Project - PDF Generator"
echo "=========================================="
echo ""

cd "$(dirname "$0")"

PDF_DIR="PDF_Files"
mkdir -p "$PDF_DIR"

echo "Checking for available PDF generation tools..."
echo ""

if command -v pandoc &> /dev/null; then
    echo "✅ Pandoc found! Generating PDFs from Markdown files..."
    echo ""
    
    pandoc final_project_guidelines.md -o "$PDF_DIR/final_project_guidelines.pdf" \
        --pdf-engine=xelatex \
        -V geometry:margin=1in \
        -V fontsize=11pt \
        --toc \
        && echo "✅ Generated: final_project_guidelines.pdf"
    
    pandoc grading_rubric.md -o "$PDF_DIR/grading_rubric.pdf" \
        --pdf-engine=xelatex \
        -V geometry:margin=0.75in \
        -V fontsize=11pt \
        && echo "✅ Generated: grading_rubric.pdf"
    
    pandoc proposal_template.md -o "$PDF_DIR/proposal_template.pdf" \
        --pdf-engine=xelatex \
        -V geometry:margin=1in \
        && echo "✅ Generated: proposal_template.pdf"
    
    pandoc prompt_log_template.md -o "$PDF_DIR/prompt_log_template.pdf" \
        --pdf-engine=xelatex \
        -V geometry:margin=1in \
        && echo "✅ Generated: prompt_log_template.pdf"
    
    pandoc dataset_suggestions.md -o "$PDF_DIR/dataset_suggestions.pdf" \
        --pdf-engine=xelatex \
        -V geometry:margin=1in \
        && echo "✅ Generated: dataset_suggestions.pdf"
    
    pandoc presentation_signup_sheet.md -o "$PDF_DIR/presentation_signup_sheet.pdf" \
        --pdf-engine=xelatex \
        -V geometry:margin=1in \
        && echo "✅ Generated: presentation_signup_sheet.pdf"
    
    echo ""
    echo "✅ All PDFs generated successfully in $PDF_DIR/"
    
elif command -v pdflatex &> /dev/null; then
    echo "✅ pdflatex found! Generating PDFs from LaTeX files..."
    echo ""
    
    pdflatex -output-directory="$PDF_DIR" final_project_guidelines.tex && \
        echo "✅ Generated: final_project_guidelines.pdf"
    
    pdflatex -output-directory="$PDF_DIR" grading_rubric.tex && \
        echo "✅ Generated: grading_rubric.pdf"
    
    cd "$PDF_DIR"
    rm -f *.aux *.log *.out
    cd ..
    
    echo ""
    echo "✅ PDFs generated from LaTeX files in $PDF_DIR/"
    echo "⚠️  Note: Markdown templates not converted (need pandoc for those)"
    
else
    echo "❌ No PDF generation tools found (pandoc or pdflatex)"
    echo ""
    echo "📋 Options to generate PDFs:"
    echo ""
    echo "Option 1: Install Pandoc (recommended)"
    echo "  macOS: brew install pandoc"
    echo "  Then also: brew install basictex (for xelatex)"
    echo ""
    echo "Option 2: Use Overleaf (online, free)"
    echo "  1. Go to https://www.overleaf.com"
    echo "  2. Upload .tex files"
    echo "  3. Download generated PDFs"
    echo ""
    echo "Option 3: Use online Markdown to PDF converter"
    echo "  - https://www.markdowntopdf.com"
    echo "  - https://md2pdf.netlify.app"
    echo ""
    echo "Option 4: Use VS Code with 'Markdown PDF' extension"
    echo ""
    echo "See PDF_Files/README.md for detailed instructions"
fi

echo ""
echo "=========================================="

