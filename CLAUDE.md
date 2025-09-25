# Claude Instructions

## Course Design Instructions
- Follow the course design principles outlined in instructions.txt
- Refer to instructions.txt for guidance on creating 2025 course materials

## Available Resources
- **book_breakup directory**: Contains textbook materials (Pagano & Gauvreau "Principles of Biostatistics")
  - Student Solutions Manual (readable PDFs)
  - Instructor Solutions Manual (readable PDFs)
  - Main textbook split into parts (large files, use carefully)
- **extracted_content directory**: Contains extracted text from all 2024 PowerPoint presentations
- **Python script for 2024 analysis**: Use `extract_pptx_content.py` to examine PowerPoint files from the 2024 export when direct reading isn't possible

## LaTeX Workflow
- Always recompile when tex updates are made
- Use `pdflatex filename.tex` to compile .tex files to PDF
- Keep compiled PDF in the same directory as the .tex source file (e.g., slides/week1_slides.pdf stays with slides/week1_slides.tex)
- Optionally copy PDF to code/ directory for distribution with R scripts
- Verify compilation was successful and PDF exists in source directory before marking task complete
- When creating new LaTeX files, always compile them immediately after creation

## Homework Assignment Workflow
- When homework assignments are updated, always regenerate the Canvas QTI zip file
- The QTI zip file must reflect the current version of the homework questions
- Update both the markdown assignment and the Canvas import formats

## Course Materials Format
- All course materials should be in LaTeX format, not markdown
- Use the same LaTeX styling and color scheme as the syllabus (OSU orange headers, AI blue for AI-enhanced content)
- Include proper code listings formatting for R code examples

## Ponder Mode
- When the user says "Ponder", don't implement code or change anything
- Instead, think through the request and provide analysis, suggestions, or planning without taking action

## Change Implementation
- When the user asks for a change, implement ONLY that specific change
- Do not make additional modifications or improvements unless explicitly requested

## Worksheet File Management
- **IMPORTANT**: When updating worksheets, always maintain the original filename
- Example: `week0_wednesday_worksheet.tex` should keep the same name even after content updates
- This ensures consistency in file references and course organization
- Only change worksheet filenames if explicitly requested by the user

