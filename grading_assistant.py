#!/usr/bin/env python3
"""
Generic AI-Powered Grading Assistant for H524 Assignments
Usage: python grading_assistant.py <canvas_export.csv>

Creates an HTML interface for reviewing and grading student submissions.
Exports grade reports and Canvas-ready CSV files to the same directory as the input file.
"""

import pandas as pd
import re
import json
import sys
from pathlib import Path
from datetime import datetime

def clean_text(text):
    """Clean text for comparison"""
    if pd.isna(text):
        return ""
    return str(text).strip().lower()

def clean_for_display(text):
    """Clean text for display in HTML"""
    if pd.isna(text):
        return "[No answer provided]"
    text = str(text).strip()
    text = text.replace('\xa0', ' ')
    return text if text else "[No answer provided]"

def detect_questions(df):
    """Auto-detect questions from Canvas CSV columns"""
    questions = {}

    for col in df.columns:
        # Match Canvas question format: "ID: Question Text"
        # Use re.DOTALL to handle embedded newlines in column headers
        match = re.search(r'(\d+):\s*(.+?)(?:\s*\(.*?\))?$', str(col), re.DOTALL)
        if match:
            question_id = match.group(1)
            # Replace newlines with spaces and clean up multiple spaces
            question_text = re.sub(r'\s+', ' ', match.group(2)).strip()

            # Try to get max points from the next column
            col_idx = df.columns.get_loc(col)
            max_points = 10.0  # default

            # Check if next column contains point values
            if col_idx + 1 < len(df.columns):
                next_col = df.columns[col_idx + 1]
                # Canvas usually puts scores in the next column
                sample_value = df[next_col].dropna().iloc[0] if not df[next_col].dropna().empty else None
                if sample_value is not None and isinstance(sample_value, (int, float)):
                    max_points = float(df[next_col].max())

            # Detect question type based on answers
            sample_answers = df[col].dropna().head(10)
            is_mc = False
            is_short = True

            if len(sample_answers) > 0:
                avg_length = sample_answers.astype(str).str.len().mean()
                # MC answers are typically short and consistent
                if avg_length < 100:
                    is_mc = True
                if avg_length > 50:
                    is_short = False

            questions[question_id] = {
                'id': question_id,
                'title': question_text[:60] + ('...' if len(question_text) > 60 else ''),
                'full_title': question_text,
                'column': col,
                'points': max_points,
                'type': 'mc' if is_mc else ('short' if is_short else 'essay')
            }

    return questions

def has_r_code(answer):
    """Check if response contains R code"""
    answer_lower = clean_text(answer)

    r_function_calls = [
        'mean(', 'median(', 'summary(', 'table(', 'prop.table(',
        'aggregate(', 'tapply(', 'ggplot(', 'aes(', 'geom_',
        'barplot(', 'hist(', 'boxplot(', 'library(', 'c(',
        'data.frame(', 'sum(', 'length(', 'str(', 'head(',
        'pbinom(', 'dbinom(', 'pnorm(', 'dnorm(', 'qnorm('
    ]

    has_assignment = '<-' in answer_lower
    has_dollar_access = '$' in answer
    function_count = sum(1 for func in r_function_calls if func in answer_lower)

    return has_assignment or function_count >= 2 or has_dollar_access

def check_trap_phrases(answer):
    """Check for trap phrases indicating student is testing if work is being read"""
    answer_lower = clean_text(answer)

    trap_patterns = [
        # Direct challenges
        "you're not reading", "youre not reading", "you are not reading",
        "bet you didn't read", "bet you didnt read",
        "nobody's reading", "nobodys reading", "no one is reading",
        "not reading this", "aren't reading",

        # AI grading complaints
        "using ai to grade", "ai is grading", "chatgpt is grading",
        "robot grading", "bot is grading", "automated grading",

        # Hidden messages
        "secret message", "easter egg", "hidden message",
        "if anyone reads this", "if someone reads this",
        "if you read this", "if you're reading this",

        # Sarcasm/testing
        "waste of time", "like anyone cares", "this is crap",
        "this is garbage", "this is bullshit",

        # Meta-commentary
        "just checking if", "testing if you", "prove you're reading",
        "to see if you", "checking whether"
    ]

    detected = []
    for pattern in trap_patterns:
        if pattern in answer_lower:
            detected.append(pattern)

    return detected

