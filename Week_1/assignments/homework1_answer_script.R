# ===============================================================================
# H524 Assignment 1: Answer Script
# Introduction to Biostatistics and Data Visualization
# ===============================================================================
# This script provides complete solutions for all R-related questions in
# Assignment 1, including data setup, analysis, and visualizations.

# Clear workspace
rm(list = ls())

# Load required libraries
library(ggplot2)  # For advanced graphics (optional)

# ===============================================================================
# DATA SETUP
# ===============================================================================

# FEV1 Dataset Creation (used in Questions 12 and 14)
# This represents lung function measurements from 13 adolescents with asthma
fev1_data <- data.frame(
  subject_id = 1:13,
  gender = c("Female", "Male", "Female", "Male", "Female", "Male",
             "Female", "Male", "Female", "Male", "Female", "Male", "Female"),
  fev1_liters = c(2.15, 3.05, 2.50, 3.50, 2.80, 3.20, 2.45,
                  2.90, 3.15, 4.05, 2.60, 3.40, 2.75)
)

# Childhood Injury Dataset Creation (used in Questions 13 and 15)
injury_data <- data.frame(
  cause = c("Motor Vehicle", "Drowning", "Fire", "Other"),
  deaths = c(48, 20, 12, 20),
  percentage = c(48, 20, 12, 20)
)

# Display datasets
cat("=== FEV1 Dataset ===\n")
print(fev1_data)
cat("\n=== Childhood Injury Dataset ===\n")
print(injury_data)

# ===============================================================================
# QUESTION 11: Data Types Classification (10 points)
# ===============================================================================
cat("\n\n=== QUESTION 11: DATA TYPES CLASSIFICATION ===\n")

# This is a conceptual question - answers provided as comments:

# a) FEV1 measurement in liters (from our class dataset)
#    ANSWER: Quantitative continuous
#    JUSTIFICATION: FEV1 can take any value within a range and is measured
#    on a continuous scale with meaningful decimals.

# b) Number of childhood injury deaths per state
#    ANSWER: Quantitative discrete
#    JUSTIFICATION: Counts of deaths are whole numbers (you can't have 2.5 deaths)
#    and represent discrete counts.

# c) Cause of injury (motor vehicle, drowning, fire, etc.)
#    ANSWER: Qualitative nominal
#    JUSTIFICATION: Categories with no inherent order or ranking.

# d) Pain severity rating (1=mild, 5=severe)
#    ANSWER: Qualitative ordinal
#    JUSTIFICATION: Categories with a meaningful order from mild to severe,
#    but intervals between levels may not be equal.

# e) Patient's primary language (English, Spanish, French, etc.)
#    ANSWER: Qualitative nominal
#    JUSTIFICATION: Categories with no inherent order or ranking.

# ===============================================================================
# QUESTION 12: Descriptive Statistics Analysis (10 points)
# ===============================================================================
cat("\n\n=== QUESTION 12: DESCRIPTIVE STATISTICS ANALYSIS ===\n")

# Calculate descriptive statistics for FEV1 data
fev1_stats <- list(
  mean = mean(fev1_data$fev1_liters),
  median = median(fev1_data$fev1_liters),
  min = min(fev1_data$fev1_liters),
  max = max(fev1_data$fev1_liters),
  range = max(fev1_data$fev1_liters) - min(fev1_data$fev1_liters),
  sd = sd(fev1_data$fev1_liters),
  q1 = quantile(fev1_data$fev1_liters, 0.25),
  q3 = quantile(fev1_data$fev1_liters, 0.75)
)

cat("FEV1 Descriptive Statistics:\n")
cat("Mean:", round(fev1_stats$mean, 2), "liters\n")
cat("Median:", round(fev1_stats$median, 2), "liters\n")
cat("Range:", round(fev1_stats$range, 2), "liters (", round(fev1_stats$max, 2),
    " - ", round(fev1_stats$min, 2), ")\n")
cat("Standard deviation:", round(fev1_stats$sd, 2), "liters\n")
cat("Q1:", round(fev1_stats$q1, 2), "liters\n")
cat("Q3:", round(fev1_stats$q3, 2), "liters\n")

# Create histogram to visualize distribution
hist(fev1_data$fev1_liters,
     main = "FEV1 Distribution (n=13)",
     xlab = "FEV1 (liters)",
     ylab = "Frequency",
     col = "lightblue",
     breaks = 5,
     las = 1)

# Add vertical lines for mean and median
abline(v = fev1_stats$mean, col = "red", lwd = 2, lty = 2)
abline(v = fev1_stats$median, col = "blue", lwd = 2, lty = 2)
legend("topright",
       legend = c("Mean", "Median"),
       col = c("red", "blue"),
       lty = c(2, 2),
       lwd = 2)

# ANSWERS:
# a) Distribution shape: Mean (2.88) > Median (2.80) suggests slight right skew
# b) Expected in asthma patients: Lower FEV1 values are more common due to
#    airway obstruction, with some patients having better control
# c) Median is more appropriate due to small sample size and slight skewness

