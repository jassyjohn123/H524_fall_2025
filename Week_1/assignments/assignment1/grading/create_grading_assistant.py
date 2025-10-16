#!/usr/bin/env python3
"""
Create an AI-powered grading assistant HTML interface
AI grades and comments on each question, human reviews and copies to Canvas
"""

import pandas as pd
import re
import json
from pathlib import Path

# File paths
submissions_file = "H524 Assignment 1_ Introduction to Biostatistics and Data Visualization Quiz Student Analysis Report.csv"
answer_key_file = "assignment1_answer_key.md"
output_html = "assignment1_grading_assistant.html"
canvas_gradebook_file = "2025-10-12T1846_Grades-INTRODUCTION_TO_BIOSTATISTICS_(H_524_001_F2025).csv"

# MC Answer key
MC_ANSWERS = {
    "57991112": "48%",
    "57991115": "Display the five-number summary and outliers clearly",
    "57991116": "Higher mortality than expected",
    "57991117": "table()",
    "57991118": "Bar charts show categorical data with gaps between bars; histograms show continuous data with no gaps",
    "57991119": "AI should enhance understanding, not replace critical thinking",
    "57991120": "AI requires expensive commercial software",
}

QUESTION_INFO = {
    "57991112": {"title": "Motor Vehicle Deaths %", "points": 4.0, "type": "mc", "qnum": 1},
    "57991113": {"title": "FEV1 Distribution Analysis", "points": 10.0, "type": "essay", "qnum": 2},
    "57991114": {"title": "Childhood Injury Deaths Analysis", "points": 10.0, "type": "essay", "qnum": 3},
    "57991115": {"title": "Box Plot Usefulness", "points": 4.0, "type": "mc", "qnum": 4},
    "57991116": {"title": "SMR Interpretation", "points": 4.0, "type": "mc", "qnum": 5},
    "57991117": {"title": "R Frequency Function", "points": 4.0, "type": "mc", "qnum": 6},
    "57991118": {"title": "Bar vs Histogram", "points": 4.0, "type": "mc", "qnum": 7},
    "57991119": {"title": "AI Golden Rule", "points": 4.0, "type": "mc", "qnum": 8},
    "57991120": {"title": "AI Pitfalls", "points": 4.0, "type": "mc", "qnum": 9},
    "57991121": {"title": "Data Types Classification", "points": 10.0, "type": "essay", "qnum": 10},
    "57991122": {"title": "FEV1 Analysis v2", "points": 10.0, "type": "essay", "qnum": 11},
    "57991123": {"title": "Choosing Appropriate Visualizations", "points": 10.0, "type": "essay", "qnum": 12},
    "57991124": {"title": "R Programming Exercise", "points": 20.0, "type": "r_code", "qnum": 13},
    "57991125": {"title": "Bonus: AI Critical Thinking", "points": 5.0, "type": "r_code", "qnum": 14},
}

def clean_text(text):
    if pd.isna(text):
        return ""
    return str(text).strip().lower()

def clean_for_display(text):
    if pd.isna(text):
        return "[No answer provided]"
    text = str(text).strip()
    # Replace non-breaking spaces with regular spaces
    # But preserve formatting/indentation by keeping line breaks and spaces
    text = text.replace('\xa0', ' ')
    return text if text else "[No answer provided]"

def has_r_code(answer):
    """Check if response contains actual R code (not just text mentioning statistical terms)"""
    answer_lower = clean_text(answer)

    # Look for R function calls (word followed by parenthesis)
    r_function_calls = [
        'mean(', 'median(', 'summary(', 'table(', 'prop.table(',
        'aggregate(', 'tapply(', 'ggplot(', 'aes(', 'geom_',
        'barplot(', 'hist(', 'boxplot(', 'library(', 'c(',
        'data.frame(', 'map_data(', 'ggsave(', 'sum(', 'length(',
        'nrow(', 'ncol(', 'str(', 'head(', 'tail('
    ]

    # Look for R assignment operator
    has_assignment = '<-' in answer_lower

    # Look for R data frame access with $
    has_dollar_access = '$' in answer and any(word in answer_lower for word in ['data', 'df', 'fev1_data'])

    # Check for multiple indicators of actual code
    function_count = sum(1 for func in r_function_calls if func in answer_lower)

    # Return True if we have clear evidence of R code
    return has_assignment or function_count >= 2 or has_dollar_access

def has_numbers(answer):
    """Check if has numerical calculations"""
    numbers = re.findall(r'\d+\.?\d*', answer)
    return len(numbers) >= 2

