################################################################################
# H524 Introduction to Biostatistics
# Week 8: Contingency Tables and Chi-Square Tests
# Fall 2025
# Dr. John Molitor
################################################################################

# Clear workspace and set options
rm(list = ls())
options(scipen = 999)  # Avoid scientific notation
set.seed(123)         # For reproducibility

################################################################################
# SECTION 1: CHI-SQUARE GOODNESS-OF-FIT TEST
################################################################################

# Example 1: Blood Type Distribution
# Test if hospital blood type distribution matches U.S. population

# Observed counts
observed <- c(85, 78, 28, 9)

# Expected proportions (U.S. population)
expected_props <- c(0.45, 0.40, 0.11, 0.04)

# Chi-square goodness-of-fit test
chisq.test(observed, p = expected_props)

# Manual calculation for understanding
expected <- sum(observed) * expected_props
chi_sq <- sum((observed - expected)^2 / expected)
cat("Chi-square statistic:", round(chi_sq, 4), "\n")
cat("Expected counts:", round(expected, 2), "\n")

################################################################################
# SECTION 2: CHI-SQUARE TEST OF INDEPENDENCE (2×2 TABLE)
################################################################################

# Example 3: Smoking and Lung Cancer
# Create contingency table
data <- matrix(c(85, 55, 15, 45), nrow = 2, byrow = TRUE)
rownames(data) <- c("Smoker", "Non-smoker")
colnames(data) <- c("Cancer", "No Cancer")

# Display the table
data

# Chi-square test of independence
chisq.test(data)

# With continuity correction (Yates' correction for 2×2 tables)
chisq.test(data, correct = TRUE)

# Without correction (matches hand calculation)
chisq.test(data, correct = FALSE)

################################################################################
# SECTION 3: FISHER'S EXACT TEST
################################################################################

# Fisher's Exact Test: Tea Tasting Example
tea <- matrix(c(4, 0, 0, 4), nrow = 2)
fisher.test(tea)

# Fisher's Exact Test: Small clinical trial
# For 2×2 table with small sample size
data_small <- matrix(c(8, 2, 3, 7), nrow = 2)
fisher.test(data_small)

# Extract specific results
result <- fisher.test(data_small)
result$p.value       # p-value
result$estimate      # Odds ratio
result$conf.int      # 95% CI for odds ratio

################################################################################
# SECTION 4: EFFECT SIZES - ODDS RATIO AND RELATIVE RISK (WEEK 9 PREVIEW)
################################################################################

# NOTE: This section previews Week 9 content on effect sizes
# Optional for Week 8, will be covered in detail next week

# Using the smoking and lung cancer data
data <- matrix(c(85, 55, 15, 45), nrow = 2, byrow = TRUE)

# Odds ratio using fisher.test
result <- fisher.test(data)
result$estimate    # Odds ratio
result$conf.int    # 95% CI

# Manual calculation of odds ratio
OR <- (data[1, 1] * data[2, 2]) / (data[1, 2] * data[2, 1])
cat("Odds Ratio:", round(OR, 2), "\n")

# Manual calculation of relative risk
RR <- (data[1, 1] / sum(data[1, ])) /
      (data[2, 1] / sum(data[2, ]))
cat("Relative Risk:", round(RR, 2), "\n")

################################################################################
# SECTION 5: LARGER CONTINGENCY TABLES (r × c)
################################################################################

# Example: 3×3 table - Education and Exercise
# Create data matrix
data_large <- matrix(c(35, 45, 20,
                       25, 40, 35,
                       15, 30, 55), nrow = 3, byrow = TRUE)
rownames(data_large) <- c("High School", "Bachelor's", "Graduate")
colnames(data_large) <- c("Never", "Sometimes", "Regularly")

# Display the table
data_large

# Chi-square test
chisq.test(data_large)

# Get expected counts
chisq_result <- chisq.test(data_large)
chisq_result$expected    # Expected counts under independence
chisq_result$residuals   # Standardized residuals (for interpretation)

################################################################################
# SECTION 6: VISUALIZING CONTINGENCY TABLES
################################################################################

# Create data for visualization
data <- matrix(c(85, 55, 15, 45), nrow = 2)
rownames(data) <- c("Smoker", "Non-smoker")
colnames(data) <- c("Cancer", "No Cancer")

# Mosaic plot
mosaicplot(data,
           main = "Smoking and Lung Cancer",
           color = c("darkred", "lightblue"),
           xlab = "Smoking Status",
           ylab = "Cancer Status")

