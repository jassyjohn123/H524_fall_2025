# H524 Week 1 Homework Assignment: Introduction to Biostatistics and Data Visualization

**Due Date:** [Insert due date]
**Points:** 100 points
**Format:** Canvas Online Assignment
**Estimated Time:** 2-3 hours

## Instructions

This assignment covers material from Week 1 lectures on introduction to biostatistics, data types, descriptive statistics, and data visualization. The assignment includes multiple choice questions, short answer questions, and practical R exercises.

**Important Notes:**
- Show all R code where requested
- Use the FEV1 and childhood injury datasets provided in class materials
- AI tools may be used for assistance, but you must understand and verify all answers
- Partial credit available for short answer and R coding questions

**R Code Submission Format:**
For all R programming questions, you may either:
- Copy and paste your R code directly into the Canvas text box using a monospace font (Courier or similar), OR
- Upload a Word document with your R code formatted in a non-proportional font such as Courier
- Always include both your code AND the output/results

---

## Part A: Multiple Choice Questions (40 points, 4 points each)

**Question 1:** The FEV1 dataset used in class contains lung function measurements from how many subjects?
a) 10 subjects
b) 13 subjects
c) 15 subjects
d) 20 subjects

**Question 2:** According to the childhood injury deaths data presented in class, approximately what percentage of deaths are due to motor vehicle accidents?
a) 25%
b) 35%
c) 48%
d) 60%

**Question 3:** What type of variable is "gender" in the FEV1 dataset?
a) Quantitative continuous
b) Quantitative discrete
c) Qualitative nominal
d) Qualitative ordinal

**Question 4:** When data is highly skewed (has a long tail in one direction), which measure of central tendency is generally preferred?
a) Mean, because it uses all data points
b) Median, because it's less affected by extreme values
c) Mode, because it shows the most common value
d) Standard deviation, because it measures spread

**Question 5:** Box plots are particularly useful because they:
a) Show the exact frequency of each data value
b) Display the five-number summary and outliers clearly
c) Are easier to create by hand than histograms
d) Work only with categorical data

**Question 6:** In epidemiology, what does an SMR > 100 indicate?
a) Lower mortality than expected
b) Higher mortality than expected
c) Average mortality rate
d) Invalid calculation

**Question 7:** In R, which function creates a frequency table showing counts for each category?
a) `summary()`
b) `table()`
c) `count()`
d) `freq()`

**Question 8:** The key difference between bar charts and histograms is:
a) Bar charts show categorical data with gaps between bars; histograms show continuous data with no gaps
b) Bar charts are always vertical; histograms are always horizontal
c) Bar charts show counts; histograms show percentages
d) Bar charts use colors; histograms are black and white

**Question 9:** Based on the AI guidelines presented in class, the most important principle for using AI in biostatistics is:
a) Use AI only for simple calculations
b) AI should enhance understanding, not replace critical thinking
c) Avoid AI completely in academic work
d) Use AI only for creating graphs

**Question 10:** According to the lecture on AI pitfalls, which is NOT a concern when using AI for statistical analysis?
a) AI may use outdated statistical methods
b) AI might not understand biomedical context
c) AI may not check statistical assumptions
d) AI requires expensive commercial software

---

## Part B: Short Answer Questions (30 points)

**Question 11 (10 points):** Data Types Classification
For each variable below, identify whether it is quantitative or qualitative, and if quantitative, whether it's discrete or continuous. If qualitative, specify if it's nominal or ordinal. Provide a brief justification for each classification (2 points each):

a) FEV1 measurement in liters (from our class dataset)
b) Number of childhood injury deaths per state
c) Cause of injury (motor vehicle, drowning, fire, etc.)
d) Pain severity rating (1=mild, 5=severe)
e) Patient's primary language (English, Spanish, French, etc.)

**Question 12 (10 points):** Descriptive Statistics Analysis
Using the actual FEV1 dataset from class (n=13), examine the histogram below and the descriptive statistics:

*(FEV1 Histogram will be provided in Canvas - refer to class materials)*