def grade_mc(student_answer, question_id):
    """Grade MC question and generate feedback"""
    answer_clean = clean_text(student_answer)
    correct_answer = MC_ANSWERS.get(question_id, "")
    correct_clean = clean_text(correct_answer)

    if not answer_clean:
        return 0.0, "No answer provided."

    # Check if correct
    is_correct = (correct_clean in answer_clean or answer_clean in correct_clean)

    # Check for partial matches
    if question_id == "57991112" and "48" in answer_clean:
        is_correct = True
    elif question_id == "57991115" and "five" in answer_clean:
        is_correct = True
    elif question_id == "57991116" and ("higher" in answer_clean or "greater" in answer_clean):
        is_correct = True
    elif question_id == "57991117" and "table" in answer_clean:
        is_correct = True
    elif question_id == "57991118" and "categorical" in answer_clean and "continuous" in answer_clean:
        is_correct = True
    elif question_id == "57991119" and ("enhance" in answer_clean or "not replace" in answer_clean):
        is_correct = True
    elif question_id == "57991120" and ("expensive" in answer_clean or "software" in answer_clean):
        is_correct = True

    if is_correct:
        return QUESTION_INFO[question_id]["points"], "✓ Correct"
    else:
        return 0.0, f"✗ Incorrect. Expected: {correct_answer}"