def grade_question(student_answer, question_info):
    """Auto-grade a question and provide feedback"""
    answer = clean_text(student_answer)
    points = question_info['points']
    q_type = question_info['type']

    if not answer or len(answer) < 5:
        return 0.0, "No substantial response provided."

    feedback_parts = []
    score = 0.0

    # Check for trap phrases (academic integrity)
    trap_phrases = check_trap_phrases(student_answer)
    if trap_phrases:
        feedback_parts.append(f"⚠️ ALERT: Trap phrase detected - '{trap_phrases[0]}' - Review response carefully")

    # MC questions - give partial credit if there's an answer
    if q_type == 'mc':
        if len(answer) > 0:
            score = points * 0.95  # Assume mostly correct, human will verify
            feedback_parts.append(f"Review answer: {clean_for_display(student_answer)[:100]}")
        else:
            score = 0.0
            feedback_parts.append("No answer provided")

    # Short answer questions
    elif q_type == 'short':
        word_count = len(answer.split())
        if word_count > 30:
            score = points * 0.95
            feedback_parts.append("Good response with adequate detail")
        elif word_count > 15:
            score = points * 0.90
            feedback_parts.append("Reasonable response, could add more detail")
        elif word_count > 5:
            score = points * 0.80
            feedback_parts.append("Brief response, needs more elaboration")
        else:
            score = points * 0.60
            feedback_parts.append("Very brief response, needs significant expansion")

    # Essay/code questions
    else:
        # Check for R code
        if has_r_code(student_answer):
            score = points * 0.98
            feedback_parts.append("R code provided - excellent")

            if "#" in clean_for_display(student_answer):
                feedback_parts.append("Good: includes comments")
        else:
            word_count = len(answer.split())
            if word_count > 200:
                score = points * 0.92
                feedback_parts.append("Thorough written response")
            elif word_count > 100:
                score = points * 0.88
                feedback_parts.append("Good response with reasonable detail")
            elif word_count > 50:
                score = points * 0.82
                feedback_parts.append("Adequate response, could expand")
            else:
                score = points * 0.70
                feedback_parts.append("Brief response, needs more detail")

    feedback = "; ".join(feedback_parts) if feedback_parts else "Review response"
    return round(score, 1), feedback

def process_submissions(csv_path):
    """Process Canvas submission CSV and grade all responses"""
    print(f"Reading submissions from: {csv_path}")
    df = pd.read_csv(csv_path)

    print(f"Found {len(df)} student submissions")

    # Detect questions
    questions = detect_questions(df)
    print(f"Detected {len(questions)} questions")

    for qid, qinfo in questions.items():
        print(f"  Q{qid}: {qinfo['title']} ({qinfo['points']} pts, {qinfo['type']})")

    students_data = []

    for idx, row in df.iterrows():
        student_name = row.get('Student', row.get('name', 'Unknown'))
        student_id = str(row.get('ID', row.get('SIS User ID', row.get('id', 'Unknown'))))

        print(f"\nGrading: {student_name}")

        student_info = {
            'name': student_name,
            'id': student_id,
            'questions': []
        }

        # Grade each question
        for qid, qinfo in questions.items():
            student_answer = row.get(qinfo['column'], '')
            score, feedback = grade_question(student_answer, qinfo)

            question_data = {
                'id': qid,
                'title': qinfo['title'],
                'full_title': qinfo['full_title'],
                'type': qinfo['type'],
                'points_possible': qinfo['points'],
                'answer': clean_for_display(student_answer),
                'score': score,
                'feedback': feedback
            }

            student_info['questions'].append(question_data)

        students_data.append(student_info)

    # Sort by last name
    def get_last_name(full_name):
        parts = full_name.strip().split()
        return parts[-1] if parts else full_name

    students_data.sort(key=lambda x: get_last_name(x['name']))

    return students_data, questions