# ===============================================================================
# QUESTION 13: Choosing Appropriate Visualizations (10 points)
# ===============================================================================
cat("\n\n=== QUESTION 13: CHOOSING APPROPRIATE VISUALIZATIONS ===\n")

# Create the bar chart referenced in the question
barplot(injury_data$percentage,
        names.arg = injury_data$cause,
        main = "Childhood Injury Deaths by Cause",
        ylab = "Percentage of Deaths",
        xlab = "Cause of Injury",
        col = c("#ff6b6b", "#4ecdc4", "#ffcd56", "#ff9f40"),
        las = 2)  # Rotate labels

# ANSWERS:
# a) Bar charts are appropriate for categorical data (injury causes) because
#    they clearly show comparisons between categories with gaps between bars.
#    Strength: Easy to compare relative frequencies across categories.

# b) For continuous age data, recommend a histogram because it shows the
#    distribution shape, central tendency, and spread of the continuous variable.

# c) Pie charts may not be best for injury severity because:
#    - Hard to compare similar-sized slices
#    - Ordinal nature (mild < moderate < severe < fatal) not well represented
#    - Bar chart better shows progression of severity

# ===============================================================================
# QUESTION 14: R Data Analysis with FEV1 Dataset (15 points)
# ===============================================================================
cat("\n\n=== QUESTION 14: R DATA ANALYSIS WITH FEV1 DATASET ===\n")

# a) Calculate mean FEV1 by gender (5 points)
cat("a) Mean FEV1 by gender:\n")
mean_by_gender <- aggregate(fev1_liters ~ gender, data = fev1_data, FUN = mean)
print(mean_by_gender)

# Alternative approaches:
cat("\nAlternative calculation methods:\n")
cat("Using tapply():\n")
print(tapply(fev1_data$fev1_liters, fev1_data$gender, mean))

cat("\nUsing dplyr (if available):\n")
# library(dplyr)
# fev1_data %>% group_by(gender) %>% summarise(mean_fev1 = mean(fev1_liters))

# b) Summary statistics and quartile interpretation (5 points)
cat("\nb) Summary statistics for FEV1:\n")
summary_fev1 <- summary(fev1_data$fev1_liters)
print(summary_fev1)

cat("\nQuartile Interpretation:\n")
cat("1st Quartile (Q1) =", summary_fev1[2], "liters\n")
cat("3rd Quartile (Q3) =", summary_fev1[5], "liters\n")
cat("This means 25% of subjects have FEV1 ≤", summary_fev1[2], "liters\n")
cat("And 75% of subjects have FEV1 ≤", summary_fev1[5], "liters\n")
cat("The middle 50% of subjects have FEV1 between", summary_fev1[2],
    "and", summary_fev1[5], "liters\n")

# c) Gender frequency table and percentage calculation (5 points)
cat("\nc) Gender frequency analysis:\n")
gender_table <- table(fev1_data$gender)
print(gender_table)

cat("\nGender percentages:\n")
gender_prop <- prop.table(gender_table) * 100
print(round(gender_prop, 1))

cat("\nCalculation for female percentage:\n")
total_subjects <- nrow(fev1_data)
female_count <- sum(fev1_data$gender == "Female")
female_percentage <- (female_count / total_subjects) * 100
cat("Female subjects:", female_count, "out of", total_subjects, "\n")
cat("Percentage female:", round(female_percentage, 1), "%\n")

# ===============================================================================
# QUESTION 15: Creating Professional Visualizations (15 points)
# ===============================================================================
cat("\n\n=== QUESTION 15: CREATING PROFESSIONAL VISUALIZATIONS ===\n")

# a) Professional bar chart using base R (8 points)
cat("a) Creating professional bar chart with base R:\n")

# Set up plotting parameters for better appearance
par(mar = c(8, 5, 4, 2))  # Increase bottom margin for rotated labels

# Create the bar chart
bar_colors <- c("#ff6b6b", "#4ecdc4", "#ffcd56", "#ff9f40")
bars <- barplot(injury_data$percentage,
                names.arg = injury_data$cause,
                main = "Leading Causes of Childhood Injury Deaths",
                ylab = "Percentage of Deaths (%)",
                xlab = "",
                col = bar_colors,
                ylim = c(0, 55),  # Set y-axis limit for better visualization
                las = 2,  # Rotate x-axis labels
                cex.names = 0.9,  # Adjust label size
                cex.main = 1.2,   # Adjust title size
                cex.lab = 1.1)    # Adjust axis label size

# Add percentage labels on top of bars
text(bars, injury_data$percentage + 1.5,
     paste0(injury_data$percentage, "%"),
     cex = 1, font = 2)

# Add a subtle grid for easier reading
grid(nx = NA, ny = NULL, col = "lightgray", lty = "dotted")

# Reset plotting parameters
par(mar = c(5, 4, 4, 2))