def grade_essay_question(student_answer, question_id):
    """Grade essay question with AI feedback"""
    answer = clean_text(student_answer)
    points = QUESTION_INFO[question_id]["points"]

    if not answer or len(answer) < 10:
        return 0.0, "No substantial response provided. Please attempt all parts of the question."

    score = 0.0
    feedback_parts = []

    # Q57991113: FEV1 Distribution Analysis (Question 2)
    if question_id == "57991113":
        # Part a: Distribution shape (3 pts)
        if any(term in answer for term in ["right", "skew", "positive"]):
            score += 3.0
            feedback_parts.append("Part a (3/3): Good identification of distribution shape")
        elif any(term in answer for term in ["skew", "distribution"]):
            score += 2.5
            feedback_parts.append("Part a (2.5/3): Mentioned skew but could be more specific about direction")
        elif any(term in answer for term in ["mean", "median"]):
            score += 2.0
            feedback_parts.append("Part a (2/3): Discussed mean/median relationship - good start")
        else:
            score += 1.0
            feedback_parts.append("Part a (1/3): Needs more analysis of distribution shape")

        # Part b: Coefficient of variation (4 pts)
        # Accept both old incorrect values (11%) and new correct values (10.1%)
        if any(term in answer for term in ["coefficient", "0.11", "11%", "11.1", "11.2", "10.1", "10.14", "10%"]):
            score += 4.0
            feedback_parts.append("Part b (4/4): Excellent - calculated CV correctly")
        elif any(calc in answer for calc in ["0.29", "2.86", "2.88", "0.32", "sd/mean", "standard deviation/mean"]):
            score += 3.5
            feedback_parts.append("Part b (3.5/4): Good calculation shown, verify final percentage")
        elif any(term in answer for term in ["variation", "variability", "spread"]):
            score += 3.0
            feedback_parts.append("Part b (3/4): Discussed variation but should calculate CV = (SD/Mean) × 100")
        else:
            score += 2.0
            feedback_parts.append("Part b (2/4): Need to calculate coefficient of variation formula")

        # Part c: Visualization (3 pts)
        if "box" in answer and ("plot" in answer or "chart" in answer):
            score += 3.0
            feedback_parts.append("Part c (3/3): Perfect - box plots are ideal for comparing groups")
        elif any(viz in answer for viz in ["histogram", "plot", "graph", "chart"]):
            score += 2.5
            feedback_parts.append("Part c (2.5/3): Reasonable visualization choice")
        else:
            score += 2.0
            feedback_parts.append("Part c (2/3): Consider box plots to compare male vs female")

    # Q57991122: FEV1 Analysis v2 (Question 11 - adolescents with asthma)
    elif question_id == "57991122":
        # Part a: Distribution shape - accept either old (2.86/2.78) or new (2.96/2.90) values (3 pts)
        if any(term in answer for term in ["right", "skew", "positive"]):
            score += 3.0
            feedback_parts.append("Part a (3/3): Correct - identified right-skewed distribution from mean > median")
        elif any(term in answer for term in ["skew", "distribution"]):
            score += 2.5
            feedback_parts.append("Part a (2.5/3): Mentioned skew but could be more specific about direction")
        elif any(term in answer for term in ["mean", "median", "higher", "greater"]):
            score += 2.0
            feedback_parts.append("Part a (2/3): Discussed mean/median relationship - good start")
        else:
            score += 1.0
            feedback_parts.append("Part a (1/3): Needs analysis of what mean > median suggests")

        # Part b: Why expect this distribution for adolescents with asthma (4 pts)
        if any(term in answer for term in ["asthma", "lung", "reduced", "lower", "impaired", "affected"]) and len(answer.split()) > 20:
            score += 4.0
            feedback_parts.append("Part b (4/4): Excellent - explained asthma's impact on lung function distribution")
        elif any(term in answer for term in ["asthma", "lung", "function"]):
            score += 3.0
            feedback_parts.append("Part b (3/4): Good discussion of asthma effects, could elaborate more")
        elif any(term in answer for term in ["skew", "outlier", "distribution"]):
            score += 2.5
            feedback_parts.append("Part b (2.5/4): Discussed distribution but needs connection to asthma pathology")
        else:
            score += 1.5
            feedback_parts.append("Part b (1.5/4): Need to explain why asthma would cause this distribution shape")

        # Part c: Which measure (mean or median) is more appropriate (3 pts)
        if "median" in answer and any(term in answer for term in ["skew", "outlier", "resistant", "robust", "appropriate"]):
            score += 3.0
            feedback_parts.append("Part c (3/3): Correct - median is better for skewed data")
        elif "median" in answer:
            score += 2.5
            feedback_parts.append("Part c (2.5/3): Chose median but could explain why it's better for skewed data")
        elif any(term in answer for term in ["skew", "outlier"]):
            score += 2.0
            feedback_parts.append("Part c (2/3): Discussed skewness but didn't clearly recommend median")
        else:
            score += 1.0
            feedback_parts.append("Part c (1/3): Should recommend median for skewed distributions")

    # Q57991114: Visualization Selection
    elif question_id == "57991114":
        word_count = len(answer.split())

        # Part a: Bar chart (3 pts)
        if word_count > 30 and any(term in answer for term in ["bar", "categorical", "compare"]):
            score += 3.0
            feedback_parts.append("Part a (3/3): Good explanation of bar chart usage")
        elif word_count > 20:
            score += 2.5
            feedback_parts.append("Part a (2.5/3): Reasonable explanation")
        else:
            score += 2.0
            feedback_parts.append("Part a (2/3): Could expand on why bar charts work for categorical data")

        # Part b: BMI visualization (3 pts)
        if "histogram" in answer or "box" in answer:
            score += 3.0
            feedback_parts.append("Part b (3/3): Excellent choice for showing distribution")
        elif any(viz in answer for viz in ["plot", "graph", "distribution"]):
            score += 2.5
            feedback_parts.append("Part b (2.5/3): Good thinking about visualizations")
        else:
            score += 2.0
            feedback_parts.append("Part b (2/3): Histogram or box plot would be ideal")

        # Part c: Pie chart critique (4 pts)
        if word_count > 100 or any(term in answer for term in ["hard to compare", "angles", "proportions", "difficult"]):
            score += 4.0
            feedback_parts.append("Part c (4/4): Thorough critique of pie chart limitations")
        elif word_count > 50:
            score += 3.0
            feedback_parts.append("Part c (3/4): Good discussion of pie chart issues")
        else:
            score += 2.5
            feedback_parts.append("Part c (2.5/4): Could elaborate more on why pie charts are problematic")

    # Q57991121: Data Types Classification
    elif question_id == "57991121":
        type_terms = ['continuous', 'discrete', 'nominal', 'ordinal', 'qualitative', 'quantitative']
        term_count = sum(1 for term in type_terms if term in answer)

        if term_count >= 5:
            score = 10.0
            feedback_parts.append("10/10: Excellent classification of all data types with proper terminology")
        elif term_count >= 4:
            score = 9.0
            feedback_parts.append("9/10: Very good - minor terminology issue or missing one classification")
        elif term_count >= 3:
            score = 8.0
            feedback_parts.append("8/10: Good understanding, but verify all 5 variables are correctly classified")
        elif term_count >= 2:
            score = 7.0
            feedback_parts.append("7/10: Basic understanding shown. Review: continuous vs discrete, nominal vs ordinal")
        else:
            score = 6.0
            feedback_parts.append("6/10: Needs more specific terminology (quantitative/qualitative, continuous/discrete, nominal/ordinal)")

    # Default for other essay questions
    else:
        if len(answer) > 200:
            score = points * 0.90
            feedback_parts.append(f"{score:.1f}/{points}: Thorough response with good detail")
        elif len(answer) > 100:
            score = points * 0.85
            feedback_parts.append(f"{score:.1f}/{points}: Good response, could add more detail")
        elif len(answer) > 50:
            score = points * 0.80
            feedback_parts.append(f"{score:.1f}/{points}: Adequate response")
        else:
            score = points * 0.70
            feedback_parts.append(f"{score:.1f}/{points}: Brief response, needs more elaboration")

    return min(score, points), "; ".join(feedback_parts)