**Descriptive Statistics:**
- Mean: 2.88 liters
- Median: 2.80 liters
- Range: 1.90 liters (4.05 - 2.15)
- Standard deviation: 0.58 liters

a) Looking at both the histogram and the mean vs. median values, what does this suggest about the distribution's shape? (3 points)
b) Given that this data represents adolescents with asthma, explain why we might expect this type of distribution. (4 points)
c) Which measure (mean or median) would be more appropriate to report for this dataset and why? (3 points)

**Question 13 (10 points):** Choosing Appropriate Visualizations
Refer to the childhood injury bar chart below, then consider the researcher's different datasets:

*(Childhood Injury Deaths by Cause bar chart will be provided in Canvas - refer to class materials)*

A researcher wants to present injury data to a public health conference. She has these datasets:

- Dataset 1: Number of injury deaths by cause (like the chart above)
- Dataset 2: Age at time of injury for 150 fatal accidents (continuous variable)
- Dataset 3: Injury severity ratings (mild, moderate, severe, fatal) for 500 cases

a) Explain why the bar chart above is appropriate for Dataset 1 and identify one strength of this visualization. (3 points)
b) For Dataset 2, recommend a different visualization that shows the distribution shape and explain why. (3 points)
c) For Dataset 3, explain why a pie chart might NOT be the best choice despite having categories. (4 points)

---

## Part C: R Programming Exercises (30 points)

**Question 14 (15 points):** R Data Analysis with FEV1 Dataset
Using the FEV1 dataset from class materials (available in week1_lecture_code.R):

a) Write R code to load the data and calculate the mean FEV1 by gender. Include the output. (5 points)
b) Use the `summary()` function on the FEV1 variable and interpret what the 1st and 3rd quartiles tell us about the data. (5 points)
c) Create a frequency table for gender and calculate what percentage of subjects are female. Show your calculation. (5 points)

**Code Submission Requirements:**
- Include ALL R code you used
- Copy and paste the actual output from R
- Provide brief interpretations as requested
- Use monospace font (Courier) if pasting into Canvas

**Question 15 (15 points):** Creating Professional Visualizations
Using the childhood injury dataset from class, create a chart similar to the one shown in Question 13:

a) Write R code to create a well-formatted bar chart of injury causes. Your chart should include:
   - Proper title and axis labels
   - Readable text (consider text size/rotation if needed)
   - Professional appearance (8 points)

b) Based on your chart, identify the leading cause of childhood injury deaths and calculate its percentage of total deaths. (4 points)

c) Explain one limitation of using a bar chart for this data and suggest an alternative visualization that might address this limitation. (3 points)

**Code and Chart Submission:**
- Submit your complete R code
- Include a copy of your chart (screenshot or save as image)
- If uploading as Word document, use Courier font for code

---

## Bonus Question (5 points)

**Question 16:** Critical Thinking About AI in Biostatistics
A public health researcher wants to use AI to analyze a large dataset of electronic health records to identify risk factors for diabetes.

a) Describe two specific ways AI could be helpful in this analysis. (2 points)
b) Identify two potential problems or limitations the researcher should watch for when using AI. (2 points)
c) What type of human oversight would be essential to ensure valid results? (1 point)

*Base your answer on the AI principles discussed in class.*

---

## Submission Guidelines

1. **Canvas Text Entry:** Type all answers directly into Canvas
2. **R Code Formatting:**
   - Option A: Copy and paste code directly into Canvas using monospace font (Courier)
   - Option B: Upload a Word document with R code in non-proportional font (Courier)
   - Always include both your R code AND the output
3. **Show Your Work:** Include all calculations and reasoning
4. **Visual Elements:** Some questions include charts/graphs - refer to these when answering

## Grading Rubric

**Multiple Choice (40 points):** 4 points each, auto-graded

**Short Answer Questions (30 points):**
- Full Credit: Complete, accurate answer with clear reasoning
- Partial Credit: Minor errors or incomplete explanation
- Minimal Credit: Major errors but shows some understanding

