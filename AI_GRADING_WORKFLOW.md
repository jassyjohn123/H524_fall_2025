# AI-Powered Grading Workflow

## Overview

This workflow uses **real AI grading** where Claude actually reads and understands student answers, not just word-counting heuristics.

## What Changed

### OLD (Heuristic Grading)
```bash
./grade.sh submissions.csv
# Word counts and pattern matching
# Generic feedback
```

### NEW (Real AI Grading)
```
In Claude Code, type:
"Grade /path/to/submissions.csv with /path/to/rubric.txt"

# Claude reads all answers
# Claude applies rubric with understanding
# Claude generates specific feedback
# HTML interface opens for your review
```

## Complete Workflow

### Step 1: Create a Rubric (Optional but Recommended)

Create a text file with grading criteria:

**Example: `Week_4/rubric.txt`**
```
GRADING INSTRUCTIONS:

General:
- Full credit requires R code + interpretation + correct answer
- Deduct 30% if no R code shown
- Deduct 20% if no interpretation provided

Q1 (10 points): Calculate 95% CI for mean
- Must show SE calculation
- Must use correct t-critical value
- Must interpret in context

Q2 (5 points): Sample size calculation
- Must show formula n = (z*σ/ME)²
- Must round UP to next integer
```

See `RUBRIC_FORMAT.md` for detailed rubric writing guide.

### Step 2: Export Submissions from Canvas

1. Go to Canvas assignment
2. Click "Download Submissions" → Download as CSV
3. Save to your assignment folder (e.g., `Week_4/submissions.csv`)

### Step 3: Ask Claude to Grade

In Claude Code (where you are right now), type:

```
Grade Week_4/submissions.csv with Week_4/rubric.txt
```

Claude will:
- ✅ Read all 30 students' submissions
- ✅ Read the rubric criteria
- ✅ Grade each answer with real understanding
- ✅ Provide specific, meaningful feedback
- ✅ Generate HTML interface
- ✅ Open in your browser

### Step 4: Review and Modify Grades

The HTML interface shows:
- Each student's answers
- Claude's grades and feedback
- Editable score inputs
- Editable feedback text areas

**You can:**
- Change any score (modified questions turn yellow)
- Edit any feedback
- Navigate between students
- See live score totals

### Step 5: Export to Canvas

Click **"Export Grades"** button in HTML interface

Downloads: `grading_canvas_upload_YYYY-MM-DD.csv`

Upload to Canvas:
1. Go to Canvas Gradebook
2. Click "Import"
3. Upload the CSV file
4. Verify and confirm

Done! 🎉

## Example Session

```
You: Grade Week_4/submissions.csv with Week_4/rubric.txt

Claude: Reading submissions... Found 30 students
        Reading rubric... Loaded grading criteria

        Grading Student 1/30: Alice Anderson
          Q1: 9.5/10 - Correct CI calculation, minor notation issue
          Q2: 5/5 - Perfect sample size calculation
          Q3: 8/10 - Good normality check, but didn't discuss outliers

        Grading Student 2/30: Bob Baker
          Q1: 7/10 - Used z instead of t, deducted points per rubric
          Q2: 5/5 - Correct
          Q3: 10/10 - Excellent assumption checking

        ... [grades all 30 students] ...

        ✓ Generated HTML interface
        ✓ Opening in browser...

        Review the grades and click "Export" when ready!
```

## Advantages of AI Grading

### Real Understanding
```
Student Answer: "I calculated the mean using mean(heights)"

OLD: Sees "mean(" → Gives 95% (pattern match)
NEW: Claude sees no actual result shown → Deducts points for incomplete answer
```

### Rubric Application
```
Rubric says: "Deduct 2 points if using z instead of t"

OLD: Can't detect this nuance
NEW: Claude recognizes "used qnorm() instead of qt()" → Deducts 2 pts
```

### Specific Feedback
```
OLD: "Good response with adequate detail"
NEW: "Correct use of t.test() and proper interpretation. However, you
      used df=30 instead of df=29 (n-1). The final CI is close but
      slightly off. -0.5 points for df error."
```

### Handles Edge Cases
- Correct answer with wrong method: Partial credit
- Wrong answer with correct method: Partial credit
- Creative solutions: Recognized and rewarded
- Common misconceptions: Identified and addressed

## Rubric Tips

### Weekly Assignments (Effort-Based)
```
GRADING INSTRUCTIONS:
Be lenient - focus on whether student tried and showed reasonable effort.
Give full credit if they show R code and basic understanding.
Provide encouraging feedback.
```

### Exams (Strict Grading)
```
GRADING INSTRUCTIONS:
Be strict - follow the rubric exactly.
Deduct points for:
- Wrong statistical test (even if code runs)
- Misinterpretation of results
- Missing assumption checks
Partial credit only for clear attempt with correct method.
```

## Troubleshooting

### "I don't have a rubric yet"
No problem! Just ask:
```
Grade submissions.csv
```
Claude will use reasonable defaults and you can review/modify everything.

### "Can I regrade after seeing results?"
Yes!
1. Update your rubric
2. Ask Claude to grade again
3. Compare results
4. Export when satisfied

### "What if Claude makes a mistake?"
The HTML interface lets you:
- Change any score
- Edit any feedback
- You have full control before exporting

### "How long does grading take?"
- 30 students × 5 questions ≈ 2-3 minutes
- You spend 5-10 minutes reviewing
- Total: ~15 minutes vs hours of manual grading

## Cost

**Using Claude Code subscription**: $0 extra
- Included in your plan
- No API costs
- Unlimited grading

## Next Steps

1. ✅ Read `RUBRIC_FORMAT.md` to learn rubric writing
2. ✅ Create a rubric for your next assignment
3. ✅ Export submissions CSV from Canvas
4. ✅ Ask Claude: "Grade [csv] with [rubric]"
5. ✅ Review in HTML interface
6. ✅ Export and upload to Canvas

**Questions?** Just ask Claude Code for help!
