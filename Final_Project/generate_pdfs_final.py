#!/usr/bin/env python3

import subprocess
import os

def generate_html_files():
    """Generate HTML files that can be printed to PDF"""
    
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    pdf_dir = "PDF_Files"
    os.makedirs(pdf_dir, exist_ok=True)
    
    print("=" * 60)
    print("H524 Final Project - Generating Print-Ready HTML Files")
    print("=" * 60)
    print()
    
    markdown_files = [
        ("final_project_guidelines.md", "final_project_guidelines"),
        ("grading_rubric.md", "grading_rubric"),
        ("proposal_template.md", "proposal_template"),
        ("prompt_log_template.md", "prompt_log_template"),
        ("dataset_suggestions.md", "dataset_suggestions"),
        ("presentation_signup_sheet.md", "presentation_signup_sheet"),
    ]
    
    success_count = 0
    
    for md_file, base_name in markdown_files:
        if not os.path.exists(md_file):
            print(f"⚠️  Skipping {md_file} (not found)")
            continue
        
        html_path = os.path.join(pdf_dir, f"{base_name}.html")
        
        try:
            # Generate standalone HTML with pandoc
            cmd = [
                "pandoc",
                md_file,
                "-o", html_path,
                "--standalone",
                "--embed-resources",
                "-c", "-",  # Use CSS from stdin
            ]
            
            # Add table of contents for guidelines
            if "guidelines" in md_file:
                cmd.extend(["--toc", "--toc-depth=2"])
            
            # Professional CSS for PDF printing
            css = """
body {
    max-width: 8.5in;
    margin: 0 auto;
    padding: 0.5in;
    font-family: Arial, Helvetica, sans-serif;
    font-size: 11pt;
    line-height: 1.6;
    color: #333;
}
h1 {
    color: #2c3e50;
    border-bottom: 3px solid #3498db;
    padding-bottom: 10px;
    font-size: 24pt;
}
h2 {
    color: #34495e;
    border-bottom: 2px solid #bdc3c7;
    padding-bottom: 8px;
    margin-top: 30px;
    font-size: 18pt;
}
h3 {
    color: #7f8c8d;
    margin-top: 20px;
    font-size: 14pt;
}
table {
    border-collapse: collapse;
    width: 100%;
    margin: 20px 0;
    font-size: 10pt;
}
th, td {
    border: 1px solid #bdc3c7;
    padding: 8px;
    text-align: left;
}
th {
    background-color: #3498db;
    color: white;
    font-weight: bold;
}
tr:nth-child(even) {
    background-color: #ecf0f1;
}
code {
    background-color: #f4f4f4;
    padding: 2px 6px;
    border-radius: 3px;
    font-family: 'Courier New', monospace;
    font-size: 10pt;
}
pre {
    background-color: #f4f4f4;
    padding: 15px;
    border-radius: 5px;
    overflow-x: auto;
}
ul, ol {
    margin: 15px 0;
    padding-left: 30px;
}
li {
    margin: 8px 0;
}
a {
    color: #3498db;
}
hr {
    border: none;
    border-top: 2px solid #bdc3c7;
    margin: 30px 0;
}
@media print {
    @page {
        margin: 0.75in;
    }
    body {
        padding: 0;
    }
    .no-print {
        display: none;
    }
}
.print-button {
    background-color: #3498db;
    color: white;
    padding: 12px 24px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14pt;
    margin: 20px 0;
}
.print-button:hover {
    background-color: #2980b9;
}
"""
            
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=30
            )
            
            if result.returncode == 0:
                # Read the generated HTML
                with open(html_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Add print instructions and button
                print_section = '''
<div class="no-print" style="background: #e8f4f8; padding: 20px; border-radius: 5px; margin: 20px 0; border-left: 4px solid #3498db;">
    <h2 style="margin-top: 0; color: #2c3e50;">📄 Save as PDF</h2>
    <p><strong>To create a PDF from this document:</strong></p>
    <ol style="margin: 10px 0;">
        <li>Click the button below (or press <kbd>Ctrl+P</kbd> / <kbd>Cmd+P</kbd>)</li>
        <li>Select "Save as PDF" or "Print to PDF"</li>
        <li>Click "Save" and choose your location</li>
    </ol>
    <button class="print-button" onclick="window.print()">🖨️ Print/Save as PDF</button>
    <p style="font-size: 10pt; color: #7f8c8d; margin-top: 15px;">
        <em>The print instructions will not appear in the PDF.</em>
    </p>
</div>
'''
                
                # Inject CSS
                if '<style>' in content:
                    content = content.replace('</style>', css + '</style>', 1)
                elif '</head>' in content:
                    content = content.replace('</head>', f'<style>{css}</style></head>', 1)
                
                # Insert print section after first heading or at start of body
                if '<h1' in content:
                    content = content.replace('<h1', print_section + '<h1', 1)
                elif '<body>' in content:
                    content = content.replace('<body>', '<body>' + print_section, 1)
                
                # Write back
                with open(html_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                print(f"✅ Generated: {base_name}.html")
                success_count += 1
            else:
                print(f"❌ Failed: {base_name} - {result.stderr[:100]}")
                
        except Exception as e:
            print(f"❌ Failed: {base_name} - {str(e)}")
    
    print()
    print("=" * 60)
    print(f"✅ Successfully generated: {success_count}/{len(markdown_files)} HTML files")
    print()
    print("📝 NEXT STEPS TO CREATE PDFs:")
    print(f"   1. Open {pdf_dir}/ folder")
    print("   2. Double-click any .html file (opens in browser)")
    print("   3. Click 'Print/Save as PDF' button in the page")
    print("   4. Save as PDF in the same folder")
    print()
    print("💡 TIP: All HTML files are printer-friendly and will")
    print("   create professional-looking PDFs automatically!")
    print()
    print(f"📁 Files location: {os.path.abspath(pdf_dir)}/")
    print("=" * 60)

if __name__ == "__main__":
    try:
        generate_html_files()
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()

