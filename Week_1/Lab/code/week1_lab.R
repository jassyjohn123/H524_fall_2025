# ==============================================================================
# H524 Introduction to Biostatistics - Week 1 Lab
# Introduction to R and Data Visualization
# Fall 2025
# ==============================================================================

# Lab Duration: 110 minutes (8:00am -- 9:50am)
# Format: Online
# Tools Required: R, RStudio, GitHub account, GitHub Copilot (optional)

# ==============================================================================
# LAB SETUP - Verify Installation
# ==============================================================================

# Check R version
R.version.string

# Check working directory
getwd()

# Test basic functionality
x <- c(1, 2, 3, 4, 5)
mean(x)

# ==============================================================================
# PART 1: R FUNDAMENTALS (30 minutes)
# ==============================================================================

# ------------------------------------------------------------------------------
# Exercise 1.1: Data Types and Structures
# ------------------------------------------------------------------------------

# Numeric data
systolic_bp <- c(120, 135, 142, 118, 160, 125, 138)
diastolic_bp <- c(80, 85, 92, 75, 95, 82, 88)

# Character data
patient_id <- c("P001", "P002", "P003", "P004", "P005", "P006", "P007")
gender <- c("Male", "Female", "Female", "Male", "Male", "Female", "Male")

# Factor data (categorical)
treatment_group <- factor(c("Control", "Treatment", "Treatment",
                           "Control", "Treatment", "Control", "Treatment"))

# Logical data
hypertensive <- systolic_bp >= 140 | diastolic_bp >= 90

# Display the data types
class(systolic_bp)
class(gender)
class(treatment_group)
class(hypertensive)

# ------------------------------------------------------------------------------
# Exercise 1.2: Create a data frame
# ------------------------------------------------------------------------------

# Create a comprehensive health dataset
health_data <- data.frame(
  patient_id = patient_id,
  gender = gender,
  systolic_bp = systolic_bp,
  diastolic_bp = diastolic_bp,
  treatment_group = treatment_group,
  hypertensive = hypertensive
)

# View the data structure
str(health_data)
head(health_data)
summary(health_data)

# ==============================================================================
# PART 2: DESCRIPTIVE STATISTICS (25 minutes)
# ==============================================================================

# ------------------------------------------------------------------------------
# Exercise 2.1: Calculate measures of central tendency and variability
# ------------------------------------------------------------------------------

# Measures of central tendency
mean_systolic <- mean(health_data$systolic_bp)
median_systolic <- median(health_data$systolic_bp)

# Measures of variability
sd_systolic <- sd(health_data$systolic_bp)
var_systolic <- var(health_data$systolic_bp)
range_systolic <- range(health_data$systolic_bp)
iqr_systolic <- IQR(health_data$systolic_bp)

# Display results
cat("Mean systolic BP:", round(mean_systolic, 2), "mmHg\n")
cat("Median systolic BP:", median_systolic, "mmHg\n")
cat("Standard deviation:", round(sd_systolic, 2), "mmHg\n")
cat("Range:", range_systolic[1], "-", range_systolic[2], "mmHg\n")

# ------------------------------------------------------------------------------
# Exercise 2.2: Generate descriptive statistics by group
# ------------------------------------------------------------------------------

# Statistics by gender
aggregate(systolic_bp ~ gender, data = health_data, FUN = mean)
aggregate(systolic_bp ~ gender, data = health_data, FUN = sd)

# Statistics by treatment group
aggregate(systolic_bp ~ treatment_group, data = health_data, FUN = summary)

# Frequency tables for categorical data
table(health_data$gender)
table(health_data$treatment_group)
prop.table(table(health_data$hypertensive))

# ==============================================================================
# PART 3: DATA VISUALIZATION (35 minutes)
# ==============================================================================

# ------------------------------------------------------------------------------
# Exercise 3.1: Visualizations for Continuous Data
# ------------------------------------------------------------------------------

# Histogram of systolic blood pressure
hist(health_data$systolic_bp,
     main = "Distribution of Systolic Blood Pressure",
     xlab = "Systolic BP (mmHg)",
     ylab = "Frequency",
     col = "lightblue",
     border = "white",
     breaks = 5)

# Add vertical line for mean
abline(v = mean_systolic, col = "red", lwd = 2, lty = 2)
legend("topright", "Mean", col = "red", lwd = 2, lty = 2)

# Box plot by gender
boxplot(systolic_bp ~ gender,
        data = health_data,
        main = "Systolic BP by Gender",
        ylab = "Systolic BP (mmHg)",
        col = c("pink", "lightblue"))

# ------------------------------------------------------------------------------
# Exercise 3.2: Visualizations for Categorical Data
# ------------------------------------------------------------------------------

# Bar chart for treatment groups
treatment_counts <- table(health_data$treatment_group)
barplot(treatment_counts,
        main = "Distribution of Treatment Groups",
        ylab = "Frequency",
        col = c("#FF6B35", "#F7931E", "#FFAA1D"))

