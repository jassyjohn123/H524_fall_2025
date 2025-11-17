#!/usr/bin/env python3
"""
Remove all AI-related content from group project guidelines.
"""

import re

def clean_group_project_guidelines():
    filepath = "Group_project/docs/group_project_guidelines.tex"

    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Change the subtitle
    content = content.replace(
        r"\Large AI-Enhanced Public Health Data Analysis Project\\",
        r"\Large Public Health Data Analysis Project\\"
    )

    # Remove AI mentions from project overview
    content = content.replace(
        "This project replaces traditional final exams and demonstrates effective integration of AI tools throughout the research process while maintaining scientific rigor and reproducibility.",
        "This project replaces traditional final exams and demonstrates biostatistical analysis skills while maintaining scientific rigor and reproducibility."
    )

    # Remove AI-related bullet points from Parts 1-3
    ai_bullets_to_remove = [
        r"\\item Conduct literature review using AI-assisted search strategies\n",
        r"\\item Document AI tool usage for literature synthesis\n",
        r"\\item Data cleaning and preprocessing with AI assistance\n",
        r"\\item Document all AI-generated code with verification steps\n",
        r"\\item Use AI to explore alternative analytical approaches\n",
        r"\\item Validate all AI-suggested methods against course materials\n",
    ]

    for bullet in ai_bullets_to_remove:
        content = re.sub(bullet, '', content)

    # Remove Part 4: AI Integration section entirely
    part4_pattern = r'\\subsection\{Part 4: AI Integration and Documentation \(20\\%\)\}.*?(?=\\subsection\{Part 5:|\\section\{)'
    content = re.sub(part4_pattern, '', content, flags=re.DOTALL)

    # Rename Part 5 to Part 4
    content = content.replace(
        r"\subsection{Part 5: Final Presentation and Communication (10\%)}",
        r"\subsection{Part 4: Final Presentation and Communication (10\%)}"
    )

    # Remove AI from proposal timeline
    content = re.sub(r"\\item Anticipated AI tools and usage\n", '', content)

    # Remove AI documentation from deliverables
    content = re.sub(r"\\item AI usage documentation appendix\n", '', content)

    # Remove AI from individual reflection
    content = content.replace(
        r"\item Individual reflection on learning and AI tool usage (1 page per student)",
        r"\item Individual reflection on learning (1 page per student)"
    )

    # Remove entire AI Usage Requirements section
    ai_section_pattern = r'\\section\{AI Usage Requirements\}.*?(?=\\section\{|\\end\{document\})'
    content = re.sub(ai_section_pattern, '', content, flags=re.DOTALL)

    # Update grading weights (redistribute the 20% from AI)
    # Assume it should go to other parts - this may need manual adjustment
    # For now, let's just remove references

    # Write back
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"Cleaned {filepath}")
    print("Note: You may need to manually adjust grading weights in the rubric")

if __name__ == "__main__":
    clean_group_project_guidelines()