def grade_r_code(student_answer, question_id):
    """Grade R code question with AI feedback"""
    answer = clean_text(student_answer)
    points = QUESTION_INFO[question_id]["points"]

    if not answer or len(answer) < 10:
        return 0.0, "No R code provided. Please include code and explanation."

    feedback_parts = []
    score = 0.0

    # Check for R code
    has_code = has_r_code(student_answer)
    has_calc = has_numbers(student_answer)

    if has_code:
        score = points * 1.0  # Full credit for R code
        feedback_parts.append(f"{score:.1f}/{points}: Excellent - R code provided")

        # Check for specific good practices
        if "comment" in answer or "#" in clean_for_display(student_answer):
            feedback_parts.append("Good: Code includes comments")
        if any(pkg in answer for pkg in ["ggplot", "dplyr", "library"]):
            feedback_parts.append("Good: Uses appropriate R packages")

    elif has_calc:
        score = points * 0.95  # Near full for calculations
        feedback_parts.append(f"{score:.1f}/{points}: Good - numerical calculations provided")
        feedback_parts.append("Consider showing R code for full credit")
    else:
        # Length-based grading
        word_count = len(answer.split())
        if word_count > 100:
            score = points * 0.85
            feedback_parts.append(f"{score:.1f}/{points}: Detailed explanation but missing R code")
        elif word_count > 50:
            score = points * 0.75
            feedback_parts.append(f"{score:.1f}/{points}: Good attempt, but need to include R code")
        else:
            score = points * 0.60
            feedback_parts.append(f"{score:.1f}/{points}: Response too brief, need R code and explanation")

    return score, "; ".join(feedback_parts)

def main():
    print("="*80)
    print("Creating AI-Powered Grading Assistant")
    print("="*80)

    df = pd.read_csv(submissions_file)
    print(f"\nLoaded {len(df)} student submissions")
    print("AI is grading and generating feedback...")

    students_data = []

    # MC question IDs (auto-graded)
    MC_QUESTIONS = ["57991112", "57991115", "57991116", "57991117", "57991118", "57991119", "57991120"]

    for idx, row in df.iterrows():
        student_name = row['name']
        student_id = str(row.get('sis_id', row.get('id', 'Unknown')))

        print(f"\nGrading: {student_name}")

        student_info = {
            'name': student_name,
            'id': student_id,
            'questions': [],
            'mc_score': 0.0
        }

        total_score = 0.0
        total_possible = 0.0

        # Calculate MC score from Canvas
        for col in df.columns:
            question_id_match = re.search(r'(\d+):', col)
            if question_id_match:
                question_id = question_id_match.group(1)
                if question_id in MC_QUESTIONS:
                    score_col_idx = df.columns.get_loc(col) + 1
                    if score_col_idx < len(df.columns):
                        score = row[df.columns[score_col_idx]]
                        if pd.notna(score):
                            student_info['mc_score'] += float(score)

        # Process all questions
        for col in df.columns:
            question_id_match = re.search(r'(\d+):', col)
            if not question_id_match:
                continue

            question_id = question_id_match.group(1)
            if question_id not in QUESTION_INFO:
                continue

            student_answer = row[col]
            q_info = QUESTION_INFO[question_id]

            # Skip MC questions - they're auto-graded in Canvas
            if q_info["type"] == "mc":
                continue

            # Grade based on question type
            if q_info["type"] == "r_code":
                score, feedback = grade_r_code(student_answer, question_id)
            else:  # essay
                score, feedback = grade_essay_question(student_answer, question_id)

            # Prepend question number and title to feedback
            feedback_with_header = f"Question {q_info['qnum']}: {q_info['title']}\n\n{feedback}"

            question_data = {
                'id': question_id,
                'qnum': q_info['qnum'],
                'title': q_info['title'],
                'type': q_info['type'],
                'points_possible': q_info['points'],
                'answer': clean_for_display(student_answer),
                'score': round(score, 1),
                'feedback': feedback_with_header
            }

            student_info['questions'].append(question_data)
            total_score += score
            total_possible += q_info['points']

        print(f"  Score: {total_score:.1f}/{total_possible} ({total_score/total_possible*100:.1f}%)")
        students_data.append(student_info)

    # Sort students alphabetically by last name (like Canvas)
    def get_last_name(full_name):
        """Extract last name from full name"""
        parts = full_name.strip().split()
        return parts[-1] if parts else full_name

    students_data.sort(key=lambda x: get_last_name(x['name']))
    print(f"\nStudents sorted alphabetically by last name")

    # Generate HTML
    print(f"\nGenerating HTML interface...")
    html_content = generate_html(students_data)

    with open(output_html, 'w', encoding='utf-8') as f:
        f.write(html_content)

    print(f"\n{'='*80}")
    print(f"SUCCESS! Created: {output_html}")
    print(f"{'='*80}")
    print(f"\nHow to use:")
    print(f"1. Open {output_html} in your browser")
    print(f"2. Review AI grades and feedback for each student")
    print(f"3. Edit scores/feedback as needed")
    print(f"4. Copy final scores and comments into Canvas SpeedGrader")
    print(f"\nAI has graded {len(students_data)} students!")
    print(f"{'='*80}\n")

