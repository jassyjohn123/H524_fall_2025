# H524 Assignment 1: Data Visualization and Descriptive Statistics

**Due Date:** [Insert due date]
**Points:** 100 points
**Format:** Canvas Online Assignment
**Estimated Time:** 2-3 hours

## Instructions

This assignment covers material from Week 1 Monday and Wednesday lectures on data visualization, descriptive statistics, and rates/standardization. The assignment includes multiple choice questions, short answer questions, and practical R exercises.

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

**Question 12 (10 points):** Geographic Health Data Analysis
Examine the choropleth map below showing diabetes prevalence rates across Pacific Northwest states:

*(Diabetes Prevalence Map will be provided in Canvas showing color-coded states)*

**Map Data:**
- Oregon: 8.2% diabetes rate
- Washington: 9.1% diabetes rate
- California: 9.7% diabetes rate
- Nevada: 10.8% diabetes rate
- Idaho: 8.9% diabetes rate

a) Based on the visual pattern in the map, which state shows the highest diabetes prevalence and what might geographic factors contribute to this pattern? (3 points)
b) If you were a public health official planning intervention programs, explain how this type of geographic visualization helps prioritize resource allocation. (4 points)
c) What additional demographic or environmental data layers would enhance this map for policy decisions? (3 points)

**Question 13 (10 points):** Multi-Panel Health Visualization Analysis
Examine the four-panel BMI analysis figure below showing comprehensive health data:

*(Four-panel BMI analysis will be provided in Canvas showing: histogram, box plots, bar chart, and scatter plot)*

**Panel Description:**
- Panel 1: BMI distribution histogram with normal curve overlay
- Panel 2: BMI comparison by gender using box plots
- Panel 3: BMI category frequencies (Underweight, Normal, Overweight, Obese)
- Panel 4: BMI vs systolic blood pressure scatter plot with regression line

a) Compare Panel 1 and Panel 2 - what different insights about BMI patterns does each visualization provide? (3 points)
b) Based on Panel 4's scatter plot, describe the relationship between BMI and blood pressure and explain its public health significance. (4 points)
c) If you could add a fifth panel to this analysis, what type of visualization would you choose and what health question would it address? (3 points)

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

**Question 15 (15 points):** Creating Geographic Health Visualizations
Using the state-level health dataset from class, create visualizations that incorporate geographic mapping:

a) Write R code to create a choropleth map showing diabetes prevalence by state. Your code should include:
   - Proper map data merging and coordinate handling
   - Color gradient mapping to health outcomes
   - Professional titles and legends
   - Use of ggplot2 and mapping packages (8 points)

b) Create a secondary visualization (scatter plot, bar chart, or dot plot) that complements your map by showing the same diabetes data in a different format. Explain why your chosen visualization adds value beyond the map. (4 points)

c) Compare the strengths and limitations of geographic vs. non-geographic representations of the same health data. When would each approach be most appropriate? (3 points)

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

*Question 12 (Geographic Analysis):* "Grade this geographic health data interpretation (10 points). Award points for: (1) Correct identification of highest prevalence state with valid geographic factors (3 pts), (2) Sound reasoning about visualization's role in resource allocation decisions (4 pts), (3) Appropriate suggestions for additional data layers with policy relevance (3 pts). Look for understanding of spatial health patterns and public health applications."

*Question 13 (Multi-Panel Analysis):* "Assess this multi-panel visualization analysis (10 points). Look for: (1) Clear comparison of histogram vs box plot insights with specific differences identified (3 pts), (2) Accurate description of BMI-blood pressure relationship with public health implications (4 pts), (3) Creative and justified suggestion for fifth panel addressing relevant health question (3 pts). Student should demonstrate understanding of how different visualization types complement each other."

**R Code Grading Prompts:**

*Question 14 (R Analysis):* "Evaluate this R code submission (15 points) for: (1) Correct code that loads data and produces accurate results (8 pts), (2) Proper interpretation of summary statistics, especially quartiles (4 pts), (3) Complete calculations with clear presentation (3 pts). Code should be readable and output should be included."

*Question 15 (Geographic Visualization):* "Grade this geographic visualization assignment (15 points) for: (1) Functional R code creating choropleth map with proper data merging, color mapping, and professional formatting (8 pts), (2) Appropriate complementary visualization with clear value-added explanation (4 pts), (3) Thoughtful comparison of geographic vs non-geographic approaches with appropriate use cases (3 pts). Both map and secondary visualization should be included."

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
# Geographic visualization with health data
library(ggplot2)
library(maps)
library(mapdata)

# a) Choropleth map of diabetes prevalence
state_health <- data.frame(
  state = c("oregon", "washington", "california", "nevada", "idaho"),
  diabetes_rate = c(8.2, 9.1, 9.7, 10.8, 8.9)
)

states_map <- map_data("state")
map_data <- merge(states_map, state_health, by.x = "region", by.y = "state")

ggplot(map_data, aes(x = long, y = lat, group = group, fill = diabetes_rate)) +
  geom_polygon(color = "white") +
  scale_fill_gradient(low = "lightblue", high = "darkred",
                      name = "Diabetes Rate (%)") +
  coord_quickmap() +
  theme_void() +
  labs(title = "Diabetes Prevalence by State")

# b) Complementary dot plot
ggplot(state_health, aes(x = diabetes_rate, y = reorder(state, diabetes_rate))) +
  geom_point(size = 4, color = "darkred") +
  labs(title = "State Diabetes Rates", x = "Diabetes Rate (%)", y = "State")

# c) Geographic shows spatial patterns; dot plot shows precise ranking
```