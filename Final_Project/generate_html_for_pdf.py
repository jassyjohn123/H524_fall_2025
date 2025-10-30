#!/usr/bin/env python3

import subprocess
import os

def generate_html_pdfs():
    """Generate HTML files that can be printed to PDF in any browser"""
    
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    pdf_dir = "PDF_Files"
    os.makedirs(pdf_dir, exist_ok=True)
    
    print("=" * 60)
    print("H524 Final Project - Generating Print-Ready HTML Files")
    print("=" * 60)
    print()
    
    markdown_files = [
        ("final_project_guidelines.md", "final_project_guidelines.html"),
        ("grading_rubric.md", "grading_rubric.html"),
        ("proposal_template.md", "proposal_template.html"),
        ("prompt_log_template.md", "prompt_log_template.html"),
        ("dataset_suggestions.md", "dataset_suggestions.html"),
        ("presentation_signup_sheet.md", "presentation_signup_sheet.html"),
    ]
    
   # CSS for professional PDF printing
    css_style = """
<style>
    @media print {
        @page { margin: 1in; }
        body { font-family: 'Arial', 'Helvetica', sans-serif; font-size: 11pt; line-height: 1.6; }
    }
    body {
        max-width: 8.5in;
        margin: 0 auto;
        padding: 1in;
        font-family: 'Arial', 'Helvetica', sans-serif;
        font-size: 11pt;
        line-height: 1.6;
        color: #333;
    }
    h1 { color: #2c3e50; border-bottom: 3px solid #3498db; padding-bottom: 10px; }
    h2 { color: #34495e; border-bottom: 2px solid #bdc3c7; padding-bottom: 8px; margin-top: 30px; }
    h3 { color: #7f8c8d; margin-top: 20px; }
    table { border-collapse: collapse; width: 100%; margin: 20px 0; }
    th, td { border: 1px solid #bdc3c7; padding: 10px; text-align: left; }
    th { background-color: #3498db; color: white; font-weight: bold; }
    tr:nth-child(even) { background-color: #ecf0f1; }
    code { background-color: #f4f4f4; padding: 2px 6px; border-radius: 3px; font-family: 'Courier New', monospace; }
    pre { background-color: #f4f4f4; padding: 15px; border-radius: 5px; overflow-x: auto; }
    pre code { background: none; padding: 0; }
    ul, ol { margin: 15px 0; padding-left: 30px; }
    li { margin: 8px 0; }
    blockquote { border-left: 4px solid #3498db; padding-left: 20px; margin: 20px 0; color: #7f8c8d; }
    a { color: #3498db; text-decoration: none; }
    a:hover { text-decoration: underline; }
    hr { border: none; border-top: 2px solid #bdc3c7; margin: 30px 0; }
    .print-button { 
        background-color: #3498db; 
        color: white; 
        padding: 10px 20px; 
        border: none; 
        border-radius: 5px; 
        cursor: pointer; 
        font-size: 14pt;
        margin: 20px 0;
    }
    .print-button:hover { background-color: #2980b9; }
    @media print { .print-button, .no-print { display: none; } }
</style>
"""
    
    success_count = 0
    
    for md_file, html_file in markdown_files:
        if not os.path.exists(md_file):
            print(f"⚠️  Skipping {md_file} (not found)")
            continue
        
        output_path = os.path.join(pdf_dir, html_file)
        
        try:
            # Generate HTML with pandoc
            cmd = [
                "pandoc",
                md_file,
                "-o", output_path,
                "--standalone",
                "--self-contained",
                "-H", "-",  # Read CSS from stdin
            ]
            
            # Add table of contents for guidelines
            if "guidelines" in md_file:
                cmd.append("--toc")
            
            result = subprocess.run(
                cmd,
                input=css_style,
                capture_output=True,
                text=True,
                timeout=30
            )
            
            if result.returncode == 0:
                # Add print button at the top
                with open(output_path, 'r') as f:
                    content = f.read()
                
                print_instructions = f"""
<div class="no-print" style="background: #e8f4f8; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
    <h2 style="margin-top: 0; color: #2c3e50;">📄 Convert to PDF</h2>
    <p><strong>To save as PDF:</strong></p>
    <ol>
        <li>Click the "Print to PDF" button below (or press Ctrl+P / Cmd+P)</li>
        <li>Select "Save as PDF" as the printer/destination</li>
        <li>Click "Save" and choose your location</li>
    </ol>
    <button class="print-button" onclick="window.print()">🖨️ Print to PDF</button>
</div>
"""
                
                # Insert instructions after <body>
                content = content.replace('<body>', '<body>' + print_instructions, 1)
                
                with open(output_path, 'w') as f:
                    f.write(content)
                
                print(f"✅ Generated: {html_file}")
                success_count += 1
            else:
                print(f"❌ Failed: {html_file} - {result.stderr}")
                
        except Exception as e:
            print(f"❌ Failed: {html_file} - {str(e)}")
    
    print()
    print("=" * 60)
    print(f"✅ Successfully generated: {success_count}/{len(markdown_files)} HTML files")
    print()
    print("📝 TO CREATE PDFs:")
    print("   1. Open any .html file in your web browser")
    print("   2. Click the 'Print to PDF' button")
    print("   3. Save as PDF")
    print()
    print(f"📁 HTML files saved to: {pdf_dir}/")
    print("=" * 60)

if __name__ == "__main__":
    try:
        generate_html_pdfs()
    except Exception as e:
        print(f"Error: {e}")