# Pie chart for gender distribution
gender_counts <- table(health_data$gender)
pie(gender_counts,
    main = "Gender Distribution",
    col = c("pink", "lightblue"))

# ------------------------------------------------------------------------------
# Exercise 3.3: Advanced Visualizations
# ------------------------------------------------------------------------------

# Scatter plot of systolic vs diastolic BP
plot(health_data$diastolic_bp, health_data$systolic_bp,
     xlab = "Diastolic BP (mmHg)",
     ylab = "Systolic BP (mmHg)",
     main = "Systolic vs Diastolic Blood Pressure",
     pch = 19,
     col = as.numeric(health_data$gender))

# Add legend
legend("topleft", levels(health_data$gender),
       col = 1:2, pch = 19)

# Add regression line
abline(lm(systolic_bp ~ diastolic_bp, data = health_data),
       col = "red", lwd = 2)

# ==============================================================================
# PART 4: AI-ENHANCED CODING WITH GITHUB COPILOT (20 minutes)
# ==============================================================================

# ------------------------------------------------------------------------------
# Exercise 4.2: AI-Assisted Code Generation
# ------------------------------------------------------------------------------

# Create a function to calculate age-adjusted rates for three age groups
# Age groups: 0-30, 31-60, 61+
# Input: cases vector, population vector, age_groups vector
# Output: age-specific rates per 100,000

# AI-GENERATED FUNCTION (verify this code!)
calculate_age_specific_rates <- function(cases, population, age_groups) {
  if (length(cases) != length(population) || length(cases) != length(age_groups)) {
    stop("All input vectors must have the same length")
  }

  rates <- (cases / population) * 100000
  names(rates) <- age_groups
  return(rates)
}

# ------------------------------------------------------------------------------
# Exercise 4.3: Verify and test AI-generated code
# ------------------------------------------------------------------------------

# Test the AI-generated function with sample data
test_cases <- c(10, 25, 40)
test_population <- c(20000, 30000, 15000)
test_ages <- c("0-30", "31-60", "61+")

# Run the function and verify results manually
ai_result <- calculate_age_specific_rates(test_cases, test_population, test_ages)
print(ai_result)

# Calculate manually to verify: (cases/population) * 100000
manual_check <- (test_cases / test_population) * 100000
names(manual_check) <- test_ages
print(manual_check)

# Compare results
identical(ai_result, manual_check)

# ==============================================================================
# LAB ASSIGNMENT: FEV1 DATA ANALYSIS
# ==============================================================================

# FEV1 data from Pagano & Gauvreau study
fev1_data <- data.frame(
  subject_id = 1:13,
  gender = c("F", "F", "F", "F", "F", "F", "M", "M", "M", "M", "M", "M", "M"),
  fev1_liters = c(2.46, 2.65, 2.69, 2.76, 2.85, 3.15, 2.47, 2.77, 2.78,
                  2.81, 3.09, 3.18, 3.46)
)

# ------------------------------------------------------------------------------
# Assignment Task 1: Calculate descriptive statistics by gender
# ------------------------------------------------------------------------------

# Mean, median, SD, range for FEV1 by gender
fev1_stats_by_gender <- aggregate(fev1_liters ~ gender, data = fev1_data,
                                  FUN = function(x) c(mean = mean(x),
                                                      median = median(x),
                                                      sd = sd(x),
                                                      min = min(x),
                                                      max = max(x)))

print(fev1_stats_by_gender)

# Overall statistics
cat("Overall FEV1 Statistics:\n")
cat("Mean:", round(mean(fev1_data$fev1_liters), 2), "liters\n")
cat("Median:", round(median(fev1_data$fev1_liters), 2), "liters\n")
cat("SD:", round(sd(fev1_data$fev1_liters), 2), "liters\n")
cat("Range:", round(min(fev1_data$fev1_liters), 2), "-",
    round(max(fev1_data$fev1_liters), 2), "liters\n")

# ------------------------------------------------------------------------------
# Assignment Task 2: Create visualizations
# ------------------------------------------------------------------------------

# Histogram of all FEV1 values
hist(fev1_data$fev1_liters,
     main = "Distribution of FEV1 Values",
     xlab = "FEV1 (liters)",
     ylab = "Frequency",
     col = "lightgreen",
     border = "white",
     breaks = 6)

# Add vertical line for mean
mean_fev1 <- mean(fev1_data$fev1_liters)
abline(v = mean_fev1, col = "red", lwd = 2, lty = 2)
legend("topright", paste("Mean =", round(mean_fev1, 2)),
       col = "red", lwd = 2, lty = 2)

# Box plot comparing FEV1 by gender
boxplot(fev1_liters ~ gender, data = fev1_data,
        main = "FEV1 by Gender",
        xlab = "Gender",
        ylab = "FEV1 (liters)",
        col = c("pink", "lightblue"))

