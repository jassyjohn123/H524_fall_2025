# Week 1 R Examples for H524 Biostatistics
# Introduction to R, Data Presentation, and Summary Measures

# Set working directory to Week_1 folder (adjust as needed for your system)
# setwd("/Users/molitorj/ms/OSU/classes/AI_H524/H524_fall_2025/Week_1")

# Load required libraries
library(ggplot2)

# Example 1: Basic R operations and data types
cat("=== Basic R Operations ===\n")

# Basic arithmetic
x <- 5
y <- 3
cat("x =", x, ", y =", y, "\n")
cat("x + y =", x + y, "\n")
cat("x * y =", x * y, "\n")

# Data types
age <- 25
name <- "John"
is_student <- TRUE
cat("Age (numeric):", age, "\n")
cat("Name (character):", name, "\n")
cat("Is student (logical):", is_student, "\n")

# Vectors
ages <- c(22, 25, 28, 30, 35, 40, 45, 50, 55, 60)
cat("Ages vector:", ages, "\n")

# Example 2: Biostatistics dataset - Blood pressure study
set.seed(123)  # For reproducible results
n <- 100

# Generate sample data for blood pressure study
bp_data <- data.frame(
  id = 1:n,
  age = round(rnorm(n, mean = 45, sd = 15)),
  gender = sample(c("Male", "Female"), n, replace = TRUE),
  systolic_bp = round(rnorm(n, mean = 130, sd = 20)),
  treatment = sample(c("Control", "Treatment A", "Treatment B"), n, replace = TRUE)
)

# Ensure realistic age range
bp_data$age[bp_data$age < 18] <- 18
bp_data$age[bp_data$age > 80] <- 80

# Adjust BP based on age and gender (more realistic)
bp_data$systolic_bp <- bp_data$systolic_bp + 0.5 * (bp_data$age - 45) +
                       ifelse(bp_data$gender == "Male", 5, 0)

# Round to whole numbers
bp_data$systolic_bp <- round(bp_data$systolic_bp)

cat("\n=== Blood Pressure Study Data ===\n")
cat("First 6 rows of data:\n")
print(head(bp_data))

# Basic descriptive statistics
cat("\n=== Descriptive Statistics ===\n")
cat("Sample size:", nrow(bp_data), "\n")
cat("Mean age:", round(mean(bp_data$age), 1), "years\n")
cat("Mean systolic BP:", round(mean(bp_data$systolic_bp), 1), "mmHg\n")
cat("SD systolic BP:", round(sd(bp_data$systolic_bp), 1), "mmHg\n")

# Summary statistics
cat("\n=== Summary Statistics for Systolic BP ===\n")
print(summary(bp_data$systolic_bp))

# Frequency table for categorical data
cat("\n=== Frequency Tables ===\n")
cat("Gender distribution:\n")
print(table(bp_data$gender))
cat("\nTreatment group distribution:\n")
print(table(bp_data$treatment))

# Example 3: Create visualizations

# 1. Histogram of systolic blood pressure
pdf("histogram_bp.pdf", width = 8, height = 6)
hist(bp_data$systolic_bp,
     main = "Distribution of Systolic Blood Pressure",
     xlab = "Systolic BP (mmHg)",
     ylab = "Frequency",
     col = "lightblue",
     border = "black",
     breaks = 12)
abline(v = mean(bp_data$systolic_bp), col = "red", lwd = 2, lty = 2)
legend("topright", paste("Mean =", round(mean(bp_data$systolic_bp), 1)),
       col = "red", lty = 2, lwd = 2)
dev.off()

# 2. Box plot by gender
pdf("boxplot_gender.pdf", width = 8, height = 6)
boxplot(systolic_bp ~ gender, data = bp_data,
        main = "Systolic Blood Pressure by Gender",
        xlab = "Gender",
        ylab = "Systolic BP (mmHg)",
        col = c("pink", "lightblue"))
dev.off()

# 3. Bar chart for treatment groups
pdf("barplot_treatment.pdf", width = 8, height = 6)
treatment_counts <- table(bp_data$treatment)
barplot(treatment_counts,
        main = "Distribution of Treatment Groups",
        xlab = "Treatment Group",
        ylab = "Number of Participants",
        col = c("lightgreen", "orange", "lightcoral"))
dev.off()

# 4. Scatter plot: Age vs Blood Pressure
pdf("scatter_age_bp.pdf", width = 8, height = 6)
plot(bp_data$age, bp_data$systolic_bp,
     main = "Age vs Systolic Blood Pressure",
     xlab = "Age (years)",
     ylab = "Systolic BP (mmHg)",
     pch = 19,
     col = alpha("blue", 0.6))
# Add regression line
abline(lm(systolic_bp ~ age, data = bp_data), col = "red", lwd = 2)
correlation <- cor(bp_data$age, bp_data$systolic_bp)
legend("topleft", paste("r =", round(correlation, 3)), bty = "n")
dev.off()

# Example 4: Rates calculation
cat("\n=== Rates Calculation Example ===\n")

# Simulate disease data for rate calculation
population_size <- 50000
new_cases <- 125
deaths <- 15

# Calculate rates
incidence_rate <- (new_cases / population_size) * 100000
case_fatality_rate <- (deaths / new_cases) * 100

cat("Population size:", population_size, "\n")
cat("New disease cases:", new_cases, "\n")
cat("Deaths from disease:", deaths, "\n")
cat("Incidence rate:", round(incidence_rate, 1), "per 100,000 population\n")
cat("Case fatality rate:", round(case_fatality_rate, 1), "%\n")

# Age-specific rates example
age_groups <- c("0-19", "20-39", "40-59", "60+")
population_by_age <- c(12000, 15000, 18000, 5000)
cases_by_age <- c(5, 25, 65, 30)

age_specific_rates <- (cases_by_age / population_by_age) * 100000

cat("\n=== Age-Specific Rates ===\n")
for(i in 1:length(age_groups)) {
  cat("Age group", age_groups[i], ":", round(age_specific_rates[i], 1),
      "per 100,000\n")
}

# Create age-specific rates plot
pdf("age_specific_rates.pdf", width = 8, height = 6)
barplot(age_specific_rates,
        names.arg = age_groups,
        main = "Age-Specific Disease Incidence Rates",
        xlab = "Age Group",
        ylab = "Rate per 100,000",
        col = "steelblue")
dev.off()

cat("\n=== All plots saved as PDF files ===\n")
cat("Files created:\n")
cat("- histogram_bp.pdf\n")
cat("- boxplot_gender.pdf\n")
cat("- barplot_treatment.pdf\n")
cat("- scatter_age_bp.pdf\n")
cat("- age_specific_rates.pdf\n")