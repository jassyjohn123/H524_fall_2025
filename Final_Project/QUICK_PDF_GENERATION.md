# 🚀 Quick PDF Generation Guide

## Fastest Method: Install Pandoc + BasicTeX (5 minutes)

### Step 1: Install Pandoc
```bash
brew install pandoc
```

### Step 2: Install BasicTeX (lightweight LaTeX for PDF generation)
```bash
brew install basictex
```

### Step 3: Update PATH and install tlmgr packages
```bash
eval "$(/usr/libexec/path_helper)"
sudo tlmgr update --self
sudo tlmgr install collection-fontsrecommended
```

### Step 4: Run the PDF generator script
```bash
cd /Users/jonah/Documents/H524_fall_2025/H524_fall_2025/Final_Project
./generate_pdfs.sh
```

That's it! All PDFs will be in the `PDF_Files/` folder.

---

## Alternative: Use Overleaf (No installation, 100% online)

1. Go to https://www.overleaf.com (create free account if needed)
2. Click "New Project" → "Upload Project"
3. Upload these two files:
   - `final_project_guidelines.tex`
   - `grading_rubric.tex`
4. Click "Recompile" button
5. Download the PDFs from the right sidebar
6. Save them to `PDF_Files/` folder

For the markdown files (.md), use an online converter:
- Go to https://www.markdowntopdf.com
- Upload each .md file
- Download the PDF

---

## Alternative: Use Python Script (If you prefer)

I can create a Python script that generates PDFs if you'd like. Just let me know!

---

## Which Method Should I Use?

**Recommended:** Install Pandoc (Step 1-4 above)
- ✅ One-time setup
- ✅ Generates all PDFs in seconds
- ✅ Professional formatting
- ✅ Can regenerate anytime

**Quick & Easy:** Use Overleaf
- ✅ No installation needed
- ✅ Works immediately
- ❌ Need to do manually for each file

---

## Need Help?

Run this command and I'll help you with the next step:
```bash
cd /Users/jonah/Documents/H524_fall_2025/H524_fall_2025/Final_Project
./generate_pdfs.sh
```

It will detect what's available and guide you!

