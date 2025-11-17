# Computational Verification Workflow - Added to CLAUDE.md

## Date: October 19, 2025

## Changes Made

Added comprehensive "Computational Verification Workflow" section to both:
1. `/Users/molitorj/AI_H524/CLAUDE.md`
2. `/Users/molitorj/AI_H220/CLAUDE.md`

## What Was Added

### 1. Core Principle
- NEVER perform mental arithmetic
- ALL calculations must use R/Python/computational tools
- Mandatory verification for all numerical results

### 2. Workflow for Creating Answer Keys

**4-Step Process:**
1. Create verification script FIRST (before writing answer key)
2. Run verification script
3. Use verified results in answer key
4. Document verification

### 3. Example File Structure
```
worksheets/
├── worksheet.tex              # Student version
├── worksheet.pdf
├── worksheet_KEY.tex          # Answer key
├── worksheet_KEY.pdf
├── verify_answers.R           # Verification script
└── README_ANSWER_KEY.txt      # Documentation
```

### 4. Verification Script Template
Complete R template provided with:
- Header formatting
- Problem-by-problem calculations
- Clear output labeling
- Verification confirmation

### 5. Best Practices
1. Create verification script before writing answer key
2. Use appropriate precision (2-4 decimal places)
3. Show intermediate steps
4. Verify complex calculations multiple ways
5. Include script in deliverables

### 6. Common Calculations to Verify
- Statistical inference (CIs, p-values, sample sizes)
- Basic arithmetic (percentages, odds ratios)
- Even simple math (5×6, √25, etc.)

### 7. Quality Control Checklist
Before finalizing any answer key:
- ✓ Verification script created and runs without errors
- ✓ All numerical answers in key match script output
- ✓ Script output saved or documented
- ✓ Verification note added to answer key
- ✓ Script file included in directory

### 8. Why This Matters
- Accuracy: Eliminates mental arithmetic errors
- Transparency: Provides audit trail
- Reproducibility: Others can verify results
- Teaching: Shows students proper workflow
- Integrity: Demonstrates rigorous approach

## Real-World Example

This workflow was demonstrated with Week 4 Confidence Intervals worksheet:

**Files Created:**
- `week4_confidence_intervals_worksheet.tex` (student version)
- `week4_confidence_intervals_worksheet_KEY.tex` (answer key)
- `verify_answers.R` (verification script)
- `README_ANSWER_KEY.txt` (documentation)

**Verification Results:**
- All 6 problems with multiple parts
- All numerical answers computed in R
- NO mental arithmetic used
- Complete audit trail provided

**Sample Verifications:**
```r
# Problem 1: SE calculation
n1 <- 20
s1 <- 8.6
se1 <- s1 / sqrt(n1)
# Result: 1.923

# Problem 3: Proportion CI
n3 <- 250
x3 <- 218
p_hat <- x3 / n3
# Result: 0.872

# Problem 4: Sample size
sigma4 <- 40
me4_target <- 6
z4 <- 1.96
n4 <- (z4 * sigma4 / me4_target)^2
# Result: 170.74 → round up to 171
```

## Benefits of This Workflow

1. **Accuracy**: Zero mental arithmetic errors
2. **Speed**: Faster than manual calculation
3. **Reproducibility**: Anyone can re-run scripts
4. **Teaching**: Students learn proper computational practices
5. **Quality**: Built-in double-checking
6. **Documentation**: Clear audit trail
7. **Professionalism**: Industry-standard approach

## Implementation Notes

- Both H524 and H220 CLAUDE.md files now have identical sections
- Applies to ALL numerical work (worksheets, exams, slides, homework)
- Required for answer keys, solution sets, worked examples
- Scripts should be preserved alongside answer keys
- Template can be adapted for Python when appropriate

## Next Steps

When creating any materials with calculations:
1. Start with verification script
2. Compute all answers
3. Write LaTeX using verified results
4. Include verification script in deliverables
5. Add verification note to document

This ensures computational integrity across all course materials.