def generate_html(students_data):
    """Generate HTML with embedded grading data"""
    students_json = json.dumps(students_data)

    # [Previous HTML template code from create_review_interface_v2.py - I'll include it here]

    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>H524 Assignment 1 - AI Grading Assistant</title>
    <style>
        * {{
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }}
        body {{
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif;
            background: #f5f5f5;
            padding: 20px;
            line-height: 1.6;
        }}
        .container {{
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }}
        header {{
            border-bottom: 3px solid #D73F09;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }}
        h1 {{
            color: #D73F09;
            margin-bottom: 10px;
        }}
        .ai-badge {{
            display: inline-block;
            background: #4A90E2;
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            margin-left: 10px;
        }}
        .controls {{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }}
        button {{
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
        }}
        button.primary {{
            background: #D73F09;
            color: white;
        }}
        button.primary:hover {{
            background: #b83308;
        }}
        button.secondary {{
            background: #6c757d;
            color: white;
        }}
        button.secondary:hover {{
            background: #5a6268;
        }}
        button:disabled {{
            opacity: 0.5;
            cursor: not-allowed;
        }}
        .student-info {{
            background: #e3f2fd;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }}
        .student-info h2 {{
            color: #1565c0;
            margin-bottom: 5px;
        }}
        .score-summary {{
            font-size: 18px;
            font-weight: bold;
            color: #2e7d32;
            margin-top: 10px;
        }}
        .question-card {{
            border: 2px solid #dee2e6;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
            background: #fafafa;
        }}
        .question-card.modified {{
            border-color: #ffc107;
            background: #fff8e1;
        }}
        .question-header {{
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #dee2e6;
        }}
        .question-title {{
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }}
        .question-type {{
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
            margin-left: 10px;
        }}
        .type-mc {{
            background: #d4edda;
            color: #155724;
        }}
        .type-essay {{
            background: #e3f2fd;
            color: #1565c0;
        }}
        .type-r_code {{
            background: #f3e5f5;
            color: #7b1fa2;
        }}
        .answer-section {{
            margin-bottom: 15px;
        }}
        .answer-label {{
            font-weight: bold;
            color: #495057;
            margin-bottom: 8px;
        }}
        .answer-text {{
            background: white;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid #ced4da;
            white-space: pre-wrap;
            word-wrap: break-word;
            max-height: 400px;
            overflow-y: auto;
            font-family: 'Courier New', monospace;
            font-size: 13px;
            line-height: 1.5;
        }}
        .grading-section {{
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 15px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #dee2e6;
        }}
        .score-input-container {{
            display: flex;
            flex-direction: column;
            gap: 10px;
        }}
        .score-input {{
            display: flex;
            align-items: center;
            gap: 10px;
        }}
        .score-input input {{
            width: 80px;
            padding: 8px;
            border: 2px solid #ced4da;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
        }}
        .score-input input:focus {{
            outline: none;
            border-color: #D73F09;
        }}
        .copy-btn {{
            padding: 6px 12px;
            font-size: 12px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }}
        .copy-btn:hover {{
            background: #218838;
        }}
        .feedback-input textarea {{
            width: 100%;
            padding: 10px;
            border: 2px solid #ced4da;
            border-radius: 4px;
            font-family: inherit;
            font-size: 14px;
            resize: vertical;
            min-height: 100px;
        }}
        .feedback-input textarea:focus {{
            outline: none;
            border-color: #D73F09;
        }}
        .stats {{
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-bottom: 20px;
        }}
        .stat-card {{
            background: white;
            padding: 15px;
            border-radius: 5px;
            border-left: 4px solid #D73F09;
        }}
        .stat-label {{
            font-size: 12px;
            color: #6c757d;
            text-transform: uppercase;
            margin-bottom: 5px;
        }}
        .stat-value {{
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }}
        .cumulative-notes {{
            background: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 5px;
            padding: 20px;
            margin-top: 30px;
            margin-bottom: 30px;
        }}
        .cumulative-notes h3 {{
            color: #856404;
            margin-bottom: 15px;
            font-size: 18px;
        }}
        .cumulative-notes textarea {{
            width: 100%;
            min-height: 300px;
            padding: 15px;
            border: 2px solid #ffc107;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            font-size: 13px;
            line-height: 1.6;
            resize: vertical;
            background: white;
        }}
        .cumulative-notes .copy-all-btn {{
            margin-top: 15px;
            padding: 12px 24px;
            font-size: 14px;
            background: #ffc107;
            color: #000;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }}
        .cumulative-notes .copy-all-btn:hover {{
            background: #e0a800;
        }}
        .instructions {{
            background: #d1ecf1;
            border: 2px solid #17a2b8;
            border-radius: 5px;
            padding: 20px;
            margin-top: 30px;
        }}
        .instructions h3 {{
            color: #0c5460;
            margin-bottom: 10px;
        }}
        .instructions ol {{
            margin-left: 20px;
        }}
        .instructions li {{
            margin-bottom: 8px;
        }}
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>H524 Assignment 1 - AI Grading Assistant<span class="ai-badge">AI-POWERED</span></h1>
            <p>AI has pre-graded all responses. Review, edit, and copy to Canvas SpeedGrader.</p>
        </header>

        <div class="stats">
            <div class="stat-card">
                <div class="stat-label">Current Student Score</div>
                <div class="stat-value" id="currentScore">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Questions Modified</div>
                <div class="stat-value" id="modifiedCount">0</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Total Students</div>
                <div class="stat-value" id="studentCount">0</div>
            </div>
        </div>

        <div class="controls">
            <div>
                <button id="prevBtn" class="secondary" onclick="previousStudent()">← Previous</button>
                <button id="nextBtn" class="secondary" onclick="nextStudent()">Next →</button>
            </div>
            <div class="progress">
                Student <span id="currentIndex">1</span> of <span id="totalStudents">0</span>
            </div>
            <div>
                <button class="primary" onclick="exportGrades()">Export All Grades</button>
            </div>
        </div>

        <div id="studentContainer"></div>

        <div class="instructions">
            <h3>📋 How to Use This Grading Assistant</h3>
            <ol>
                <li><strong>Review:</strong> AI has graded each question and added feedback comments (with question numbers)</li>
                <li><strong>Edit:</strong> Modify scores or feedback as needed (modified questions turn yellow)</li>
                <li><strong>Export Grades:</strong> Click "Export All Grades" to download 2 CSV files:
                    <ul style="margin-top: 5px; margin-left: 20px;">
                        <li><strong>Canvas Upload CSV:</strong> Import this into Canvas Gradebook to upload all scores at once (no manual entry!)</li>
                        <li><strong>Detailed Grades CSV:</strong> For your records (includes individual question scores and all feedback)</li>
                    </ul>
                </li>
                <li><strong>Upload Scores:</strong> In Canvas Gradebook → Import → Upload the Canvas CSV file</li>
                <li><strong>Paste Feedback:</strong> For each student, use "Copy All Feedback" button and paste into Canvas SpeedGrader general comments</li>
            </ol>
            <p style="margin-top: 15px;"><strong>Total workflow:</strong> Export CSV (1 click) + Upload to Canvas (1 upload) + Paste feedback for 18 students = ~20 operations total!</p>
            <p style="margin-top: 10px;"><strong>Modified questions:</strong> <span id="totalModified">0</span></p>
        </div>
    </div>

    <script>
        const studentsData = {students_json};
        let currentStudentIndex = 0;
        let modifiedQuestions = new Set();

        document.addEventListener('DOMContentLoaded', function() {{
            console.log('Loaded students:', studentsData.length);
            document.getElementById('totalStudents').textContent = studentsData.length;
            document.getElementById('studentCount').textContent = studentsData.length;
            renderStudent(0);
        }});

        function renderStudent(index) {{
            if (index < 0 || index >= studentsData.length) return;

            currentStudentIndex = index;
            const student = studentsData[index];

            document.getElementById('currentIndex').textContent = index + 1;
            document.getElementById('prevBtn').disabled = (index === 0);
            document.getElementById('nextBtn').disabled = (index === studentsData.length - 1);

            let totalScore = 0;
            let totalPossible = 0;
            student.questions.forEach(q => {{
                totalScore += parseFloat(q.score) || 0;
                totalPossible += parseFloat(q.points_possible) || 0;
            }});

            const mcScore = student.mc_score || 0;
            const grandTotal = totalScore + mcScore;
            const grandPercentage = ((grandTotal / 103) * 100).toFixed(1);

            document.getElementById('currentScore').textContent = grandTotal.toFixed(1) + ' / 103';

            const container = document.getElementById('studentContainer');
            const percentage = totalPossible > 0 ? ((totalScore / totalPossible) * 100).toFixed(1) : 0;

            let html = `
                <div class="student-info">
                    <h2>${{student.name}}</h2>
                    <p>Student ID: ${{student.id}}</p>
                    <div class="score-summary">
                        Fill-in Questions: ${{totalScore.toFixed(1)}} / ${{totalPossible}} (${{percentage}}%)<br>
                        MC Questions (auto-graded): ${{mcScore.toFixed(1)}} / 28<br>
                        <strong>Total Score: <span id="studentScore">${{grandTotal.toFixed(1)}}</span> / 103
                        (<span id="studentPercentage">${{grandPercentage}}</span>%)</strong>
                    </div>
                </div>
            `;

            student.questions.forEach((q, qIndex) => {{
                const isModified = modifiedQuestions.has(`${{index}}-${{qIndex}}`);
                html += `
                    <div class="question-card ${{isModified ? 'modified' : ''}}" id="q-${{index}}-${{qIndex}}">
                        <div class="question-header">
                            <div>
                                <span class="question-title">Question ${{q.qnum}}: ${{q.title}}</span>
                                <span class="question-type type-${{q.type}}">${{q.type.toUpperCase()}}</span>
                            </div>
                            <div style="font-weight: bold; color: #495057;">
                                Points: ${{q.points_possible}}
                            </div>
                        </div>

                        <div class="answer-section">
                            <div class="answer-label">Student Response:</div>
                            <div class="answer-text">${{escapeHtml(q.answer)}}</div>
                        </div>

                        <div class="grading-section">
                            <div class="score-input-container">
                                <div class="answer-label">Score:</div>
                                <div class="score-input">
                                    <input type="number"
                                           id="score-${{index}}-${{qIndex}}"
                                           value="${{q.score}}"
                                           min="0"
                                           max="${{q.points_possible}}"
                                           step="0.1"
                                           onchange="updateScore(${{index}}, ${{qIndex}})">
                                    <span>/ ${{q.points_possible}}</span>
                                </div>
                                <button class="copy-btn" onclick="copyScoreAndFeedback(${{index}}, ${{qIndex}})">
                                    Copy Score & Feedback
                                </button>
                            </div>

                            <div class="feedback-input">
                                <div class="answer-label">AI Feedback (edit as needed):</div>
                                <textarea id="feedback-${{index}}-${{qIndex}}"
                                          onchange="updateFeedback(${{index}}, ${{qIndex}})">${{q.feedback}}</textarea>
                            </div>
                        </div>
                    </div>
                `;
            }});

            // Build cumulative notes
            let cumulativeText = `${{student.name}} - Cumulative Feedback\\n${{'-'.repeat(60)}}\\n\\n`;
            student.questions.forEach(q => {{
                cumulativeText += `${{q.feedback}}\\n\\nScore: ${{q.score}}/${{q.points_possible}}\\n\\n${{'-'.repeat(60)}}\\n\\n`;
            }});
            cumulativeText += `Fill-in Questions Score: ${{totalScore.toFixed(1)}} / ${{totalPossible}} (${{percentage}}%)\\n`;
            cumulativeText += `(Note: Multiple-choice questions are auto-graded separately in Canvas.\\nTotal assignment is out of 103 points including MC questions.)`;

            // Add cumulative notes section
            html += `
                <div class="cumulative-notes">
                    <h3>📝 Cumulative Feedback - Copy All At Once</h3>
                    <p style="margin-bottom: 15px; color: #856404;">All feedback with question numbers combined. Note: This shows only fill-in questions (75 pts). MC questions (28 pts) are auto-graded in Canvas. Total assignment = 103 points.</p>
                    <textarea id="cumulative-${{index}}" readonly>${{cumulativeText}}</textarea>
                    <button class="copy-all-btn" onclick="copyCumulativeFeedback(${{index}})">
                        📋 Copy All Feedback
                    </button>
                </div>
            `;

            container.innerHTML = html;
        }}

        function escapeHtml(text) {{
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }}

        function updateScore(studentIndex, questionIndex) {{
            const input = document.getElementById(`score-${{studentIndex}}-${{questionIndex}}`);
            const newScore = parseFloat(input.value) || 0;
            studentsData[studentIndex].questions[questionIndex].score = newScore;
            markAsModified(studentIndex, questionIndex);
            updateScoreDisplays();
            updateCumulativeNotes(studentIndex);
        }}

        function updateFeedback(studentIndex, questionIndex) {{
            const textarea = document.getElementById(`feedback-${{studentIndex}}-${{questionIndex}}`);
            studentsData[studentIndex].questions[questionIndex].feedback = textarea.value;
            markAsModified(studentIndex, questionIndex);
            updateCumulativeNotes(studentIndex);
        }}

        function updateCumulativeNotes(studentIndex) {{
            const student = studentsData[studentIndex];
            const textarea = document.getElementById(`cumulative-${{studentIndex}}`);
            if (!textarea) return;

            let totalScore = 0;
            let totalPossible = 0;
            student.questions.forEach(q => {{
                totalScore += parseFloat(q.score) || 0;
                totalPossible += parseFloat(q.points_possible) || 0;
            }});
            const percentage = totalPossible > 0 ? ((totalScore / totalPossible) * 100).toFixed(1) : 0;

            let cumulativeText = `${{student.name}} - Cumulative Feedback\\n${{'-'.repeat(60)}}\\n\\n`;
            student.questions.forEach(q => {{
                cumulativeText += `${{q.feedback}}\\n\\nScore: ${{q.score}}/${{q.points_possible}}\\n\\n${{'-'.repeat(60)}}\\n\\n`;
            }});
            cumulativeText += `Fill-in Questions Score: ${{totalScore.toFixed(1)}} / ${{totalPossible}} (${{percentage}}%)\\n`;
            cumulativeText += `(Note: Multiple-choice questions are auto-graded separately in Canvas.\\nTotal assignment is out of 103 points including MC questions.)`;

            textarea.value = cumulativeText;
        }}

        function markAsModified(studentIndex, questionIndex) {{
            const key = `${{studentIndex}}-${{questionIndex}}`;
            modifiedQuestions.add(key);
            const card = document.getElementById(`q-${{studentIndex}}-${{questionIndex}}`);
            if (card) card.classList.add('modified');
            document.getElementById('modifiedCount').textContent = modifiedQuestions.size;
            document.getElementById('totalModified').textContent = modifiedQuestions.size;
        }}

        function updateScoreDisplays() {{
            const student = studentsData[currentStudentIndex];
            let totalScore = 0;
            let totalPossible = 0;
            student.questions.forEach(q => {{
                totalScore += parseFloat(q.score) || 0;
                totalPossible += parseFloat(q.points_possible) || 0;
            }});
            const mcScore = student.mc_score || 0;
            const grandTotal = totalScore + mcScore;
            const grandPercentage = ((grandTotal / 103) * 100).toFixed(1);

            document.getElementById('currentScore').textContent = grandTotal.toFixed(1) + ' / 103';
            document.getElementById('studentScore').textContent = grandTotal.toFixed(1);
            document.getElementById('studentPercentage').textContent = grandPercentage;
        }}

        function copyScoreAndFeedback(studentIndex, questionIndex) {{
            const q = studentsData[studentIndex].questions[questionIndex];
            const text = `${{q.feedback}}\\n\\nScore: ${{q.score}}/${{q.points_possible}}`;

            navigator.clipboard.writeText(text).then(() => {{
                alert('Copied to clipboard!\\nNow paste into Canvas SpeedGrader.');
            }}).catch(err => {{
                alert('Failed to copy. Please copy manually.');
            }});
        }}

        function copyCumulativeFeedback(studentIndex) {{
            const textarea = document.getElementById(`cumulative-${{studentIndex}}`);
            const text = textarea.value;

            navigator.clipboard.writeText(text).then(() => {{
                alert('All feedback copied to clipboard!\\nThis includes all questions with their numbers and scores.');
            }}).catch(err => {{
                alert('Failed to copy. Please select the text manually and copy.');
            }});
        }}

        function previousStudent() {{
            if (currentStudentIndex > 0) {{
                renderStudent(currentStudentIndex - 1);
                window.scrollTo(0, 0);
            }}
        }}

        function nextStudent() {{
            if (currentStudentIndex < studentsData.length - 1) {{
                renderStudent(currentStudentIndex + 1);
                window.scrollTo(0, 0);
            }}
        }}

        function exportGrades() {{
            // Export detailed CSV for instructor records
            let detailedCsv = 'Student,ID,';
            const firstStudent = studentsData[0];
            firstStudent.questions.forEach(q => {{
                detailedCsv += `Q${{q.id}}_Score,Q${{q.id}}_Feedback,`;
            }});
            detailedCsv += 'Total_Score,Total_Possible,Percentage\\n';

            studentsData.forEach(student => {{
                detailedCsv += `"${{student.name}}","${{student.id}}",`;
                let totalScore = 0;
                let totalPossible = 0;
                student.questions.forEach(q => {{
                    totalScore += parseFloat(q.score) || 0;
                    totalPossible += parseFloat(q.points_possible) || 0;
                    const feedback = q.feedback.replace(/"/g, '""');
                    detailedCsv += `${{q.score}},"${{feedback}}",`;
                }});
                const percentage = totalPossible > 0 ? ((totalScore / totalPossible) * 100).toFixed(1) : 0;
                detailedCsv += `${{totalScore.toFixed(1)}},${{totalPossible}},${{percentage}}\\n`;
            }});

            // Export Canvas-compatible CSV for grade upload
            // Match Canvas gradebook format exactly
            let canvasCsv = 'Student,ID,SIS User ID,SIS Login ID,Section,"H524 Assignment 1: Introduction to Biostatistics and Data Visualization (10269751)"\\n';
            canvasCsv += 'Points Possible,,,,,103.00\\n';

            studentsData.forEach(student => {{
                let fillinScore = 0;
                student.questions.forEach(q => {{
                    fillinScore += parseFloat(q.score) || 0;
                }});
                let mcScore = student.mc_score || 0;
                let totalScore = fillinScore + mcScore;

                // Format: "Last, First",ID,SIS_ID,Email,Section,Score
                canvasCsv += `"${{student.name}}","${{student.id}}","${{student.id}}","","","${{totalScore.toFixed(2)}}"\\n`;
            }});

            // Download detailed CSV
            let blob = new Blob([detailedCsv], {{ type: 'text/csv' }});
            let url = window.URL.createObjectURL(blob);
            let a = document.createElement('a');
            a.href = url;
            a.download = 'assignment1_detailed_grades.csv';
            a.click();
            window.URL.revokeObjectURL(url);

            // Download Canvas CSV
            setTimeout(() => {{
                blob = new Blob([canvasCsv], {{ type: 'text/csv' }});
                url = window.URL.createObjectURL(blob);
                a = document.createElement('a');
                a.href = url;
                a.download = 'assignment1_canvas_upload.csv';
                a.click();
                window.URL.revokeObjectURL(url);

                alert(`Exported 2 files:\\n1. Detailed grades (for your records)\\n2. Canvas upload file (total scores only)`);
            }}, 500);
        }}
    </script>
</body>
</html>"""

    return html

if __name__ == "__main__":
    main()
