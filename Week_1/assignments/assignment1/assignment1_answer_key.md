# H524 Assignment 1 - Answer Key
## Introduction to Biostatistics and Data Visualization

**Total Points:** 103 points

---

## Part A: Multiple Choice Questions (40 points, 4 points each)

### Question 1: FEV1 Dataset Size
**Correct Answer:** b) 13 subjects

### Question 2: Motor Vehicle Deaths Percentage
**Correct Answer:** c) 48%

**Explanation:** Motor vehicle accidents account for 48% of childhood injury deaths in the reference dataset.

### Question 3: Variable Type - Gender
**Correct Answer:** c) Qualitative nominal

**Explanation:** Gender is a categorical variable with no natural ordering (nominal).

### Question 4: Measure of Central Tendency for Skewed Data
**Correct Answer:** b) Median, because it's less affected by extreme values

**Explanation:** Median is preferred for highly skewed data as it's resistant to outliers.

### Question 5: Box Plot Usefulness
**Correct Answer:** b) Display the five-number summary and outliers clearly

**Explanation:** Box plots show minimum, Q1, median, Q3, maximum, and outliers.

### Question 6: SMR > 100 Interpretation
**Correct Answer:** b) Higher mortality than expected

**Explanation:** Standardized Mortality Ratio > 100 indicates observed mortality exceeds expected.

### Question 7: R Function for Frequency Table
**Correct Answer:** b) `table()`

**Explanation:** The `table()` function creates frequency tables in R.

### Question 8: Bar Charts vs Histograms
**Correct Answer:** a) Bar charts show categorical data with gaps between bars; histograms show continuous data with no gaps

**Explanation:** Bar charts are for categorical data, histograms for continuous data.

### Question 9: Golden Rule for AI in Biostatistics
**Correct Answer:** b) AI should enhance understanding, not replace critical thinking

**Explanation:** AI is a tool to enhance learning, not replace it.

### Question 10: NOT an AI Pitfall
**Correct Answer:** d) AI requires expensive commercial software

**Explanation:** Cost was not mentioned as an AI pitfall in the slides. The actual concerns are outdated methods, context confusion, and assumption violations.

---

## Part B: Short Answer Questions (30 points)

### Question 11: Data Types Classification (10 points, 2 points each)

**a) FEV1 measurement in liters:**
- **Type:** Quantitative continuous
- **Justification:** Measured on a continuous scale with infinite possible values between any two points; represents a measurable quantity with decimal precision.

**b) Number of childhood injury deaths per state:**
- **Type:** Quantitative discrete
- **Justification:** Countable whole numbers (counts); cannot have fractional values.

**c) Cause of injury (motor vehicle, drowning, fire, etc.):**
- **Type:** Qualitative nominal
- **Justification:** Categories with no inherent ordering or ranking.

**d) Pain severity rating (1=mild, 5=severe):**
- **Type:** Qualitative ordinal (or discrete)
- **Justification:** Categories with meaningful order (mild to severe), but intervals between values may not be equal.

**e) Patient's primary language (English, Spanish, French, etc.):**
- **Type:** Qualitative nominal
- **Justification:** Categories with no natural ordering.

---

### Question 12: Geographic Health Data Analysis (10 points)

**Map Data:**
- Oregon: 8.2%
- Washington: 9.1%
- California: 9.7%
- Nevada: 10.8%
- Idaho: 8.9%

**a) Highest prevalence and geographic factors (3 points):**

Nevada shows the highest diabetes prevalence (10.8%). Geographic factors that might contribute:
- Desert climate with extreme temperatures may limit outdoor physical activity
- Urban sprawl in Las Vegas area may promote sedentary lifestyles
- Lower access to fresh produce in desert regions
- Socioeconomic factors and demographics unique to Nevada

**b) How visualization helps resource allocation (4 points):**

Geographic visualization helps public health officials:
- **Identify hotspots:** Quickly see which states/regions need immediate intervention
- **Prioritize funding:** Allocate more resources to high-prevalence areas (Nevada)
- **Target interventions:** Design region-specific programs based on spatial patterns
- **Track progress:** Compare maps over time to evaluate intervention effectiveness
- **Build coalition:** Show neighboring states (CA, NV) might benefit from coordinated efforts

