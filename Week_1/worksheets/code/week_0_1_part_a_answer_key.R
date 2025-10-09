# H524 Introduction to Biostatistics
# In-Class Worksheet Part A - ANSWER KEY
# Topic: Introduction to R, Data Presentation, Numerical Summary Measures

# ============================================================================
# Part 1: Getting Started with R
# ============================================================================

# Exercise 1.1: Basic R Operations

# 1. Use R as a calculator
3 * 2 + 4
# Answer: 10

# 2. Create a simple vector of systolic blood pressure readings
blood_pressure <- c(170, 193, 110, 135, 135, 115)
# This creates a numeric vector with 6 blood pressure values

# Discussion Questions:
# - How do you create a vector in R?
#   Use the c() function with values separated by commas
# - What does the c() function do?
#   It combines (concatenates) values into a vector

# ============================================================================
# Part 2: Data Types and Classification
# ============================================================================

# Exercise 2.1: Identifying Data Types
# Variables classified as: Nominal, Ordinal, Discrete, or Continuous

# Blood type (A, B, AB, O) - Nominal: Categories with no natural order
# Pain level (none, mild, moderate, severe) - Ordinal: Categories with clear ordering
# Number of hospitalizations this year - Discrete: Countable whole numbers
# Body temperature (°F) - Continuous: Can be measured to any level of precision
# Treatment group (control, low dose, high dose) - Nominal: Categories with no inherent order

# Exercise 2.2: AI Enhancement Activity
# Sample AI-Generated Code for creating different data types:

# Nominal data - blood type
blood_type <- factor(c("A", "B", "AB", "O"))

# Ordinal data - pain level
pain_level <- factor(c("none", "mild", "moderate", "severe"),
                     levels = c("none", "mild", "moderate", "severe"),
                     ordered = TRUE)

# Discrete data - hospitalizations
hospitalizations <- c(0, 1, 2, 1, 0, 3)

# Continuous data - temperature
temperature <- c(98.6, 99.2, 97.8, 100.1, 98.9)

# Nominal data - treatment group
treatment <- factor(c("control", "low dose", "high dose"))

# Key learning: Use factor() for categorical data, with ordered = TRUE for ordinal data

# ============================================================================
# Part 3: Descriptive Statistics
# ============================================================================

# Exercise 3.1: Measures of Central Tendency
# Using the blood pressure data: c(170, 193, 110, 135, 135, 115)

# Create the data
blood_pressure <- c(170, 193, 110, 135, 135, 115)

# Calculate mean
mean_bp <- mean(blood_pressure)
mean_bp  # 143

# Calculate median
median_bp <- median(blood_pressure)
median_bp  # 135

# Find the mode (most frequent value)
table(blood_pressure)  # Shows 135 appears twice
# Mode: 135

# Order the data
ordered_bp <- sort(blood_pressure)
ordered_bp  # 110 115 135 135 170 193

# Hand Calculations Results:
# Mean: 143 mmHg (170+193+110+135+135+115)/6 = 858/6 = 143
# Median: 135 mmHg (135+135)/2 = 135 (middle values)
# Mode: 135 mmHg (appears twice)

# ============================================================================
# Part 4: Measures of Variability
# ============================================================================

# Exercise 4.1: Spread of Data

# Create the data
blood_pressure <- c(170, 193, 110, 135, 135, 115)

# Calculate range
max_bp <- max(blood_pressure)  # 193
min_bp <- min(blood_pressure)  # 110
range_bp <- max_bp - min_bp    # 83

# Calculate variance
var_bp <- var(blood_pressure)  # 1116.4

# Calculate standard deviation
sd_bp <- sd(blood_pressure)    # 33.41

# Calculate standard error of the mean
n <- length(blood_pressure)    # 6
sem_bp <- sd_bp / sqrt(n)      # 13.64

# Results Summary:
# Range: 83 mmHg (193 - 110)
# Variance: 1116.4 mmHg^2 (sample variance)
# Standard Deviation: 33.41 mmHg (square root of variance)
# Standard Error of Mean: 13.64 mmHg (33.41/√6)

# Discussion: These measures tell us the blood pressure data has considerable
# spread (range = 83), high variability (SD = 33.41), and the mean has
# substantial uncertainty (SEM = 13.64).

# ============================================================================
# Part 5: AI-Enhanced Data Exploration
# ============================================================================

# Exercise 5.1: Using AI for Data Summary
# Prompt: "Help me create a comprehensive summary of this blood pressure
# dataset: c(170, 193, 110, 135, 135, 115). Include all relevant descriptive
# statistics and suggest appropriate visualizations."

# Blood pressure data analysis
blood_pressure <- c(170, 193, 110, 135, 135, 115)

# Comprehensive summary
summary(blood_pressure)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#    110     125     135     143     158     193

# Additional statistics
length(blood_pressure)    # n = 6
sd(blood_pressure)        # SD = 33.41
var(blood_pressure)       # Var = 1116.4
range(blood_pressure)     # Range: 110 193
IQR(blood_pressure)       # IQR = 33

# Suggested visualizations
hist(blood_pressure, main="Blood Pressure Distribution",
     xlab="Systolic BP (mmHg)", col="lightblue")

boxplot(blood_pressure, main="Blood Pressure Boxplot",
        ylab="Systolic BP (mmHg)")

dotchart(blood_pressure, main="Blood Pressure Dot Plot")

# Verification Steps - Sample Answers:
# - Run the code and check if results match: Yes, all calculations match hand calculations
# - Do the suggested visualizations make sense? Yes, histogram shows distribution,
#   boxplot shows quartiles and outliers, dot plot shows individual values
# - Are there any errors or improvements needed? Code is correct, might add axis
#   labels for clarity

# What you learned from AI - Sample Answers:
# - New R functions discovered: summary(), IQR(), dotchart()
# - Visualization suggestions: histogram, boxplot, dot chart
# - Any surprising insights: IQR = 33, shows middle 50% spread

# ============================================================================
# Wrap-up Discussion
# ============================================================================

# Reflection Questions - Sample Answers:
# 1. When might you prefer mean vs. median?
#    Use median when data is skewed or has outliers; use mean when data is
#    normally distributed
# 2. How can AI tools help while ensuring accuracy?
#    AI generates code quickly, but always verify results by hand or with known
#    datasets; check for logical errors
# 3. What's one new R function you learned?
#    Examples: factor(), summary(), IQR(), table()

# AI Usage Documentation - Sample:
# - AI tools used: GitHub Copilot, ChatGPT
# - Key prompts: "Generate R code for data summary", "Best way to store categorical data"
# - Verification methods: Hand calculations, checking output against expected results
# - Errors found and corrected: None in this exercise, but always double-check factor levels
