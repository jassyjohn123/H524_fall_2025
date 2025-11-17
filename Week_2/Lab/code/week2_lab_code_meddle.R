# Name: Week 2 Lab Code
# Date: Fall 2025
# Lab: Week 2 - R Basics and Probability
# H524 Introduction to Biostatistics

# ============================================================================
# PART 1: R AS A CALCULATOR
# ============================================================================

# Exercise 1.1: Basic Arithmetic

# Addition
5 + 3

# Subtraction
10 - 4

# Multiplication
6 * 7

# Division
20 / 4

# Exponentiation (power)
2^3

# Order of operations (PEMDAS applies!)
(5 + 3) * 2

# Square root
sqrt(16)

# Absolute value
abs(-10)

# Try it yourself: Calculate average of three blood pressure readings
(120 + 140 + 135) / 3

# Exercise 1.2: Storing Values in Variables

# Store a single number
age <- 45
age

# Store a calculation result
bmi_numerator <- 75  # weight in kg
bmi_denominator <- 1.7^2  # height in meters, squared
bmi <- bmi_numerator / bmi_denominator
bmi

# Round to 1 decimal place
round(bmi, 1)

# Practice: Blood pressure variables
systolic <- 120
diastolic <- 80
mean_arterial_pressure <- (systolic + diastolic) / 2
mean_arterial_pressure

# ============================================================================
# PART 2: WORKING WITH VECTORS (LISTS OF NUMBERS)
# ============================================================================

# Exercise 2.1: Creating Vectors

# Ages of 5 patients
ages <- c(25, 34, 45, 52, 38)
ages

# How many patients?
length(ages)

# What's the average age?
mean(ages)

# What's the oldest patient's age?
max(ages)

# What's the youngest?
min(ages)

# Exercise 2.2: More Vector Operations

# Systolic blood pressure readings from 7 patients
systolic_bp <- c(120, 135, 142, 118, 160, 125, 138)

# Basic statistics
mean(systolic_bp)
median(systolic_bp)
sd(systolic_bp)  # standard deviation
min(systolic_bp)
max(systolic_bp)
range(systolic_bp)  # gives min and max

# Sort the values
sort(systolic_bp)

# How many readings?
length(systolic_bp)

# Sum of all readings
sum(systolic_bp)

# Practice: Cholesterol readings
cholesterol <- c(180, 220, 195, 240, 175, 210)
mean(cholesterol)
median(cholesterol)
sd(cholesterol)

# Exercise 2.3: Accessing Specific Values

# Our blood pressure data
systolic_bp <- c(120, 135, 142, 118, 160, 125, 138)

# Get the first value
systolic_bp[1]

# Get the third value
systolic_bp[3]

# Get the last value
systolic_bp[length(systolic_bp)]

# Get the first three values
systolic_bp[1:3]

# Get values in positions 2, 4, and 6
systolic_bp[c(2, 4, 6)]

# ============================================================================
# PART 3: CREATING DATA FRAMES
# ============================================================================

# Exercise 3.1: Building a Simple Data Frame

# Create a small clinical trial dataset
patient_data <- data.frame(
  patient_id = c(1, 2, 3, 4, 5),
  age = c(45, 52, 38, 61, 47),
  gender = c("M", "F", "F", "M", "M"),
  systolic_bp = c(120, 135, 142, 118, 160),
  has_diabetes = c(FALSE, TRUE, FALSE, TRUE, FALSE)
)

# View the data
patient_data

# Look at the structure
str(patient_data)

# Get summary statistics
summary(patient_data)

# Exercise 3.2: Accessing Data Frame Columns

# Access a column using $
patient_data$age
patient_data$systolic_bp

# Calculate mean age
mean(patient_data$age)

# Calculate mean blood pressure
mean(patient_data$systolic_bp)

# Count how many have diabetes
sum(patient_data$has_diabetes)

# What proportion have diabetes?
mean(patient_data$has_diabetes)

# ============================================================================
# PART 4: INTRODUCTION TO PROBABILITY IN R
# ============================================================================

# Exercise 4.1: Simple Probability Calculations

# Total patients
total_patients <- 100

# Patients with diabetes
diabetes_patients <- 15

# Probability of diabetes
prob_diabetes <- diabetes_patients / total_patients
prob_diabetes

# Convert to percentage
prob_diabetes * 100

# Probability of NOT having diabetes
prob_no_diabetes <- 1 - prob_diabetes
prob_no_diabetes

