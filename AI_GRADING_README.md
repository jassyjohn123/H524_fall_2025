# AI-Powered Grading System - Quick Start

## What Changed?

You now have **REAL AI grading** using Claude Code, not just word-count heuristics!

### Before (Heuristic Grading)
```
Script counts words → "30+ words = 95%" → Generic feedback
❌ No understanding of content
❌ Can't detect wrong methods
❌ Generic feedback: "Good response"
```

### After (Real AI Grading)
```
Claude reads answer → Understands content → Applies rubric → Specific feedback
✅ Semantic understanding
✅ Detects conceptual errors
✅ Specific feedback: "Used z instead of t, deduct 2pts per rubric"
```

## Quick Start (30 seconds)

### 1. Create a rubric (copy template)
```bash
cp sample_rubric.txt Week_5/rubric.txt
# Edit to match your assignment
```

### 2. Export from Canvas
Download submissions as CSV from Canvas

### 3. Ask Claude to Grade
In Claude Code (this chat), type:
```
Grade Week_5/submissions.csv with Week_5/rubric.txt
```

### 4. Review & Export
- HTML interface opens
- Review/modify grades
- Click "Export Grades"
- Upload CSV to Canvas

Done! ✅

## Example Interaction

```
You: Grade Week_5/submissions.csv with Week_5/rubric.txt

Claude: Reading submissions... Found 28 students
        Reading rubric... Loaded grading criteria

        Grading Alice Anderson (1/28)
          Q1: 9.5/10 - Excellent CI calculation, minor notation issue
          Q2: 5/5 - Perfect sample size calculation
          Q3: 7/10 - Good attempt but used z instead of t (deduct 2pts per rubric)

        Grading Bob Baker (2/28)
          Q1: 10/10 - Perfect!
          Q2: 4.5/5 - Correct formula but didn't round up
          Q3: 10/10 - Thorough assumption checking

        ... [grades all 28 students] ...

        ✓ Generated: grading_interface_20251019_143022.html
        ✓ Opened in browser

        Review and modify as needed. Click "Export" when ready!

You: [Reviews in browser, makes a few tweaks, exports]
```

## Files You Need to Know

| File | Purpose |
|------|---------|
| `ai_grader.py` | Helper script (Claude calls this) |
| `sample_rubric.txt` | Copy this as your starting point |
| `AI_GRADING_WORKFLOW.md` | Complete documentation |
| `RUBRIC_FORMAT.md` | How to write rubrics |

## Writing a Rubric

### Minimal (Good Enough)
```
GRADING INSTRUCTIONS:
- Full credit requires R code + interpretation
- Deduct 30% for missing code
- Deduct 20% for missing interpretation
```

### Detailed (Better)
```
Q1 (10 points): Calculate 95% CI
- Standard error: 3 pts
- T-critical value: 2 pts
- Margin of error: 2 pts
- Final CI: 2 pts
- Interpretation: 1 pt

Common errors:
- Using z instead of t: -2 pts
- Wrong df: -1 pt
```

See `RUBRIC_FORMAT.md` for examples.

## FAQ

**Q: Do I need an API key?**
No! Uses your Claude Code subscription.

**Q: Does it cost extra?**
No! Included in your plan.

**Q: How long does grading take?**
30 students × 5 questions ≈ 2-3 minutes

**Q: Can I regrade if I change the rubric?**
Yes! Just ask Claude to grade again with the updated rubric.

**Q: What if Claude makes a mistake?**
You review everything in the HTML interface before exporting. You have full control.

**Q: Can I still modify grades?**
Yes! The HTML interface is fully editable.

**Q: Do I have to provide a rubric?**
No, but it helps. Claude will use reasonable defaults if you don't.

**Q: What about trap phrase detection?**
Built-in! Claude automatically flags suspicious phrases.

## Workflow Comparison

### Old Way (Heuristics)
1. `./grade.sh submissions.csv`
2. Open HTML
3. See word-count based grades
4. Manually review EVERYTHING (can't trust heuristics)
5. Fix many incorrect grades
6. Export
**Time: 1-2 hours of careful review**

### New Way (Real AI)
1. Ask Claude: `Grade submissions.csv with rubric.txt`
2. HTML opens with AI grades
3. Quick review (trust Claude's understanding)
4. Maybe tweak 2-3 grades
5. Export
**Time: 15-20 minutes**

## Support

- Read `AI_GRADING_WORKFLOW.md` for complete guide
- Read `RUBRIC_FORMAT.md` for rubric examples
- Just ask Claude Code if you have questions!

## Legacy Tool

The old `grading_assistant.py` still works but uses heuristics.

**Only use it for:**
- Simple effort-based assignments
- Most students get full credit anyway

**Otherwise, use real AI grading!** 🚀
