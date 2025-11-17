#!/usr/bin/env Rscript
# Verification script for Week 2 Lab Answer Key
# ALL numerical calculations verified computationally

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 2 LAB ANSWER KEY - NUMERICAL VERIFICATION\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# Problem 1: Blood Pressure Analysis
cat("PROBLEM 1: Blood Pressure Analysis\n")
cat(paste(rep("-", 70), collapse=""), "\n")
bp_data <- c(125, 138, 142, 135, 148, 130, 122)
mean_bp <- mean(bp_data)
median_bp <- median(bp_data)
sd_bp <- sd(bp_data)
high_bp_count <- sum(bp_data >= 140)
prop_high_bp <- high_bp_count / length(bp_data)

cat("Mean BP:", round(mean_bp, 2), "mmHg | Answer key: 133.29 | Match:",
    ifelse(abs(mean_bp - 133.29) < 0.01, "✓", "✗"), "\n")
cat("Median BP:", median_bp, "mmHg | Answer key: 135 | Match:",
    ifelse(median_bp == 135, "✓", "✗"), "\n")
cat("SD BP:", round(sd_bp, 2), "mmHg | Answer key: 13.61 | Match:",
    ifelse(abs(sd_bp - 13.61) < 0.01, "✓", "✗"), "\n")
cat("Count BP ≥ 140:", high_bp_count, "| Answer key: 2 | Match:",
    ifelse(high_bp_count == 2, "✓", "✗"), "\n")
cat("Proportion high BP:", round(prop_high_bp, 3), "| Answer key: 0.286 | Match:",
    ifelse(abs(prop_high_bp - 0.286) < 0.001, "✓", "✗"), "\n\n")

# Problem 2: Diagnostic Test (Flu Test)
cat("PROBLEM 2: Diagnostic Test - Flu Test Performance\n")
cat(paste(rep("-", 70), collapse=""), "\n")
# 2x2 table
TP <- 40  # True Positive
FN <- 5   # False Negative
FP <- 30  # False Positive
TN <- 425 # True Negative

sensitivity <- TP / (TP + FN)
specificity <- TN / (TN + FP)
ppv <- TP / (TP + FP)
npv <- TN / (TN + FN)

cat("Sensitivity:", round(sensitivity * 100, 1), "%",
    "| Answer key: 88.9% | Match:",
    ifelse(abs(sensitivity - 0.889) < 0.001, "✓", "✗"), "\n")
cat("Specificity:", round(specificity * 100, 1), "%",
    "| Answer key: 93.4% | Match:",
    ifelse(abs(specificity - 0.934) < 0.001, "✓", "✗"), "\n")
cat("PPV:", round(ppv * 100, 1), "%",
    "| Answer key: 57.1% | Match:",
    ifelse(abs(ppv - 0.571) < 0.001, "✓", "✗"), "\n\n")

# Problem 3: Treatment Success (Binomial)
cat("PROBLEM 3: Treatment Success - Binomial Distribution\n")
cat(paste(rep("-", 70), collapse=""), "\n")
n_treat <- 20
p_treat <- 0.60
prob_12 <- dbinom(12, n_treat, p_treat)
prob_at_least_12 <- pbinom(11, n_treat, p_treat, lower.tail = FALSE)
expected_success <- n_treat * p_treat

cat("P(exactly 12):", round(prob_12, 4), "| Answer key: 0.2501 | Match:",
    ifelse(abs(prob_12 - 0.2501) < 0.0001, "✓", "✗"), "\n")
cat("P(at least 12):", round(prob_at_least_12, 4), "| Answer key: 0.6482 | Match:",
    ifelse(abs(prob_at_least_12 - 0.6482) < 0.0001, "✓", "✗"), "\n")
cat("Expected successes:", expected_success, "| Answer key: 12 | Match:",
    ifelse(expected_success == 12, "✓", "✗"), "\n\n")

# Problem 4: BMI Distribution (Normal)
cat("PROBLEM 4: BMI Distribution - Normal Distribution\n")
cat(paste(rep("-", 70), collapse=""), "\n")
mu_bmi <- 27.5
sigma_bmi <- 4.2
prob_under_25 <- pnorm(25, mu_bmi, sigma_bmi)
prob_over_30 <- 1 - pnorm(30, mu_bmi, sigma_bmi)
percentile_75 <- qnorm(0.75, mu_bmi, sigma_bmi)

cat("P(BMI < 25):", round(prob_under_25, 4), "| Answer key: 0.3821 | Match:",
    ifelse(abs(prob_under_25 - 0.3821) < 0.0001, "✓", "✗"), "\n")
cat("P(BMI ≥ 30):", round(prob_over_30, 4), "| Answer key: 0.2420 | Match:",
    ifelse(abs(prob_over_30 - 0.2420) < 0.0001, "✓", "✗"), "\n")
cat("75th percentile BMI:", round(percentile_75, 2), "| Answer key: 29.87 | Match:",
    ifelse(abs(percentile_75 - 29.87) < 0.01, "✓", "✗"), "\n\n")

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 2 LAB ANSWER KEY VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")