# Exercise 4.2: Creating a 2x2 Table

# Create a 2x2 table (matrix in R)
# Rows: Disease status (Yes/No)
# Columns: Test result (Positive/Negative)

test_results <- matrix(
  c(85, 5,    # Disease Yes: 85 test+, 5 test-
    10, 900), # Disease No: 10 test+, 900 test-
  nrow = 2,
  byrow = TRUE,
  dimnames = list(
    Disease = c("Yes", "No"),
    Test = c("Positive", "Negative")
  )
)

# View the table
test_results

# Add row and column totals
addmargins(test_results)

# Exercise 4.3: Calculating Sensitivity and Specificity

# From our table above:
# True Positives (TP): disease Yes, test Positive
TP <- test_results[1, 1]

# False Negatives (FN): disease Yes, test Negative
FN <- test_results[1, 2]

# False Positives (FP): disease No, test Positive
FP <- test_results[2, 1]

# True Negatives (TN): disease No, test Negative
TN <- test_results[2, 2]

# Sensitivity: Pr(Test+ | Disease+)
sensitivity <- TP / (TP + FN)
cat("Sensitivity:", round(sensitivity * 100, 1), "%\n")

# Specificity: Pr(Test- | Disease-)
specificity <- TN / (TN + FP)
cat("Specificity:", round(specificity * 100, 1), "%\n")

# Positive Predictive Value: Pr(Disease+ | Test+)
PPV <- TP / (TP + FP)
cat("PPV:", round(PPV * 100, 1), "%\n")

# Negative Predictive Value: Pr(Disease- | Test-)
NPV <- TN / (TN + FN)
cat("NPV:", round(NPV * 100, 1), "%\n")

# ============================================================================
# PART 5: PROBABILITY DISTRIBUTIONS IN R
# ============================================================================

# Exercise 5.1: Binomial Distribution

# Scenario: A treatment has a 70% success rate. We treat 10 patients.

# Probability of exactly 7 successes
dbinom(7, size = 10, prob = 0.7)

# Probability of 7 OR MORE successes
# Method 1: Add them up
dbinom(7, 10, 0.7) + dbinom(8, 10, 0.7) +
  dbinom(9, 10, 0.7) + dbinom(10, 10, 0.7)

# Method 2: Use pbinom (much easier!)
pbinom(6, size = 10, prob = 0.7, lower.tail = FALSE)

# Expected number of successes
expected <- 10 * 0.7
expected

# Visualize the distribution
x <- 0:10  # Possible number of successes
probs <- dbinom(x, size = 10, prob = 0.7)

barplot(probs,
        names.arg = x,
        xlab = "Number of Successes",
        ylab = "Probability",
        main = "Binomial Distribution (n=10, p=0.7)",
        col = "lightblue")

# Exercise 5.2: Normal Distribution

# Scenario: Adult cholesterol levels are normally distributed
# with mean 200 mg/dL and SD 40 mg/dL.

# What proportion have cholesterol < 240 mg/dL?
pnorm(240, mean = 200, sd = 40)

# What proportion have cholesterol > 240 mg/dL?
pnorm(240, mean = 200, sd = 40, lower.tail = FALSE)

# What proportion have cholesterol between 180 and 220?
pnorm(220, 200, 40) - pnorm(180, 200, 40)

# What cholesterol level is at the 90th percentile?
qnorm(0.90, mean = 200, sd = 40)

# Visualize the distribution
x_values <- seq(100, 300, by = 1)
y_values <- dnorm(x_values, mean = 200, sd = 40)

plot(x_values, y_values,
     type = "l",
     xlab = "Cholesterol (mg/dL)",
     ylab = "Density",
     main = "Normal Distribution of Cholesterol Levels",
     col = "blue",
     lwd = 2)

# Add vertical line at the mean
abline(v = 200, col = "red", lty = 2, lwd = 2)

# ============================================================================
# PRACTICE PROBLEMS - SOLUTIONS
# ============================================================================

# ----------------------------------------------------------------------------
# Problem 1: Blood Pressure Analysis
# ----------------------------------------------------------------------------

# Seven patients have the following systolic blood pressure readings:
# 115, 128, 142, 135, 120, 155, 138

# a) Create a vector with these values
bp_readings <- c(115, 128, 142, 135, 120, 155, 138)

# b) Calculate the mean, median, and standard deviation
mean(bp_readings)
median(bp_readings)
sd(bp_readings)

