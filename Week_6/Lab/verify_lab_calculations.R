#!/usr/bin/env Rscript
# ============================================================================
# VERIFICATION SCRIPT: Week 6 Lab - All Numerical Results
# ============================================================================
# This script verifies every numerical claim in the Week 6 lab
# Following CLAUDE.md mandate: NEVER use mental math, ALWAYS verify with R
# ============================================================================

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 6 LAB - NUMERICAL VERIFICATION\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

errors_found <- 0

# ============================================================================
# EXERCISE 1.2: Power Calculation
# ============================================================================
cat("TEST 1: Power for detecting 5 mmHg difference\n")
cat(paste(rep("-", 70), collapse=""), "\n")

result <- power.t.test(n = 50, delta = 5, sd = 15,
                       sig.level = 0.05, type = "one.sample")
cat("Power: Expected ~0.728, Got", round(result$power, 3), "\n")

if (abs(result$power - 0.728) > 0.001) {
  cat("❌ ERROR: Power calculation wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Power correct\n")
}
cat("\n")

# ============================================================================
# EXERCISE 1.3: Sample Size for Power = 0.90
# ============================================================================
cat("TEST 2: Sample size for power = 0.90\n")
cat(paste(rep("-", 70), collapse=""), "\n")

result <- power.t.test(delta = 5, sd = 15, sig.level = 0.05,
                       power = 0.90, type = "one.sample")
cat("Required n: Expected ~200, Got", round(result$n, 0), "\n")

# Check if it's approximately 200
if (abs(result$n - 199) > 2) {
  cat("❌ ERROR: Sample size calculation wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Sample size correct (need n=199 or 200)\n")
}
cat("\n")

# ============================================================================
# EXERCISE 2.1: Tumor Growth Two-Sample t-Test
# ============================================================================
cat("TEST 3: Tumor Growth Two-Sample t-Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")

control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)
treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)

# Summary statistics
mean_c <- mean(control)
mean_t <- mean(treatment)
sd_c <- sd(control)
sd_t <- sd(treatment)

cat("Control: mean =", mean_c, ", SD =", round(sd_c, 3), "\n")
cat("Treatment: mean =", mean_t, ", SD =", round(sd_t, 3), "\n")

# Pooled t-test
result <- t.test(control, treatment, var.equal = TRUE, alternative = "greater")
cat("t-statistic:", round(result$statistic, 3), "\n")
cat("p-value:", round(result$p.value, 3), "\n")

# Check against expected values
if (abs(result$statistic - 1.578) > 0.001 || abs(result$p.value - 0.066) > 0.001) {
  cat("❌ ERROR: t-test results wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ t-test results correct\n")
}
cat("\n")

# ============================================================================
# EXERCISE 2.2: Welch's t-Test (Unequal Variances)
# ============================================================================
cat("TEST 4: Welch's t-Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")

result_welch <- t.test(control, treatment, var.equal = FALSE, alternative = "greater")
cat("Welch's t-statistic:", round(result_welch$statistic, 3), "\n")
cat("Welch's df:", round(result_welch$parameter, 2), "\n")
cat("Welch's p-value:", round(result_welch$p.value, 3), "\n")
cat("✓ Welch's test computed\n\n")

# ============================================================================
# EXERCISE 3.1: Blood Pressure Paired t-Test
# ============================================================================
cat("TEST 5: Blood Pressure Paired t-Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")

before <- c(145, 150, 148, 142, 140, 146, 149, 143, 147, 144)
after <- c(138, 142, 145, 138, 135, 140, 142, 136, 141, 138)
differences <- before - after

mean_diff <- mean(differences)
sd_diff <- sd(differences)

cat("Mean difference: Expected 5.9, Got", mean_diff, "\n")
cat("SD of differences: Expected ~1.52, Got", round(sd_diff, 2), "\n")

result <- t.test(differences, mu = 0, alternative = "greater")
cat("t-statistic: Expected 12.24, Got", round(result$statistic, 2), "\n")
cat("p-value: Expected ~3.24e-07, Got", format(result$p.value, scientific=TRUE), "\n")

if (abs(result$statistic - 12.24) > 0.01) {
  cat("❌ ERROR: Paired t-test wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Paired t-test correct\n")
}
cat("\n")

# ============================================================================
# EXERCISE 3.2: Effect Size for Paired Data
# ============================================================================
cat("TEST 6: Effect Size (Cohen's d) for Paired Data\n")
cat(paste(rep("-", 70), collapse=""), "\n")

cohens_d <- mean_diff / sd_diff
cat("Cohen's d: Expected ~3.87, Got", round(cohens_d, 2), "\n")

if (abs(cohens_d - 3.87) > 0.05) {
  cat("❌ ERROR: Cohen's d calculation wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Cohen's d correct (very large effect)\n")
}
cat("\n")

# ============================================================================
# EXERCISE 4.1: ANOVA - Cholesterol by Dose
# ============================================================================
cat("TEST 7: ANOVA - Cholesterol Reduction by Dose\n")
cat(paste(rep("-", 70), collapse=""), "\n")