**R Programming (30 points):**
- Code Correctness (70%): Does the code run and produce correct results?
- Code Style (20%): Is the code readable and well-commented?
- Interpretation (10%): Are results properly interpreted?

**Bonus (5 points):** Thoughtful response demonstrating understanding of AI's role in statistics

---

## Answer Key and AI Grading Notes

*[This section would be separate for instructor use]*

### Multiple Choice Answer Key:
1. b (13 subjects), 2. c (48%), 3. c (qualitative nominal), 4. b (median for skewed data), 5. b (five-number summary and outliers), 6. b (higher mortality than expected), 7. b (table function), 8. a (categorical vs continuous data), 9. b (enhance understanding), 10. d (software cost not mentioned as pitfall)

### AI Grading Prompts:
For automated grading assistance, use these prompts with student responses:

**Short Answer Grading Prompts:**

*Question 11 (Data Types):* "Evaluate this response on data type classification (10 points total). Award 2 points per variable for: (1) Correct classification (quantitative/qualitative, discrete/continuous, nominal/ordinal), (2) Sound justification. Look for understanding of the distinctions between data types."

*Question 12 (Descriptive Statistics):* "Grade this interpretation of FEV1 statistics using both histogram and numerical summaries (10 points). Award points for: (1) Correct interpretation of mean vs median AND histogram shape (3 pts), (2) Reasonable explanation for distribution pattern in asthma patients (4 pts), (3) Appropriate choice of central tendency measure with justification (3 pts). Look for integration of visual and numerical evidence."

*Question 13 (Visualizations):* "Assess this visualization analysis response (10 points). Look for: (1) Understanding of why bar chart works for injury data with specific strength identified (3 pts), (2) Suitable choice for continuous age distribution with rationale (3 pts), (3) Valid critique of pie chart limitations for ordinal severity data (4 pts). Student should reference the provided chart and demonstrate understanding of visualization principles."

**R Code Grading Prompts:**

*Question 14 (R Analysis):* "Evaluate this R code submission (15 points) for: (1) Correct code that loads data and produces accurate results (8 pts), (2) Proper interpretation of summary statistics, especially quartiles (4 pts), (3) Complete calculations with clear presentation (3 pts). Code should be readable and output should be included."

*Question 15 (R Visualization):* "Grade this visualization assignment (15 points) for: (1) Functional R code that creates appropriate bar chart with professional formatting (8 pts), (2) Correct identification and calculation of leading cause percentage (4 pts), (3) Thoughtful analysis of bar chart limitations with reasonable alternative suggestion (3 pts). Chart image/output should be included."

### Expected R Code Solutions:

**Question 14:**
```r
# Load/create the FEV1 data first
source("week1_lecture_code.R")  # or copy data creation code

# a) Mean FEV1 by gender
aggregate(fev1_liters ~ gender, data = fev1_data, mean)
# Expected output: Female ~2.70, Male ~3.10

# b) Summary statistics with interpretation
summary(fev1_data$fev1_liters)
# Q1 = 2.50, Q3 = 3.15 means 50% of values fall between these

# c) Gender frequency and percentage
gender_table <- table(fev1_data$gender)
gender_table
prop.table(gender_table) * 100
# Female: 6/13 = 46.2%
```

**Question 15:**
```r
# Create professional bar chart
injury_counts <- c("Motor Vehicle" = 48, "Drowning" = 14, "Fire" = 12,
                   "Homicide" = 7, "Other" = 19)

# a) Professional bar chart
barplot(injury_counts,
        main = "Leading Causes of Childhood Injury Deaths",
        ylab = "Percentage of Deaths",
        xlab = "Cause of Injury",
        col = "lightblue",
        las = 2)  # Rotate labels if needed

# b) Leading cause analysis
max(injury_counts)  # Motor Vehicle: 48%

# c) Limitation: Bar chart doesn't show relationships between causes
# Alternative: Pie chart shows proportions better, or stacked bar by age group
```