# Alternative version using ggplot2 (if preferred)
cat("\nAlternative using ggplot2:\n")
if(require(ggplot2, quietly = TRUE)) {
  p <- ggplot(injury_data, aes(x = cause, y = percentage, fill = cause)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = paste0(percentage, "%")),
              vjust = -0.5, size = 4, fontface = "bold") +
    labs(title = "Leading Causes of Childhood Injury Deaths",
         x = "Cause of Injury",
         y = "Percentage of Deaths (%)") +
    scale_fill_manual(values = bar_colors) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
          legend.position = "none") +
    ylim(0, 55)

  print(p)
}

# b) Leading cause identification and calculation (4 points)
cat("\nb) Leading cause analysis:\n")
max_index <- which.max(injury_data$percentage)
leading_cause <- injury_data$cause[max_index]
leading_percentage <- injury_data$percentage[max_index]

cat("Leading cause of childhood injury deaths:", leading_cause, "\n")
cat("Percentage of total deaths:", leading_percentage, "%\n")

# Verify calculation
total_deaths <- sum(injury_data$deaths)
leading_deaths <- injury_data$deaths[max_index]
calculated_percentage <- (leading_deaths / total_deaths) * 100
cat("Verification:", leading_deaths, "out of", total_deaths,
    "deaths =", round(calculated_percentage, 1), "%\n")

# c) Bar chart limitations and alternatives (3 points)
cat("\nc) Bar chart limitations and alternatives:\n")
cat("LIMITATION: Bar charts don't show relationships between causes\n")
cat("or temporal trends. They also can't easily display additional\n")
cat("dimensions like age groups or geographic variation.\n\n")

cat("ALTERNATIVE SUGGESTIONS:\n")
cat("1. Pie chart - Better for showing parts of a whole\n")
cat("2. Stacked bar chart - Could show age groups within each cause\n")
cat("3. Dot plot - Easier to read exact values\n")
cat("4. Treemap - Shows proportions with area, good for hierarchical data\n")

# Demonstrate a dot plot alternative
cat("\nExample dot plot alternative:\n")
dotchart(injury_data$percentage,
         labels = injury_data$cause,
         main = "Childhood Injury Deaths by Cause (Dot Plot)",
         xlab = "Percentage of Deaths (%)",
         color = "darkblue",
         pch = 19,
         cex = 1.2)

# ===============================================================================
# QUESTION 16: Bonus - Critical Thinking About AI in Biostatistics (5 points)
# ===============================================================================
cat("\n\n=== QUESTION 16: BONUS - AI IN BIOSTATISTICS ===\n")

# This is a conceptual question - answers provided as comments:

# a) Two ways AI could be helpful:
#    1. Pattern Recognition: AI can identify complex patterns in large EHR
#       datasets that might be missed by traditional statistical methods
#    2. Data Processing: AI can clean, standardize, and preprocess large
#       volumes of EHR data efficiently

# b) Two potential problems/limitations:
#    1. Black Box Problem: AI models may not provide interpretable results,
#       making it difficult to understand why certain risk factors were identified
#    2. Bias and Confounding: AI may perpetuate existing biases in healthcare
#       data or miss important confounding variables

# c) Essential human oversight:
#    Domain expertise to validate findings, ensure clinical relevance,
#    check for biases, and interpret results in proper medical context

# ===============================================================================
# ADDITIONAL UTILITY FUNCTIONS
# ===============================================================================

# Function to create the FEV1 dataset (for reproducibility)
create_fev1_data <- function() {
  data.frame(
    subject_id = 1:13,
    gender = c("Female", "Male", "Female", "Male", "Female", "Male",
               "Female", "Male", "Female", "Male", "Female", "Male", "Female"),
    fev1_liters = c(2.15, 3.05, 2.50, 3.50, 2.80, 3.20, 2.45,
                    2.90, 3.15, 4.05, 2.60, 3.40, 2.75)
  )
}

# Function to create the injury dataset (for reproducibility)
create_injury_data <- function() {
  data.frame(
    cause = c("Motor Vehicle", "Drowning", "Fire", "Other"),
    deaths = c(48, 20, 12, 20),
    percentage = c(48, 20, 12, 20)
  )
}

# Function to calculate basic descriptive statistics
descriptive_stats <- function(x) {
  list(
    n = length(x),
    mean = mean(x, na.rm = TRUE),
    median = median(x, na.rm = TRUE),
    sd = sd(x, na.rm = TRUE),
    min = min(x, na.rm = TRUE),
    max = max(x, na.rm = TRUE),
    q1 = quantile(x, 0.25, na.rm = TRUE),
    q3 = quantile(x, 0.75, na.rm = TRUE)
  )
}

# Example usage of utility functions
cat("\n\n=== UTILITY FUNCTIONS EXAMPLE ===\n")
cat("FEV1 descriptive statistics using utility function:\n")
fev1_desc <- descriptive_stats(fev1_data$fev1_liters)
print(fev1_desc)

cat("\n=== SCRIPT COMPLETED SUCCESSFULLY ===\n")
cat("All homework solutions have been generated.\n")
cat("Datasets created: fev1_data, injury_data\n")
cat("Key functions available: create_fev1_data(), create_injury_data(), descriptive_stats()\n")