**c) Additional data layers for policy decisions (3 points):**

Enhanced map layers could include:
- **Demographics:** Age distribution, ethnicity, income levels
- **Healthcare access:** Number of clinics, physicians per capita, insurance coverage
- **Environmental factors:** Food desert locations, walkability scores, air quality
- **Behavioral data:** Physical activity levels, dietary patterns, smoking rates
- **Social determinants:** Education levels, unemployment rates, housing stability

---

### Question 13: Multi-Panel BMI Visualization Analysis (10 points)

**Panel Description:**
- Panel 1: BMI distribution histogram with normal curve overlay
- Panel 2: BMI comparison by gender using box plots
- Panel 3: BMI category frequencies (Underweight, Normal, Overweight, Obese)
- Panel 4: BMI vs systolic blood pressure scatter plot with regression line

**a) Panel 1 vs Panel 2 comparison (3 points):**

**Panel 1 (Histogram):**
- Shows overall distribution shape and spread of BMI values
- Reveals if data is normal, skewed, or multimodal
- Good for understanding the overall population pattern
- Shows frequency/density of values across BMI range

**Panel 2 (Box plots by gender):**
- Compares BMI distributions between male and female groups
- Shows median, quartiles, and outliers for each gender
- Reveals gender differences in central tendency and variability
- Better for comparing subgroups rather than overall distribution

**b) BMI-Blood Pressure Relationship and Public Health Significance (4 points):**

**Relationship observed:**
- Positive correlation: As BMI increases, systolic blood pressure tends to increase
- Linear trend indicated by regression line
- Suggests obesity is associated with higher blood pressure

**Public Health Significance:**
- **Cardiovascular risk:** Higher BMI linked to hypertension, a major CVD risk factor
- **Intervention targets:** Weight reduction programs may help lower blood pressure
- **Screening priorities:** High BMI individuals should be monitored for hypertension
- **Prevention strategies:** Promoting healthy weight may reduce cardiovascular disease burden
- **Health costs:** Addressing obesity could reduce hypertension-related healthcare expenses

**c) Proposed fifth panel (3 points):**

**Suggested visualizations:**

**Option 1: Age vs BMI scatter plot (with color by gender)**
- **Health question:** How does the BMI-age relationship vary by gender?
- **Value:** Identifies age groups at highest risk; guides age-specific interventions

**Option 2: Geographic map of mean BMI by region**
- **Health question:** Are there geographic disparities in obesity prevalence?
- **Value:** Targets resources to high-prevalence regions; identifies environmental factors

**Option 3: BMI trends over time (line graph)**
- **Health question:** Is the obesity problem getting worse over time?
- **Value:** Evaluates effectiveness of public health campaigns; forecasts future burden

---

## Part C: R Programming Exercises (30 points)

### Question 14: R Data Analysis with FEV1 Dataset (15 points)

**a) Mean FEV1 by gender (5 points):**

```r
# Load the FEV1 data
source("week1_lecture_code.R")  # or create data directly

# Calculate mean FEV1 by gender
aggregate(fev1_liters ~ gender, data = fev1_data, FUN = mean)

# Alternative using tapply:
tapply(fev1_data$fev1_liters, fev1_data$gender, mean)
```

**Expected Output:**
```
  gender fev1_liters
1 Female    2.696667
2   Male    3.098571
```

**Interpretation:** Males have higher average FEV1 (3.10 L) compared to females (2.70 L), consistent with physiological differences in lung capacity.

---

**b) Summary statistics and quartile interpretation (5 points):**

```r
# Summary statistics for FEV1
summary(fev1_data$fev1_liters)
```

**Expected Output:**
```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
  2.460   2.705   2.810   2.882   3.135   3.460
```

**Interpretation of Quartiles:**
- **1st Quartile (Q1 = 2.705):** 25% of subjects have FEV1 ≤ 2.705 liters
- **3rd Quartile (Q3 = 3.135):** 75% of subjects have FEV1 ≤ 3.135 liters
- **Interquartile Range (IQR = 3.135 - 2.705 = 0.43):** The middle 50% of values span 0.43 liters
- **Interpretation:** Most lung function values cluster in a relatively narrow range (2.7-3.1 L), with 50% of subjects falling within this 0.43 L range.