# Bar plot
barplot(data,
        beside = TRUE,
        legend = TRUE,
        col = c("darkred", "lightblue"),
        main = "Smoking and Lung Cancer",
        xlab = "Cancer Status",
        ylab = "Frequency",
        args.legend = list(title = "Smoking Status"))

################################################################################
# SECTION 7: CHECKING ASSUMPTIONS
################################################################################

# Function to check chi-square test assumptions
check_chisq_assumptions <- function(observed, expected_props = NULL) {
  if (is.matrix(observed)) {
    # For contingency table
    result <- chisq.test(observed)
    expected <- result$expected
  } else {
    # For goodness-of-fit
    if (is.null(expected_props)) {
      stop("Must provide expected proportions for goodness-of-fit test")
    }
    expected <- sum(observed) * expected_props
  }

  cat("Expected counts:\n")
  print(round(expected, 2))
  cat("\n")

  min_expected <- min(expected)
  cat("Minimum expected count:", round(min_expected, 2), "\n")

  if (min_expected < 5) {
    cat("WARNING: Expected count < 5 detected!\n")
    cat("Consider:\n")
    cat("  - Using Fisher's exact test (for 2×2 tables)\n")
    cat("  - Combining categories\n")
    cat("  - Using exact tests for larger tables\n")
  } else {
    cat("✓ All expected counts ≥ 5 - assumptions satisfied\n")
  }

  invisible(expected)
}

# Example: Check assumptions
observed <- c(85, 78, 28, 9)
expected_props <- c(0.45, 0.40, 0.11, 0.04)
check_chisq_assumptions(observed, expected_props)

################################################################################
# SECTION 8: MCNEMAR'S TEST (PAIRED DATA)
################################################################################

# Example: Before/After study
# Public health campaign - attitudes before and after
data_paired <- matrix(c(18, 12, 22, 8), nrow = 2, byrow = TRUE)
rownames(data_paired) <- c("Before: Positive", "Before: Negative")
colnames(data_paired) <- c("After: Positive", "After: Negative")

# Display table
data_paired

# McNemar's test
mcnemar.test(data_paired, correct = FALSE)

# With continuity correction
mcnemar.test(data_paired, correct = TRUE)

################################################################################
# SECTION 9: COMPLETE ANALYSIS EXAMPLE
################################################################################

# Complete workflow: Smoking and lung cancer case-control study

# Step 1: Create the data
smoking_data <- matrix(c(85, 55, 15, 45), nrow = 2, byrow = TRUE)
rownames(smoking_data) <- c("Smoker", "Non-smoker")
colnames(smoking_data) <- c("Cancer", "No Cancer")

# Step 2: Examine the data
cat("Contingency Table:\n")
print(smoking_data)
cat("\n")

# Step 3: Check assumptions
cat("Expected counts:\n")
expected <- chisq.test(smoking_data)$expected
print(round(expected, 2))
cat("\n")

# Step 4: Perform chi-square test
cat("Chi-square test:\n")
test_result <- chisq.test(smoking_data, correct = FALSE)
print(test_result)
cat("\n")

# Step 5: Calculate effect sizes
cat("Effect sizes:\n")
fisher_result <- fisher.test(smoking_data)
cat("Odds Ratio:", round(fisher_result$estimate, 2), "\n")
cat("95% CI for OR: (", round(fisher_result$conf.int[1], 2), ",",
    round(fisher_result$conf.int[2], 2), ")\n")

# Step 6: Interpret results
if (test_result$p.value < 0.05) {
  cat("\nConclusion: There is strong evidence of an association between")
  cat(" smoking and lung cancer (p < 0.05).\n")
  cat("Smokers have", round(fisher_result$estimate, 1),
      "times the odds of lung cancer compared to non-smokers.\n")
} else {
  cat("\nConclusion: No significant association detected (p ≥ 0.05).\n")
}

################################################################################
# SECTION 10: POWER CALCULATION FOR CHI-SQUARE TEST
################################################################################

# Power calculation (requires 'pwr' package)
if (!require(pwr)) {
  install.packages("pwr")
  library(pwr)
}

# Power for chi-square test
# Effect size w = 0.3 (medium effect)
# df = 1 (for 2×2 table)
# alpha = 0.05
pwr.chisq.test(w = 0.3, df = 1, sig.level = 0.05, power = 0.8)

# Sample size needed for power = 0.80
pwr.chisq.test(w = 0.3, df = 1, sig.level = 0.05, power = 0.80)$N

################################################################################
# END OF WEEK 8 LECTURE CODE
################################################################################