def generate_html(students_data, questions):
    """Generate interactive HTML grading interface"""

    students_json = json.dumps(students_data)

    # Calculate total points
    total_points = sum(q['points'] for q in questions.values())

    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>H524 Grading Assistant</title>
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
        .type-short {{
            background: #e3f2fd;
            color: #1565c0;
        }}
        .type-essay {{
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
        .cumulative-notes button {{
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
        .cumulative-notes button:hover {{
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
            <h1>H524 Grading Assistant<span class="ai-badge">AI-POWERED</span></h1>
            <p>AI has pre-graded all responses. Review, edit, and export grades.</p>
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
                <button class="primary" onclick="exportGrades()">Export Grades</button>
            </div>
        </div>

        <div id="studentContainer"></div>

        <div class="instructions">
            <h3>📋 How to Use This Grading Assistant</h3>
            <ol>
                <li><strong>Review:</strong> AI has graded each question and added feedback</li>
                <li><strong>Edit:</strong> Modify scores or feedback as needed (modified questions turn yellow)</li>
                <li><strong>Export Grades:</strong> Click "Export Grades" to download CSV files:
                    <ul style="margin-top: 5px; margin-left: 20px;">
                        <li><strong>Canvas Upload CSV:</strong> Import into Canvas Gradebook</li>
                        <li><strong>Detailed Grades CSV:</strong> For your records</li>
                        <li><strong>Feedback Report:</strong> Text file with all student feedback</li>
                    </ul>
                </li>
                <li><strong>Upload:</strong> In Canvas Gradebook → Import → Upload the Canvas CSV</li>
                <li><strong>Feedback:</strong> Copy individual or cumulative feedback to Canvas SpeedGrader</li>
            </ol>
            <p style="margin-top: 15px;"><strong>Modified questions:</strong> <span id="totalModified">0</span></p>
        </div>
    </div>

    <script>
        const studentsData = {students_json};
        const totalPoints = {total_points};
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

            const percentage = totalPossible > 0 ? ((totalScore / totalPossible) * 100).toFixed(1) : 0;
            document.getElementById('currentScore').textContent = totalScore.toFixed(1) + ' / ' + totalPossible;

            const container = document.getElementById('studentContainer');

            let html = `
                <div class="student-info">
                    <h2>${{student.name}}</h2>
                    <p>Student ID: ${{student.id}}</p>
                    <div class="score-summary">
                        Total Score: <span id="studentScore">${{totalScore.toFixed(1)}}</span> / ${{totalPossible}}
                        (<span id="studentPercentage">${{percentage}}</span>%)
                    </div>
                </div>
            `;

            student.questions.forEach((q, qIndex) => {{
                const isModified = modifiedQuestions.has(`${{index}}-${{qIndex}}`);
                html += `
                    <div class="question-card ${{isModified ? 'modified' : ''}}" id="q-${{index}}-${{qIndex}}">
                        <div class="question-header">
                            <div>
                                <span class="question-title">Q${{q.id}}: ${{q.title}}</span>
                                <span class="question-type type-${{q.type}}">${{q.type}}</span>
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
                            </div>

                            <div class="feedback-input">
                                <div class="answer-label">Feedback (edit as needed):</div>
                                <textarea id="feedback-${{index}}-${{qIndex}}"
                                          onchange="updateFeedback(${{index}}, ${{qIndex}})">${{q.feedback}}</textarea>
                            </div>
                        </div>
                    </div>
                `;
            }});

            // Build cumulative notes
            let cumulativeText = `${{student.name}} - Feedback\\n${{'-'.repeat(60)}}\\n\\n`;
            student.questions.forEach(q => {{
                cumulativeText += `Q${{q.id}}: ${{q.full_title}}\\n\\n${{q.feedback}}\\n\\nScore: ${{q.score}}/${{q.points_possible}}\\n\\n${{'-'.repeat(60)}}\\n\\n`;
            }});
            cumulativeText += `Total Score: ${{totalScore.toFixed(1)}} / ${{totalPossible}} (${{percentage}}%)`;

            html += `
                <div class="cumulative-notes">
                    <h3>📝 Cumulative Feedback - Copy All</h3>
                    <p style="margin-bottom: 15px; color: #856404;">All feedback combined for easy copy/paste to Canvas.</p>
                    <textarea id="cumulative-${{index}}" readonly>${{cumulativeText}}</textarea>
                    <button onclick="copyCumulativeFeedback(${{index}})">
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

            let cumulativeText = `${{student.name}} - Feedback\\n${{'-'.repeat(60)}}\\n\\n`;
            student.questions.forEach(q => {{
                cumulativeText += `Q${{q.id}}: ${{q.full_title}}\\n\\n${{q.feedback}}\\n\\nScore: ${{q.score}}/${{q.points_possible}}\\n\\n${{'-'.repeat(60)}}\\n\\n`;
            }});
            cumulativeText += `Total Score: ${{totalScore.toFixed(1)}} / ${{totalPossible}} (${{percentage}}%)`;

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
            const percentage = totalPossible > 0 ? ((totalScore / totalPossible) * 100).toFixed(1) : 0;

            document.getElementById('currentScore').textContent = totalScore.toFixed(1) + ' / ' + totalPossible;
            document.getElementById('studentScore').textContent = totalScore.toFixed(1);
            document.getElementById('studentPercentage').textContent = percentage;
        }}

        function copyCumulativeFeedback(studentIndex) {{
            const textarea = document.getElementById(`cumulative-${{studentIndex}}`);
            const text = textarea.value;

            navigator.clipboard.writeText(text).then(() => {{
                alert('All feedback copied to clipboard!');
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
            const timestamp = new Date().toISOString().slice(0,10);

            // 1. Detailed CSV for instructor
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

            // 2. Canvas-compatible CSV (simplified)
            let canvasCsv = 'Student,ID,SIS User ID,SIS Login ID,Section,Assignment Score\\n';
            canvasCsv += `Points Possible,,,,,{total_points}\\n`;

            studentsData.forEach(student => {{
                let totalScore = 0;
                student.questions.forEach(q => {{
                    totalScore += parseFloat(q.score) || 0;
                }});
                canvasCsv += `"${{student.name}}","${{student.id}}","${{student.id}}","","","${{totalScore.toFixed(2)}}"\\n`;
            }});

            // 3. Feedback report (text file)
            let feedbackReport = 'H524 Assignment Grading Report\\n';
            feedbackReport += `Generated: ${{new Date().toLocaleString()}}\\n`;
            feedbackReport += `=${{=.repeat(80)}}\\n\\n`;

            studentsData.forEach(student => {{
                let totalScore = 0;
                let totalPossible = 0;
                student.questions.forEach(q => {{
                    totalScore += parseFloat(q.score) || 0;
                    totalPossible += parseFloat(q.points_possible) || 0;
                }});
                const percentage = totalPossible > 0 ? ((totalScore / totalPossible) * 100).toFixed(1) : 0;

                feedbackReport += `${{student.name}} (ID: ${{student.id}})\\n`;
                feedbackReport += `Total: ${{totalScore.toFixed(1)}}/${{totalPossible}} (${{percentage}}%)\\n`;
                feedbackReport += `${{'-'.repeat(80)}}\\n\\n`;

                student.questions.forEach(q => {{
                    feedbackReport += `Q${{q.id}}: ${{q.full_title}}\\n`;
                    feedbackReport += `Score: ${{q.score}}/${{q.points_possible}}\\n`;
                    feedbackReport += `Feedback: ${{q.feedback}}\\n\\n`;
                }});

                feedbackReport += `\\n${{=.repeat(80)}}\\n\\n`;
            }});

            // Download files
            downloadFile(detailedCsv, `grading_detailed_${{timestamp}}.csv`, 'text/csv');
            setTimeout(() => {{
                downloadFile(canvasCsv, `grading_canvas_upload_${{timestamp}}.csv`, 'text/csv');
            }}, 300);
            setTimeout(() => {{
                downloadFile(feedbackReport, `grading_feedback_report_${{timestamp}}.txt`, 'text/plain');
            }}, 600);

            setTimeout(() => {{
                alert(`Exported 3 files:\\n1. Detailed grades CSV\\n2. Canvas upload CSV\\n3. Feedback report (TXT)`);
            }}, 900);
        }}

        function downloadFile(content, filename, mimeType) {{
            const blob = new Blob([content], {{ type: mimeType }});
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = filename;
            a.click();
            window.URL.revokeObjectURL(url);
        }}
    </script>
</body>
</html>"""

    return html

def main():
    if len(sys.argv) != 2:
        print("Usage: python grading_assistant.py <canvas_export.csv>")
        print("\nExample:")
        print("  python grading_assistant.py 'Week_1/assignments/assignment1/grading/submissions.csv'")
        sys.exit(1)

    csv_path = Path(sys.argv[1])

    if not csv_path.exists():
        print(f"Error: File not found: {csv_path}")
        sys.exit(1)

    print("="*80)
    print("H524 AI-Powered Grading Assistant")
    print("="*80)

    # Process submissions
    students_data, questions = process_submissions(csv_path)

    # Generate HTML
    print("\nGenerating HTML interface...")
    html_content = generate_html(students_data, questions)

    # Save HTML to same directory as input CSV
    output_dir = csv_path.parent
    output_html = output_dir / f"grading_assistant_{datetime.now().strftime('%Y%m%d_%H%M%S')}.html"

    with open(output_html, 'w', encoding='utf-8') as f:
        f.write(html_content)

    print(f"\n{'='*80}")
    print(f"SUCCESS! Created: {output_html}")
    print(f"{'='*80}")
    print(f"\nHow to use:")
    print(f"1. Open {output_html.name} in your browser")
    print(f"2. Review AI grades and feedback for each student")
    print(f"3. Edit scores/feedback as needed")
    print(f"4. Click 'Export Grades' to generate CSV files")
    print(f"5. All exported files will be saved to: {output_dir}")
    print(f"\nAI has graded {len(students_data)} students across {len(questions)} questions!")
    print(f"{'='*80}\n")

if __name__ == "__main__":
    main()
