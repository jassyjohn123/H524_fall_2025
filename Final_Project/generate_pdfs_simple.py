#!/usr/bin/env python3

import subprocess
import sys
import os

def generate_pdfs():
    """Generate PDFs using pandoc with available engines"""
    
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    pdf_dir = "PDF_Files"
    os.makedirs(pdf_dir, exist_ok=True)
    
    print("=" * 50)
    print("H524 Final Project - PDF Generator (Simple)")
    print("=" * 50)
    print()
    
    markdown_files = [
        ("final_project_guidelines.md", "final_project_guidelines.pdf"),
        ("grading_rubric.md", "grading_rubric.pdf"),
        ("proposal_template.md", "proposal_template.pdf"),
        ("prompt_log_template.md", "prompt_log_template.pdf"),
        ("dataset_suggestions.md", "dataset_suggestions.pdf"),
        ("presentation_signup_sheet.md", "presentation_signup_sheet.pdf"),
    ]
    
    success_count = 0
    failed = []
    
    for md_file, pdf_file in markdown_files:
        if not os.path.exists(md_file):
            print(f"⚠️  Skipping {md_file} (not found)")
            continue
        
        output_path = os.path.join(pdf_dir, pdf_file)
        
        # Try different pandoc engines in order of preference
        engines = [
            None,  # Default
            "wkhtmltopdf",
            "weasyprint",
            "prince",
            "context",
        ]
        
        for engine in engines:
            try:
                cmd = [
                    "pandoc",
                    md_file,
                    "-o", output_path,
                    "-V", "geometry:margin=1in",
                    "-V", "fontsize=11pt",
                    "--standalone"
                ]
                
                if engine:
                    cmd.extend(["--pdf-engine", engine])
                
                # Try with table of contents for guidelines
                if "guidelines" in md_file:
                    cmd.append("--toc")
                
                result = subprocess.run(
                    cmd,
                    capture_output=True,
                    text=True,
                    timeout=30
                )
                
                if result.returncode == 0:
                    print(f"✅ Generated: {pdf_file}")
                    success_count += 1
                    break
                    
            except (subprocess.TimeoutExpired, FileNotFoundError, Exception) as e:
                if engine is None or engine == engines[-1]:
                    print(f"❌ Failed: {pdf_file}")
                    failed.append((md_file, str(e)))
                continue
    
    print()
    print("=" * 50)
    print(f"✅ Successfully generated: {success_count}/{len(markdown_files)} PDFs")
    
    if failed:
        print()
        print("❌ Failed to generate:")
        for fname, error in failed:
            print(f"   - {fname}: {error}")
        print()
        print("💡 Tip: These files can still be read as .md files")
        print("   or converted using online tools like markdowntopdf.com")
    
    print()
    print(f"📁 PDFs saved to: {pdf_dir}/")
    print("=" * 50)

if __name__ == "__main__":
    try:
        generate_pdfs()
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