---

**c) Frequency table for gender and percentage female (5 points):**

```r
# Create frequency table for gender
gender_table <- table(fev1_data$gender)
gender_table

# Calculate proportions
prop.table(gender_table)

# Calculate percentage
prop.table(gender_table) * 100

# Or specifically for females:
female_count <- sum(fev1_data$gender == "Female")
total_count <- nrow(fev1_data)
female_percentage <- (female_count / total_count) * 100
female_percentage
```

**Expected Output:**
```
Female   Male
     6      7

Female      Male
0.4615385 0.5384615

Female     Male
 46.15    53.85
```

**Calculation:** 6 females out of 13 total subjects = 6/13 = 0.4615 = **46.2% female**

---

### Question 15: Creating Geographic Health Visualizations (15 points)

**a) Choropleth map code (8 points):**

```r
# Load required libraries
library(ggplot2)
library(maps)
library(mapdata)
library(dplyr)

# Create state health data
state_health <- data.frame(
  state = c("oregon", "washington", "california", "nevada", "idaho"),
  diabetes_rate = c(8.2, 9.1, 9.7, 10.8, 8.9)
)

# Get map data
states_map <- map_data("state")

# Merge health data with map coordinates
map_data_merged <- left_join(states_map, state_health,
                              by = c("region" = "state"))

# Create choropleth map
ggplot(map_data_merged, aes(x = long, y = lat,
                             group = group, fill = diabetes_rate)) +
  geom_polygon(color = "white", size = 0.5) +
  scale_fill_gradient(low = "lightblue", high = "darkred",
                      name = "Diabetes\nRate (%)",
                      na.value = "grey90") +
  coord_quickmap() +
  theme_void() +
  labs(title = "Diabetes Prevalence by State",
       subtitle = "Pacific Northwest Region",
       caption = "Data: State Health Surveys") +
  theme(plot.title = element_text(size = 16, face = "bold"),
        legend.position = "right")

# Save the plot
ggsave("diabetes_choropleth.png", width = 10, height = 6, dpi = 300)
```

---

**b) Complementary visualization (4 points):**

```r
# Create dot plot showing diabetes rates with state labels
ggplot(state_health, aes(x = diabetes_rate,
                          y = reorder(state, diabetes_rate))) +
  geom_point(size = 5, color = "darkred") +
  geom_segment(aes(x = 0, xend = diabetes_rate,
                   y = state, yend = state),
               color = "gray70", size = 1) +
  scale_x_continuous(limits = c(0, 12),
                     breaks = seq(0, 12, 2)) +
  labs(title = "Diabetes Prevalence by State - Ranked",
       x = "Diabetes Rate (%)",
       y = "State",
       caption = "Dot plot allows precise comparison of rates") +
  theme_minimal() +
  theme(plot.title = element_text(size = 14, face = "bold"),
        axis.text.y = element_text(size = 11))

# Save
ggsave("diabetes_dotplot.png", width = 8, height = 5, dpi = 300)
```

**Alternative - Bar Chart:**
```r
ggplot(state_health, aes(x = reorder(state, diabetes_rate),
                          y = diabetes_rate, fill = diabetes_rate)) +
  geom_col() +
  coord_flip() +
  scale_fill_gradient(low = "lightblue", high = "darkred") +
  labs(title = "Diabetes Rates by State",
       x = "State", y = "Diabetes Rate (%)") +
  theme_minimal() +
  theme(legend.position = "none")
```

**Why this adds value beyond the map:**
- **Precise values:** Easier to read exact percentages than from color gradients
- **Clear ranking:** Immediately shows which states have highest/lowest rates
- **Better comparison:** Easier to judge magnitude of differences between states
- **Accessibility:** Works better for colorblind viewers
- **Complement not duplicate:** Map shows spatial patterns; dot plot shows precise values and ranking

---

**c) Geographic vs Non-geographic Representations (3 points):**

**Strengths of Geographic Maps:**
- Show spatial patterns and clustering
- Reveal regional influences (climate, culture, policies)
- Help identify border effects or diffusion patterns
- Useful for understanding geographic disparities
- Good for public communication and awareness

**Limitations of Geographic Maps:**
- Harder to read precise values
- Large states dominate visually (area bias)
- Color interpretation can be subjective
- Not ideal for exact comparisons

