# Student Data Protection - CRITICAL

## ⚠️ NEVER COMMIT STUDENT DATA TO GITHUB ⚠️

This repository has multiple layers of protection to prevent student data from being committed to GitHub.

## Protection Layers

### 1. `.gitignore` (Primary Protection)
The `.gitignore` file blocks these patterns:
- `*Report.csv` - All Canvas report exports
- `*Student Analysis*.csv` - Student analysis reports
- `H524*Week*Report*.csv` - Week-specific reports
- `canvas_upload*.csv` - Canvas grade upload files
- `canvas_final_grades.csv` - Final grade exports
- `**/grading/*.csv` - Any CSV in grading folders
- `**/assignments/*.csv` - Any CSV in assignment folders
- `**/assignments/**/*.csv` - Any CSV in assignment subfolders
- `week*_canvas_quiz.csv` - Quiz export files
- `graded_results*.json` - Grading results with student data
- `grading_interface*.html` - Grading interface files
- `trap_phrases_report.json` - Academic integrity reports

### 2. Pre-Commit Hook (Secondary Protection)
Location: `.git/hooks/pre-commit`

**What it does:**
- Scans ALL files being committed for student data patterns
- Blocks commits containing files matching dangerous patterns
- Checks CSV file contents for student identifying information
- Shows clear error messages with instructions

**How to test it:**
```bash
# This should be BLOCKED:
echo "test" > graded_results.json
git add -f graded_results.json
git commit -m "Test"
# Result: ❌ COMMIT BLOCKED - STUDENT DATA DETECTED!
```

## Files That Must NEVER Be Committed

### Canvas Exports
- Any file with "Report.csv" in the name
- Any file with "Student Analysis" in the name
- Canvas quiz exports from SpeedGrader
- Canvas gradebook exports

### Grading Files
- `graded_results_complete.json` - Contains all student answers and grades
- `grading_interface.html` - Interactive grading interface with student data
- `trap_phrases_report.json` - Academic integrity scan results
- Any CSV from the grading workflow

### Personal Information
- Files containing student names
- Files containing student ID numbers (SIS ID)
- Files containing student email addresses
- Files containing student grades

## What CAN Be Committed

✅ Course materials (.tex, .pdf, .R files)
✅ Blank templates and rubrics
✅ Example datasets (anonymized)
✅ Verification scripts (without student data)
✅ Documentation and instructions

## If Student Data Was Accidentally Committed

**IMMEDIATE ACTION REQUIRED:**

1. **Do NOT push to GitHub if not already pushed**
2. Remove from git history:
   ```bash
   git rm --cached <file>
   git commit --amend
   ```

3. **If already pushed to GitHub:**
   - Contact GitHub support to purge the commit from history
   - Rotate any credentials in the file
   - Notify affected students per FERPA requirements
   - Document the incident

## Weekly Verification Checklist

Before pushing to GitHub:
```bash
# 1. Check for tracked student data CSVs
git ls-files "*.csv" | grep -i "report\|student\|graded\|canvas_upload"

# 2. Check for grading files
git ls-files | grep -E "graded_results|grading_interface|trap_phrases"

# 3. Verify gitignore is working
git status --ignored | grep "Report.csv"

# 4. Test pre-commit hook
# (Try to commit a test grading file - should be blocked)
```

All checks should show NO student data files!

## FERPA Compliance

This protection system helps maintain FERPA compliance by:
- Preventing unauthorized disclosure of student records
- Protecting student privacy through technical controls
- Maintaining audit trail of protection measures
- Documenting incident response procedures

## Questions?

If you're unsure whether a file contains student data:
- **Default to NOT committing it**
- Check if file contains names, IDs, emails, or grades
- Verify the file is on the "safe to commit" list
- When in doubt, ask or leave it out

---

**Last Updated:** 2025-11-05
**Protection Level:** Multiple layers active
**Status:** ✅ Student data protection verified
