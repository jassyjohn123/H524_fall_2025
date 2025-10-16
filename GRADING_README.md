# H524 Grading Assistant

Generic AI-powered grading assistant for all H524 assignments.

## Features

- **Auto-detects questions** from Canvas CSV export
- **AI pre-grades** all responses with feedback
- **Interactive HTML interface** for review and editing
- **Exports 3 files**:
  - Canvas upload CSV (for bulk grade import)
  - Detailed grades CSV (for your records)
  - Feedback report TXT (printable report)
- **Trap phrase detection** built-in (checks for students testing if you're reading)

## Usage

### Step 1: Download Canvas Submissions

1. Go to Canvas → Assignment → Download Submissions
2. Export as CSV (Student Analysis Report)
3. Save the CSV file (e.g., in `Week_X/assignments/assignmentX/grading/`)

### Step 2: Run the Grading Assistant

```bash
cd /Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025

python grading_assistant.py "path/to/canvas_export.csv"
```

**Example:**
```bash
python grading_assistant.py "Week_1/assignments/assignment1/grading/H524_Assignment1_Student_Analysis.csv"
```

### Step 3: Review and Edit Grades

1. Open the generated HTML file in your browser
2. Review each student's responses and AI-generated grades
3. Edit scores and feedback as needed (modified questions turn yellow)
4. Use Next/Previous buttons to navigate between students

### Step 4: Export Grades

1. Click "Export Grades" button
2. Three files will download to the same directory as the input CSV:
   - `grading_canvas_upload_YYYYMMDD.csv` - Upload to Canvas
   - `grading_detailed_YYYYMMDD.csv` - Detailed records
   - `grading_feedback_report_YYYYMMDD.txt` - Printable report

### Step 5: Upload to Canvas

**Option A: Bulk Upload (recommended)**
1. Canvas → Grades → Import
2. Upload `grading_canvas_upload_YYYYMMDD.csv`
3. All scores uploaded at once!

**Option B: Individual Feedback**
1. Use "Copy All Feedback" button for each student
2. Paste into Canvas SpeedGrader comments

## How It Works

### Auto-Detection
- Automatically finds all questions in the Canvas CSV
- Detects question types (MC, short answer, essay, R code)
- Extracts point values for each question

### AI Grading Logic

**Multiple Choice:**
- AI gives 95% credit if answer exists (you verify correctness)

**Short Answer:**
- Word count based: 30+ words = 95%, 15-30 = 90%, 5-15 = 80%, <5 = 60%

**Essay/R Code:**
- Detects R code: Full credit if code present
- Otherwise: Length-based (200+ words = 92%, 100-200 = 88%, etc.)
- Looks for good practices (comments, proper functions)

### Trap Phrase Detection (Per CLAUDE.md)

The system checks for phrases like:
- "you're not reading this"
- "using AI to grade"
- "bet you didn't read"
- "if anyone reads this"

These are flagged in feedback for your review.

## Output Files

### 1. Canvas Upload CSV
```
Student,ID,SIS User ID,SIS Login ID,Section,Assignment Score
Points Possible,,,,,75.00
"Smith, John","12345","12345","","","68.50"
```
**Use:** Import directly into Canvas Gradebook

### 2. Detailed Grades CSV
```
Student,ID,Q1_Score,Q1_Feedback,Q2_Score,Q2_Feedback,...,Total_Score,Total_Possible,Percentage
"Smith, John","12345",9.5,"Good explanation...",8.0,"Needs more detail...",68.5,75,91.3
```
**Use:** Your grading records, analysis, grade appeals

### 3. Feedback Report TXT
```
H524 Assignment Grading Report
Generated: 2025-10-14 18:30:00
================================================================================

John Smith (ID: 12345)
Total: 68.5/75 (91.3%)
--------------------------------------------------------------------------------

Q1: Distribution Analysis
Score: 9.5/10
Feedback: Good explanation of skewness. Could mention mean vs median relationship.

Q2: R Programming Exercise
Score: 8.0/10
Feedback: R code provided - excellent. Good: includes comments

...
```
**Use:** Print for offline review, grade discussions

## Tips

- **Review MC carefully** - AI gives partial credit, you verify
- **Modify as needed** - Yellow highlight shows changed questions
- **Save regularly** - Browser auto-saves your edits to the HTML file
- **Export early** - Generate CSVs even if you're not done (you can re-export)
- **Check trap phrases** - Look for students testing if work is being read

## Customization

To adjust grading logic for specific assignments, edit the `grade_question()` function in `grading_assistant.py` (lines 95-145).

## Troubleshooting

**"No questions detected"**
- Ensure CSV is from Canvas "Student Analysis Report" export
- Check that question columns follow format: "ID: Question Text"

**"Points incorrect"**
- Manually verify total points in the HTML interface
- Edit individual scores as needed

**"Export not working"**
- Check browser allows downloads
- Files save to same directory as input CSV

## Notes

- All grading is AI-assisted but requires human review
- Always verify scores before uploading to Canvas
- Students can appeal grades - keep detailed CSV for records
- HTML file contains all data - you can re-open it later to make changes