**Strengths of Non-geographic Visualizations (bar/dot plots):**
- Precise value reading
- Easy magnitude comparisons
- Clear ranking of states
- Better for detailed analysis
- No geographic bias

**Limitations:**
- Lose spatial context
- Can't see regional patterns
- Miss geographic relationships

**When to Use Each:**

**Use Geographic Maps when:**
- Spatial patterns are important (disease spread, environmental factors)
- Communicating to general public
- Showing regional disparities for policy
- Investigating neighbor effects or diffusion

**Use Non-geographic Charts when:**
- Precise comparisons needed
- Ranking states is the goal
- Analyzing correlations with other variables
- Presenting to technical audiences
- Space is limited (publications)

**Best Practice:** Use both together for comprehensive analysis - map for spatial context, chart for precise values.

---

## Bonus Question (5 points)

### Question 16: Critical Thinking About AI in Biostatistics

**Scenario:** Researcher wants to use AI to analyze EHR data to identify diabetes risk factors.

**a) Two ways AI could be helpful (2 points):**

1. **Pattern Recognition in Large Datasets:**
   - AI can process thousands of variables and identify complex interactions that humans might miss
   - Machine learning can detect non-linear relationships between risk factors
   - Example: AI might discover unexpected combinations of medications that correlate with diabetes risk

2. **Rapid Literature Review and Hypothesis Generation:**
   - AI can quickly summarize existing research on diabetes risk factors
   - Can suggest variables to include based on latest evidence
   - Helps researcher avoid reinventing the wheel or missing important confounders

**Additional helpful uses:**
- Natural language processing to extract diagnoses from clinical notes
- Automated data cleaning and outlier detection
- Generating R/Python code for standard analyses

---

**b) Two potential problems or limitations (2 points):**

1. **Context and Causation Confusion:**
   - AI may identify spurious correlations without understanding biological plausibility
   - May not distinguish between causal risk factors and mere associations
   - Example: AI might suggest "hospital visits" as risk factor when it's actually a consequence

2. **Bias in Training Data and Assumptions:**
   - AI trained on biased EHR data may perpetuate healthcare disparities
   - May not check statistical assumptions (linearity, independence, etc.)
   - Could use outdated diabetes diagnostic criteria if training data is old
   - May miss important confounders or effect modifiers

**Additional concerns:**
- Privacy and ethical issues with patient data
- Inability to handle missing data appropriately
- Black box nature makes interpretation difficult
- May not account for temporal relationships properly

---

**c) Essential human oversight (1 point):**

**Critical oversight needed:**

1. **Clinical/Domain Expertise:**
   - Biostatistician or epidemiologist must evaluate biological plausibility of findings
   - Clinician should verify that identified risk factors make medical sense

2. **Statistical Validation:**
   - Check all statistical assumptions
   - Validate results with traditional methods
   - Assess for confounding and effect modification

3. **Ethical Review:**
   - Ensure findings don't perpetuate health disparities
   - Verify patient privacy protection
   - Consider equity implications of recommendations

4. **Iterative Refinement:**
   - Human reviews AI output and refines the analysis
   - Tests alternative models and sensitivity analyses
   - Validates findings in independent datasets

**Key Principle:** AI should augment human expertise, not replace it. The researcher must understand every step of the analysis and take responsibility for the conclusions.

---

## Grading Rubric Summary

**Multiple Choice (40 points):** 4 points each, auto-graded

**Short Answer Questions (30 points):**
- Question 11 (Data Types): 2 points per variable (correct type + justification)
- Question 12 (Geographic): 3 + 4 + 3 points for parts a, b, c
- Question 13 (Multi-panel): 3 + 4 + 3 points for parts a, b, c

**R Programming (30 points):**
- Question 14: 5 + 5 + 5 points for parts a, b, c
  - Code correctness: 70%
  - Proper output: 20%
  - Interpretation: 10%
- Question 15: 8 + 4 + 3 points for parts a, b, c
  - Working code: 70%
  - Visualization quality: 20%
  - Interpretation: 10%

**Bonus (5 points):** 2 + 2 + 1 points for thoughtful, evidence-based responses

---

**Total: 103 points (100 base + 3 bonus)**
