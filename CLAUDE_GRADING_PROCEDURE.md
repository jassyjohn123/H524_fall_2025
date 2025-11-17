# Claude Code Grading Procedure (Internal)

## When User Asks: "Grade X with Y"

### Step 1: Prepare Data
```bash
python ai_grader.py prepare <csv_path> <rubric_path>
```
This creates `pending_grading.json` with all student data.

### Step 2: Read the Grading Package
```
Read pending_grading.json
```
Review:
- Number of students
- Questions detected
- Rubric criteria
- Sample answers

### Step 3: Grade Each Student

For each student, for each question:

1. **Read the question text**
2. **Read the student's answer**
3. **Apply rubric criteria**
4. **Determine score** (out of max points)
5. **Write specific feedback**

**Grading Principles:**
- Actually understand the content, don't just pattern match
- Apply rubric criteria precisely
- Give partial credit for partial understanding
- Provide constructive, specific feedback
- Identify both strengths and areas for improvement

**Feedback Format:**
```
"Correct use of t.test() function and proper df=29. Interpretation
is clear and in context. However, confidence level should be stated
as 95%, not 0.95 in your write-up. -0.5 points for notation."
```

### Step 4: Create Graded Results JSON

Structure:
```json
{
  "csv_path": "...",
  "rubric_path": "...",
  "graded_at": "2025-10-19T10:30:00",
  "questions": {
    "1": {"id": "1", "title": "...", "points": 10},
    ...
  },
  "students": [
    {
      "name": "Alice Anderson",
      "id": "12345",
      "questions": [
        {
          "id": "1",
          "full_title": "Calculate a 95% CI...",
          "answer": "I used t.test()...",
          "points_possible": 10,
          "score": 9.5,
          "feedback": "Excellent work! Correct method..."
        },
        ...
      ]
    },
    ...
  ]
}
```

Save as `graded_results.json` in same directory as CSV.

### Step 5: Build HTML Interface
```bash
python ai_grader.py build <graded_results.json>
```
This generates the HTML interface.

### Step 6: Open in Browser
```bash
open <output_html_file>
```

### Step 7: Confirm to User
```
✓ Graded 30 students across 5 questions
✓ Generated HTML interface: grading_interface_20251019_103000.html
✓ Opened in browser

Review the grades and feedback. You can:
- Modify any scores
- Edit any feedback
- Click "Export Grades" when ready
- Upload CSV to Canvas
```

## Example Grading Thought Process

### Question: "Calculate the 95% confidence interval for mean height"

**Student Answer:**
```
I used the t.test function:
t.test(heights, conf.level=0.95)

The 95% confidence interval is (64.2, 68.8) inches.

This means we are 95% confident that the true mean height
of all students is between 64.2 and 68.8 inches.
```

**My Analysis:**
- ✅ Used correct function (t.test)
- ✅ Set correct confidence level
- ✅ Extracted CI correctly
- ✅ Interpretation is in context
- ✅ States confidence level correctly
- ✅ Uses appropriate units

**Score: 10/10**

**Feedback:**
```
Perfect! You correctly used t.test() with the appropriate
confidence level, extracted the CI, and provided a complete
interpretation in context. Well done!
```

---

### Question: "Calculate the 95% confidence interval for mean height"

**Student Answer:**
```
mean(heights) + c(-1, 1) * 1.96 * sd(heights) / sqrt(length(heights))
[1] 64.8 68.2
```

**My Analysis:**
- ❌ Used z (1.96) instead of t
- ✅ Formula structure is correct
- ✅ Shows understanding of CI concept
- ❌ No interpretation provided
- ❌ Used sd() instead of proper SE from t.test

**Score: 6.5/10**

**Feedback:**
```
You show good understanding of the CI formula structure. However,
you should use the t-distribution (qt(0.975, n-1)) instead of z=1.96
since we're working with sample standard deviation. Also, while your
calculation is shown, you need to interpret the result in context.

Deductions:
- Used z instead of t: -2 points
- No interpretation: -1.5 points
```

---

### Question: "What is the margin of error?"

**Student Answer:**
```
The margin of error is the amount of error we allow.
```

**My Analysis:**
- ❌ Circular definition, no substance
- ❌ No formula
- ❌ No connection to confidence level
- ❌ No numeric answer if one was expected

**Score: 1/5**

**Feedback:**
```
This definition is too vague. The margin of error is specifically
the distance from the sample statistic to the edge of the confidence
interval, calculated as ME = t* × SE. You should explain what it
represents quantitatively and how it relates to confidence level.
```

## Rubric Application Examples

### Rubric Says:
```
Q1 (10 points):
- Correct t-critical value: 3 pts
- Standard error calculation: 3 pts
- CI formation: 2 pts
- Interpretation: 2 pts
```

### Student Answer:
```
SE = 2.5
t = 2.045
CI = 128.4 ± 5.11 = (123.29, 133.51)

We are 95% confident the true mean is in this range.
```

**My Grading:**
- t-critical: ✓ 3/3 pts (2.045 is correct for df=24)
- SE: ✓ 3/3 pts (correct calculation shown)
- CI formation: ✓ 2/2 pts (correct arithmetic)
- Interpretation: ✓ 1.5/2 pts (correct but should state "mean BP" not just "mean")

**Total: 9.5/10**

**Feedback:**
```
Excellent calculations! All values are correct. Your interpretation
is good but could be more specific - state "mean blood pressure" rather
than just "true mean". -0.5 for incomplete interpretation.
```

## Quality Control

Before finalizing grades:
- ✅ Verify I actually understood each answer (not just keyword matching)
- ✅ Applied rubric consistently across all students
- ✅ Feedback is specific and helpful
- ✅ Scores add up correctly
- ✅ No student got 0 unless they truly submitted nothing
- ✅ Full credit students truly earned it

## Common Pitfalls to Avoid

❌ **Pattern matching**: Don't just look for keywords like "mean()"
✅ **Understand**: Actually verify the logic and correctness

❌ **Generic feedback**: "Good job!" or "Needs work"
✅ **Specific feedback**: "You correctly used t.test() but forgot to check normality assumptions"

❌ **All or nothing**: 10/10 or 0/10
✅ **Partial credit**: 6.5/10 for partial understanding

❌ **Inconsistency**: Grading same error differently across students
✅ **Consistency**: Same error = same deduction for everyone

## Final Check

Before saying "Done":
- [ ] All students graded
- [ ] All questions graded
- [ ] Scores reasonable (not all 10s, not all 5s)
- [ ] Feedback meaningful
- [ ] JSON file saved
- [ ] HTML generated
- [ ] Browser opened
- [ ] User informed
