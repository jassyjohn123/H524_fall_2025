# AI Grading Assistant Prompts for Week 1 Homework

## Instructions for Using AI to Grade Assignments

These prompts are designed to help you quickly and consistently grade student responses using AI tools like Claude, ChatGPT, or other AI assistants.

---

## Short Answer Questions Grading

### Question 11: Data Types (10 points total, 2 points each)

**AI Grading Prompt:**
```
Please grade this student's response to a biostatistics data types question. The student should classify these variables and justify their answers:

a) Blood pressure reading (e.g., 120/80 mmHg)
b) Pain rating on a scale of 1-10
c) Type of cancer (lung, breast, colon, etc.)
d) Number of hospital visits in a year
e) Patient satisfaction rating (poor, fair, good, excellent)

Expected answers:
a) Quantitative continuous - measured values with decimal precision
b) Quantitative discrete OR Qualitative ordinal - depends on interpretation
c) Qualitative nominal - categories with no natural order
d) Quantitative discrete - counting whole numbers
e) Qualitative ordinal - categories with meaningful order

Score each part 0-2 points:
- 2 points: Correct classification with appropriate justification
- 1 point: Correct classification with weak/unclear justification OR minor classification error with good reasoning
- 0 points: Incorrect classification or no justification

Student Response: [PASTE STUDENT ANSWER HERE]

Provide: Total score out of 10, breakdown by part, and brief feedback.
```

### Question 12: Distribution Interpretation (10 points)

**AI Grading Prompt:**
```
Please grade this biostatistics student's interpretation of descriptive statistics.

Question: The FEV1 data has a mean of 2.88 liters and a median of 2.80 liters.
a) What does this suggest about the distribution shape? (5 points)
b) Why might this pattern occur in lung function data? (5 points)

Expected answers:
a) Right-skewed/positively skewed distribution (mean > median indicates this)
b) Some patients may have severely reduced lung function (outliers on low end), or some may have better than typical function, creating the skew

Scoring:
Part a (5 points):
- 5 points: Correctly identifies right/positive skew with explanation of mean>median
- 3-4 points: Identifies skew correctly but explanation unclear
- 1-2 points: Identifies relationship but misses skew direction
- 0 points: Incorrect or no answer

Part b (5 points):
- 5 points: Plausible biological explanation related to lung function variation
- 3-4 points: General explanation that makes sense but not specific to lungs
- 1-2 points: Weak explanation with some logical elements
- 0 points: Incorrect or no explanation

Student Response: [PASTE STUDENT ANSWER HERE]

Provide: Score for each part, total out of 10, and constructive feedback.
```

### Question 13: Visualization Choice (10 points)

**AI Grading Prompt:**
```
Grade this student's response about choosing appropriate data visualization.

Question: You are analyzing treatment outcomes for 200 patients with three treatments (A, B, C) showing distribution of recovery times for each treatment.
a) What visualization would be most appropriate? (5 points)
b) Justify your choice and explain insights it would provide. (5 points)

Expected answers:
a) Box plots, histograms (by group), violin plots, or side-by-side plots
b) Should mention comparing distributions across groups, seeing variability, identifying outliers, comparing medians/ranges

Scoring:
Part a (5 points):
- 5 points: Appropriate choice (box plots, grouped histograms, violin plots)
- 3-4 points: Reasonable choice but not optimal (like bar charts for means)
- 1-2 points: Poor choice but shows some understanding
- 0 points: Inappropriate choice or no answer

Part b (5 points):
- 5 points: Clear justification mentioning group comparison and distribution insights
- 3-4 points: Good justification but missing some key elements
- 1-2 points: Basic justification with logical elements
- 0 points: Poor or no justification

Student Response: [PASTE STUDENT ANSWER HERE]

Provide: Score breakdown, total out of 10, and feedback on visualization choice.
```

---

## R Code Grading

### Question 14: Basic R Operations (15 points)

**AI Grading Prompt:**
```
Grade this R code submission for basic operations with the FEV1 dataset.

Requirements:
a) Calculate mean FEV1 by gender (5 points)
b) Create summary of FEV1 variable (5 points)
c) Count male vs. female subjects (5 points)

Expected solutions:
a) aggregate(fev1_liters ~ gender, data = fev1_data, mean) OR equivalent
b) summary(fev1_data$fev1_liters) OR equivalent
c) table(fev1_data$gender) OR equivalent

Grading criteria for each part:
- 5 points: Correct code that produces right answer
- 3-4 points: Minor syntax errors but approach is correct
- 1-2 points: Major errors but shows understanding of concept
- 0 points: Incorrect approach or missing

Also consider:
- Code readability and comments (+/- 1 point total)
- Proper interpretation of results (+/- 1 point total)

Student Code: [PASTE STUDENT CODE HERE]

Provide: Score for each part, total out of 15, and specific feedback on code.
```

### Question 15: Data Visualization with R (15 points)

**AI Grading Prompt:**
```
Grade this R code for creating data visualization with the childhood injury dataset.

Requirements:
a) Bar chart of injury cause frequencies (7 points)
b) Appropriate title and axis labels (3 points)
c) Calculate percentage of motor vehicle deaths (5 points)

Expected approach:
a) table() then barplot(), or ggplot with geom_bar()
b) main="...", xlab="...", ylab="..." or ggplot labels
c) prop.table(table()) * 100, should get 48%

Grading:
Part a (7 points):
- 7 points: Correct bar chart code
- 5-6 points: Chart works but minor issues
- 3-4 points: Major issues but recognizable attempt
- 0-2 points: Doesn't work or wrong approach

Part b (3 points):
- 3 points: Proper title and both axis labels
- 2 points: Title and one axis label OR good title only
- 1 point: Minimal labeling attempt
- 0 points: No labels

Part c (5 points):
- 5 points: Correct calculation showing 48%
- 3-4 points: Right approach, minor calculation error
- 1-2 points: Wrong approach but logical attempt
- 0 points: Missing or completely wrong

Student Code: [PASTE STUDENT CODE HERE]

Provide: Detailed score breakdown, total out of 15, and code improvement suggestions.
```

---

## Bonus Question Grading

### Question 16: AI and Biostatistics (5 points)

**AI Grading Prompt:**
```
Grade this bonus response about AI applications in biostatistics.

Question: Describe a scenario where AI might be helpful in biostatistics analysis, but explain what human oversight would be necessary. Provide a concrete example from public health or medicine.

Look for:
- Specific, realistic scenario (not vague)
- Understanding of AI capabilities and limitations
- Appropriate human oversight considerations
- Concrete example from health/medicine field

Scoring (5 points total):
- 5 points: Excellent response with specific example, clear AI role, and thoughtful oversight
- 4 points: Good response missing one key element
- 3 points: Adequate response but lacks depth or specificity
- 2 points: Basic understanding but weak example or oversight
- 1 point: Shows minimal understanding
- 0 points: Off-topic or demonstrates misunderstanding

Student Response: [PASTE STUDENT ANSWER HERE]

Provide: Score out of 5 and brief feedback on their understanding of AI in biostatistics.
```

---

## Quick Grading Workflow

1. **Multiple Choice**: Auto-graded by Canvas (40 points)
2. **Short Answer**: Use prompts above, grade each question separately
3. **R Code**: Test code if possible, use grading prompts for evaluation
4. **Bonus**: Use bonus prompt for consistent scoring

**Total Time Estimate**: 5-8 minutes per assignment with AI assistance