# c) How many patients have high blood pressure (>= 140 mmHg)?
high_bp <- bp_readings >= 140
sum(high_bp)

# d) What proportion have high blood pressure?
mean(high_bp)
# Or: sum(high_bp) / length(bp_readings)

# ----------------------------------------------------------------------------
# Problem 2: Diagnostic Test
# ----------------------------------------------------------------------------

# A rapid flu test was given to 500 patients. The results were:
# - 40 patients had the flu and tested positive
# - 5 patients had the flu and tested negative
# - 30 patients didn't have the flu but tested positive
# - 425 patients didn't have the flu and tested negative

# a) Create a 2x2 matrix with these results
flu_test <- matrix(
  c(40, 5,      # Flu Yes: 40 test+, 5 test-
    30, 425),   # Flu No: 30 test+, 425 test-
  nrow = 2,
  byrow = TRUE,
  dimnames = list(
    Flu = c("Yes", "No"),
    Test = c("Positive", "Negative")
  )
)

flu_test
addmargins(flu_test)

# b) Calculate the sensitivity
TP <- flu_test[1, 1]
FN <- flu_test[1, 2]
sensitivity <- TP / (TP + FN)
cat("Sensitivity:", round(sensitivity * 100, 1), "%\n")

# c) Calculate the specificity
FP <- flu_test[2, 1]
TN <- flu_test[2, 2]
specificity <- TN / (TN + FP)
cat("Specificity:", round(specificity * 100, 1), "%\n")

# d) Calculate the PPV (positive predictive value)
PPV <- TP / (TP + FP)
cat("PPV:", round(PPV * 100, 1), "%\n")

# ----------------------------------------------------------------------------
# Problem 3: Treatment Success
# ----------------------------------------------------------------------------

# A new medication has an 80% success rate.
# A clinic treats 15 patients with this medication.

# a) What is the probability that exactly 12 patients respond successfully?
dbinom(12, size = 15, prob = 0.8)

# b) What is the probability that at least 12 patients respond successfully?
# "At least 12" means 12, 13, 14, or 15
pbinom(11, size = 15, prob = 0.8, lower.tail = FALSE)
# Or: sum(dbinom(12:15, size = 15, prob = 0.8))

# c) What is the expected number of successful responses?
expected_successes <- 15 * 0.8
expected_successes

# d) Create a barplot showing the probability distribution
x <- 0:15
probs <- dbinom(x, size = 15, prob = 0.8)

barplot(probs,
        names.arg = x,
        xlab = "Number of Successful Responses",
        ylab = "Probability",
        main = "Binomial Distribution (n=15, p=0.8)",
        col = "lightgreen")

# ----------------------------------------------------------------------------
# Problem 4: BMI Distribution
# ----------------------------------------------------------------------------

# Adult BMI is normally distributed with mean 26.5 and standard deviation 5.

# a) What proportion of adults have BMI < 25 (normal weight)?
pnorm(25, mean = 26.5, sd = 5)

# b) What proportion have BMI >= 30 (obese)?
pnorm(30, mean = 26.5, sd = 5, lower.tail = FALSE)

# c) What BMI value represents the 75th percentile?
qnorm(0.75, mean = 26.5, sd = 5)

# d) Plot the normal distribution curve
x_vals <- seq(10, 45, by = 0.1)
y_vals <- dnorm(x_vals, mean = 26.5, sd = 5)

plot(x_vals, y_vals,
     type = "l",
     xlab = "BMI",
     ylab = "Density",
     main = "Normal Distribution of Adult BMI",
     col = "darkblue",
     lwd = 2)

# Add vertical line at the mean
abline(v = 26.5, col = "red", lty = 2, lwd = 2)

# Add vertical lines at clinically relevant cutoffs
abline(v = 25, col = "green", lty = 3, lwd = 1.5)  # Normal/Overweight
abline(v = 30, col = "orange", lty = 3, lwd = 1.5) # Overweight/Obese

legend("topright",
       legend = c("Mean (26.5)", "Normal weight cutoff (25)", "Obesity cutoff (30)"),
       col = c("red", "green", "orange"),
       lty = c(2, 3, 3),
       lwd = c(2, 1.5, 1.5))

# ============================================================================
# SAVE YOUR WORK
# ============================================================================

# Save your workspace (all objects you created)
save.image("week2_lab.RData")

# To load it later:
# load("week2_lab.RData")