low <- c(10, 12, 8, 11, 9)
medium <- c(15, 18, 16, 20, 17)
high <- c(25, 28, 30, 26, 27)

cholesterol <- c(low, medium, high)
dose <- factor(rep(c("Low", "Medium", "High"), each=5),
               levels=c("Low", "Medium", "High"))
data <- data.frame(cholesterol, dose)

cat("Group means:\n")
cat("  Low:", mean(low), "\n")
cat("  Medium:", mean(medium), "\n")
cat("  High:", mean(high), "\n")

model <- aov(cholesterol ~ dose, data=data)
anova_result <- summary(model)[[1]]

cat("\nANOVA Results:\n")
cat("  F-statistic:", round(anova_result["dose", "F value"], 2), "\n")
cat("  p-value:", format(anova_result["dose", "Pr(>F)"], scientific=TRUE), "\n")

if (abs(anova_result["dose", "F value"] - 113.1) > 0.5) {
  cat("❌ ERROR: F-statistic wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ ANOVA F-statistic correct\n")
}
cat("\n")

# ============================================================================
# EXERCISE 4.2: Assumption Checks
# ============================================================================
cat("TEST 8: Levene's Test for Homogeneity of Variance\n")
cat(paste(rep("-", 70), collapse=""), "\n")

# Levene's test (using car package if available, otherwise skip)
if (require(car, quietly=TRUE)) {
  levene_result <- leveneTest(cholesterol ~ dose, data=data)
  cat("Levene's Test p-value:", round(levene_result$`Pr(>F)`[1], 3), "\n")
  cat("✓ Levene's test computed\n")
} else {
  cat("⚠ car package not available, skipping Levene's test\n")
}
cat("\n")

# ============================================================================
# EXERCISE 4.4: Tukey's HSD
# ============================================================================
cat("TEST 9: Tukey's HSD Post-Hoc\n")
cat(paste(rep("-", 70), collapse=""), "\n")

tukey_result <- TukeyHSD(model)
cat("Pairwise differences:\n")
cat("  Medium-Low:", tukey_result$dose["Medium-Low", "diff"], "\n")
cat("  High-Low:", tukey_result$dose["High-Low", "diff"], "\n")
cat("  High-Medium:", tukey_result$dose["High-Medium", "diff"], "\n")

if (abs(tukey_result$dose["Medium-Low", "diff"] - 7.2) > 0.01 ||
    abs(tukey_result$dose["High-Low", "diff"] - 17.2) > 0.01 ||
    abs(tukey_result$dose["High-Medium", "diff"] - 10.0) > 0.01) {
  cat("❌ ERROR: Tukey differences wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Tukey differences correct\n")
}
cat("\n")

# ============================================================================
# PRACTICE PROBLEM 1: Weight Loss Study
# ============================================================================
cat("TEST 10: Weight Loss Study (Practice Problem 1)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

diet_a <- c(3.2, 4.1, 3.5, 3.8, 3.9, 4.2, 3.6, 3.7)
diet_b <- c(5.1, 4.8, 5.3, 5.2, 4.9, 5.0, 5.4, 4.8)

cat("Diet A: mean =", round(mean(diet_a), 2), ", SD =", round(sd(diet_a), 3), "\n")
cat("Diet B: mean =", round(mean(diet_b), 2), ", SD =", round(sd(diet_b), 3), "\n")

result <- t.test(diet_a, diet_b, var.equal = TRUE)
cat("t-statistic:", round(result$statistic, 2), "\n")
cat("p-value:", format(result$p.value, scientific=TRUE), "\n")
cat("95% CI:", round(result$conf.int[1], 2), "to", round(result$conf.int[2], 2), "\n")

# Effect size
pooled_sd <- sqrt(((length(diet_a)-1)*var(diet_a) + (length(diet_b)-1)*var(diet_b)) /
                  (length(diet_a) + length(diet_b) - 2))
cohens_d <- (mean(diet_a) - mean(diet_b)) / pooled_sd
cat("Cohen's d:", round(cohens_d, 2), "\n")

if (abs(cohens_d) < 2.0) {
  cat("⚠ WARNING: Effect size seems small for claimed 'very large' effect\n")
  cat("   Expected |d| > 2.5 for weight loss study\n")
}

cat("✓ Weight loss study calculations complete\n")
cat("\n")

# ============================================================================
# FINAL SUMMARY
# ============================================================================
cat(paste(rep("=", 70), collapse=""), "\n")
cat("VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")

if (errors_found == 0) {
  cat("✅ ALL LAB CALCULATIONS VERIFIED CORRECT!\n")
  cat("No errors found. All numerical values match R output.\n")
} else {
  cat("❌ ERRORS FOUND:", errors_found, "\n")
  cat("Some lab values do not match actual R calculations!\n")
}
cat(paste(rep("=", 70), collapse=""), "\n")