# Dot plot showing individual values
stripchart(fev1_data$fev1_liters,
           method = "stack",
           main = "Dot Plot of FEV1 Values",
           xlab = "FEV1 (liters)",
           col = "blue",
           pch = 19)

# ------------------------------------------------------------------------------
# Assignment Task 3: AI Component - Categorize FEV1 values
# ------------------------------------------------------------------------------

# AI-GENERATED FUNCTION: Categorize FEV1 values
# Categories: "Low" (<2.5), "Normal" (2.5-3.2), "High" (>3.2)
categorize_fev1 <- function(fev1_values) {
  categories <- ifelse(fev1_values < 2.5, "Low",
                      ifelse(fev1_values <= 3.2, "Normal", "High"))
  return(factor(categories, levels = c("Low", "Normal", "High")))
}

# Apply the function
fev1_data$fev1_category <- categorize_fev1(fev1_data$fev1_liters)

# Display categorized data
print(fev1_data)

# Create frequency table of categories
table(fev1_data$fev1_category)
prop.table(table(fev1_data$fev1_category))

# ------------------------------------------------------------------------------
# Assignment Task 4: Advanced visualization with better formatting
# ------------------------------------------------------------------------------

# Enhanced scatter plot with categories
plot(fev1_data$subject_id, fev1_data$fev1_liters,
     main = "FEV1 Values by Subject and Gender",
     xlab = "Subject ID",
     ylab = "FEV1 (liters)",
     pch = 19,
     cex = 1.5,
     col = ifelse(fev1_data$gender == "M", "blue", "red"))

# Add horizontal lines for category boundaries
abline(h = 2.5, col = "gray", lty = 2)
abline(h = 3.2, col = "gray", lty = 2)

# Add text labels for categories
text(2, 2.3, "Low", col = "gray")
text(2, 2.85, "Normal", col = "gray")
text(2, 3.4, "High", col = "gray")

# Add legend
legend("bottomright",
       legend = c("Male", "Female"),
       col = c("blue", "red"),
       pch = 19,
       title = "Gender")

# ==============================================================================
# ADDITIONAL EXERCISES AND EXAMPLES
# ==============================================================================

# ------------------------------------------------------------------------------
# Rates Calculation Example
# ------------------------------------------------------------------------------

# Disease surveillance data
population_size <- 50000
new_cases <- 125
deaths <- 15

# Calculate incidence rate
incidence_rate <- (new_cases / population_size) * 100000
cat("Incidence rate:", round(incidence_rate, 1), "per 100,000 population\n")

# Calculate case fatality rate
case_fatality_rate <- (deaths / new_cases) * 100
cat("Case fatality rate:", round(case_fatality_rate, 1), "%\n")

# Age-specific rates example
population_by_age <- c(12000, 15000, 18000, 5000)
cases_by_age <- c(5, 25, 65, 30)
age_groups <- c("0-20", "21-40", "41-60", "61+")

age_specific_rates <- calculate_age_specific_rates(cases_by_age,
                                                  population_by_age,
                                                  age_groups)
print(age_specific_rates)

# Visualize age-specific rates
barplot(age_specific_rates,
        main = "Disease Incidence by Age Group",
        xlab = "Age Group",
        ylab = "Rate per 100,000",
        col = "orange",
        border = "white")

# ==============================================================================
# AI USAGE DOCUMENTATION TEMPLATE
# ==============================================================================

# AI Tool Used: [e.g., GitHub Copilot, ChatGPT, Claude]
# Date: [Date of use]
# Version: [if applicable]

# Prompt Used:
# [Record the exact prompt you used]

# AI-Generated Code:
# [Include the code that AI generated]

# Verification Steps:
# 1. [Describe how you tested the code]
# 2. [Any manual calculations performed]
# 3. [Issues found and corrections made]

# Final Assessment:
# [Was the AI output correct? What did you learn?]

# ==============================================================================
# LAB REFLECTION QUESTIONS
# ==============================================================================

# 1. How did using AI tools change your approach to coding in R?
# 2. What were the main challenges in verifying AI-generated statistical code?
# 3. When would you prefer to write code manually vs. using AI assistance?
# 4. How can AI tools best support learning biostatistics concepts?

# ==============================================================================
# SAVE YOUR WORK
# ==============================================================================

# Save workspace
save.image("week1_lab_workspace.RData")

# Save specific objects
save(health_data, fev1_data, file = "week1_lab_data.RData")

# Export data to CSV
write.csv(health_data, "health_data.csv", row.names = FALSE)
write.csv(fev1_data, "fev1_data.csv", row.names = FALSE)

# ==============================================================================
# END OF LAB
# ==============================================================================

cat("Week 1 Lab Complete!\n")
cat("Remember to:\n")
cat("1. Save your R script\n")
cat("2. Document any AI tool usage\n")
cat("3. Verify all results\n")
cat("4. Submit required deliverables\n")