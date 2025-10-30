# PDF Files for Students

This folder contains PDF versions of all project materials for easy access and printing.

## ✅ Available PDFs (Ready to Use!)

All PDFs are professionally formatted and ready for students:

- ✅ **final_project_guidelines.pdf** (358K) - Complete project guidelines
- ✅ **grading_rubric.pdf** (298K) - Detailed grading rubric  
- ✅ **proposal_template.pdf** (131K) - Proposal template
- ✅ **prompt_log_template.pdf** (229K) - AI prompt log template
- ✅ **dataset_suggestions.pdf** (379K) - Dataset recommendations
- ✅ **presentation_signup_sheet.pdf** (210K) - Presentation signup sheet

**Total: 6 PDFs, all professionally formatted and print-ready!**

## How to Generate PDFs

### Option 1: Use Overleaf (Easiest - Free Online)

1. Go to https://www.overleaf.com (free account)
2. Create a new project and upload the .tex files from parent folder
3. Click "Recompile" - PDFs generate automatically
4. Download PDFs and place them here

### Option 2: Use Markdown to PDF Online Converters

For the .md files:
1. Go to https://www.markdowntopdf.com or https://md2pdf.netlify.app
2. Upload or paste the .md file content
3. Download the generated PDF
4. Save to this folder

### Option 3: Use VS Code or Cursor (If you have it)

1. Install "Markdown PDF" extension
2. Open any .md file
3. Right-click → "Markdown PDF: Export (pdf)"
4. PDF saves automatically

### Option 4: Use Pandoc (If installed)

```bash
cd Final_Project
pandoc final_project_guidelines.md -o PDF_Files/final_project_guidelines.pdf
pandoc grading_rubric.md -o PDF_Files/grading_rubric.pdf
pandoc proposal_template.md -o PDF_Files/proposal_template.pdf
pandoc prompt_log_template.md -o PDF_Files/prompt_log_template.pdf
pandoc dataset_suggestions.md -o PDF_Files/dataset_suggestions.pdf
pandoc presentation_signup_sheet.md -o PDF_Files/presentation_signup_sheet.pdf
```

## For Students

📚 **All PDFs are ready!** Simply download and use them for your project.

If you prefer other formats:
- **Markdown files** (.md) - Available in parent folder, readable in any text editor
- **HTML files** (.html) - Also in this folder, can be opened in any web browser

All formats contain identical content!

## Regenerating PDFs (For Instructors)

If you need to regenerate the PDFs after making changes:

```bash
cd /Users/jonah/Documents/H524_fall_2025/H524_fall_2025/Final_Project
python3 generate_pdfs_final.py
./convert_html_to_pdf.sh
```

This will create fresh HTML files and convert them to PDFs automatically.

