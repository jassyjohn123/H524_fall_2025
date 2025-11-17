#!/usr/bin/env Rscript
# ============================================================================
# VERIFICATION SCRIPT: Week 6 Slides - All Numerical Results
# ============================================================================
# This script verifies every numerical claim in the Week 6 slides
# Following CLAUDE.md mandate: NEVER use mental math, ALWAYS verify with R
# ============================================================================

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 6 SLIDES - NUMERICAL VERIFICATION\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

errors_found <- 0

# ============================================================================
# SLIDE: Power Calculation in R (lines 208-226)
# ============================================================================
cat("TEST 1: Power Calculation (Manual)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

mu0 <- 200; mu1 <- 190; sigma <- 30; n <- 25; alpha <- 0.05
se <- sigma / sqrt(n)
cat("Standard error: Expected 6, Got", se, "\n")
if (abs(se - 6) > 0.001) {
  cat("❌ ERROR: SE calculation wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ SE correct\n")
}

z_crit <- qnorm(1 - alpha/2)
cat("Critical z-value: Expected ~1.96, Got", round(z_crit, 2), "\n")
if (abs(z_crit - 1.96) > 0.01) {
  cat("❌ ERROR: z-critical wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ z-critical correct\n")
}

lower_crit <- mu0 - z_crit * se
upper_crit <- mu0 + z_crit * se
cat("Lower critical: Expected 188.24, Got", round(lower_crit, 2), "\n")
cat("Upper critical: Expected 211.76, Got", round(upper_crit, 2), "\n")
if (abs(lower_crit - 188.24) > 0.01 || abs(upper_crit - 211.76) > 0.01) {
  cat("❌ ERROR: Critical values wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Critical values correct\n")
}

power_lower <- pnorm(lower_crit, mean=mu1, sd=se)
power_upper <- pnorm(upper_crit, mean=mu1, sd=se, lower.tail=FALSE)
power <- power_lower + power_upper
cat("Power (manual): Expected 0.385, Got", round(power, 3), "\n")
if (abs(power - 0.385) > 0.001) {
  cat("❌ ERROR: Power calculation wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Power correct\n")
}
cat("\n")

# ============================================================================
# SLIDE: Sample Size Calculation (lines 263-279)
# ============================================================================
cat("TEST 2: Sample Size for Power = 0.80\n")
cat(paste(rep("-", 70), collapse=""), "\n")

result <- power.t.test(delta = 10, sd = 30, sig.level = 0.05,
                       power = 0.80, type = "one.sample")
cat("Required n: Expected ~72.58, Got", round(result$n, 2), "\n")
if (abs(result$n - 72.58) > 0.1) {
  cat("❌ ERROR: Sample size calculation wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Sample size correct (need n=73)\n")
}
cat("\n")

# ============================================================================
# SLIDE: Power for n=25 using power.t.test (lines 288-301)
# ============================================================================
cat("TEST 3: Power for n=25 (power.t.test)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

result <- power.t.test(n = 25, delta = 10, sd = 30,
                       sig.level = 0.05, type = "one.sample")
cat("Power: Expected 0.360, Got", round(result$power, 3), "\n")
if (abs(result$power - 0.360) > 0.001) {
  cat("❌ ERROR: Slide shows 0.360 but actual is", round(result$power, 3), "\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Power correct\n")
}
cat("\n")

# ============================================================================
# SLIDE: Tumor Growth Study (lines 453-483)
# ============================================================================
cat("TEST 4: Two-Sample t-Test (Tumor Growth)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

control <- c(7, 10, 9, 8, 7, 6, 8, 9, 12, 13)
treatment <- c(4, 6, 10, 8, 5, 3, 10, 8, 8, 10)

mean_c <- mean(control)
mean_t <- mean(treatment)
sd_c <- sd(control)
sd_t <- sd(treatment)

cat("Control mean: Expected 8.9, Got", mean_c, "\n")
cat("Treatment mean: Expected 7.2, Got", mean_t, "\n")
cat("Control SD: Expected ~2.234, Got", round(sd_c, 3), "\n")
cat("Treatment SD: Expected ~2.573, Got", round(sd_t, 3), "\n")

if (abs(mean_c - 8.9) > 0.01 || abs(mean_t - 7.2) > 0.01) {
  cat("❌ ERROR: Means wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Means correct\n")
}

if (abs(sd_c - 2.234) > 0.001 || abs(sd_t - 2.573) > 0.001) {
  cat("❌ ERROR: SDs wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ SDs correct\n")
}

result <- t.test(control, treatment, var.equal = TRUE, alternative = "greater")
cat("t-statistic: Expected 1.578, Got", round(result$statistic, 3), "\n")
cat("df: Expected 18, Got", result$parameter, "\n")
cat("p-value: Expected 0.066, Got", round(result$p.value, 3), "\n")

if (abs(result$statistic - 1.578) > 0.001 || result$parameter != 18 ||
    abs(result$p.value - 0.066) > 0.001) {
  cat("❌ ERROR: t-test results wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ t-test results correct\n")
}
cat("\n")

# ============================================================================
# SLIDE: Blood Pressure Paired t-Test (lines 628-658)
# ============================================================================
cat("TEST 5: Paired t-Test (Blood Pressure)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

before <- c(145, 150, 148, 142, 140, 146, 149, 143, 147, 144)
after <- c(138, 142, 145, 138, 135, 140, 142, 136, 141, 138)
differences <- before - after

mean_diff <- mean(differences)
sd_diff <- sd(differences)

cat("Mean difference: Expected 5.9, Got", mean_diff, "\n")
cat("SD of differences: Expected ~1.52, Got", round(sd_diff, 2), "\n")

if (abs(mean_diff - 5.9) > 0.01 || abs(sd_diff - 1.52) > 0.01) {
  cat("❌ ERROR: Difference statistics wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Difference statistics correct\n")
}

result <- t.test(differences, mu = 0, alternative = "greater")
cat("t-statistic: Expected 12.24, Got", round(result$statistic, 2), "\n")
cat("df: Expected 9, Got", result$parameter, "\n")
cat("p-value: Expected ~3.24e-07, Got", format(result$p.value, scientific=TRUE), "\n")

if (abs(result$statistic - 12.24) > 0.01 || result$parameter != 9) {
  cat("❌ ERROR: Paired t-test results wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Paired t-test results correct\n")
}
cat("\n")

# ============================================================================
# SLIDE: ANOVA Drug Dose Study (lines 923-953)
# ============================================================================
cat("TEST 6: ANOVA (Cholesterol Drug Doses)\n")
cat(paste(rep("-", 70), collapse=""), "\n")

low <- c(10, 12, 8, 11, 9)
medium <- c(15, 18, 16, 20, 17)
high <- c(25, 28, 30, 26, 27)

cat("Low mean: Expected 10.0, Got", mean(low), "\n")
cat("Medium mean: Expected 17.2, Got", mean(medium), "\n")
cat("High mean: Expected 27.2, Got", mean(high), "\n")

if (abs(mean(low) - 10.0) > 0.01 || abs(mean(medium) - 17.2) > 0.01 ||
    abs(mean(high) - 27.2) > 0.01) {
  cat("❌ ERROR: Group means wrong!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ Group means correct\n")
}

cat("Low SD: Expected ~1.58, Got", round(sd(low), 2), "\n")
cat("Medium SD: Expected ~1.92, Got", round(sd(medium), 2), "\n")
cat("High SD: Expected ~1.92, Got", round(sd(high), 2), "\n")

cholesterol <- c(low, medium, high)
dose <- factor(rep(c("Low", "Medium", "High"), each=5),
               levels=c("Low", "Medium", "High"))
data <- data.frame(cholesterol, dose)

model <- aov(cholesterol ~ dose, data=data)
anova_result <- summary(model)[[1]]

cat("\nANOVA Table:\n")
print(anova_result)

cat("\nVerifying ANOVA values from slide:\n")
cat("SS(dose): Expected 746.1, Got", round(anova_result["dose", "Sum Sq"], 1), "\n")
cat("MS(dose): Expected 373.1, Got", round(anova_result["dose", "Mean Sq"], 1), "\n")
cat("SS(Residuals): Expected 39.6, Got", round(anova_result["Residuals", "Sum Sq"], 1), "\n")
cat("MS(Residuals): Expected 3.3, Got", round(anova_result["Residuals", "Mean Sq"], 1), "\n")
cat("F-statistic: Expected 113.1, Got", round(anova_result["dose", "F value"], 1), "\n")

if (abs(anova_result["dose", "Sum Sq"] - 746.1) > 0.2 ||
    abs(anova_result["dose", "Mean Sq"] - 373.1) > 0.2 ||
    abs(anova_result["dose", "F value"] - 113.1) > 0.2) {
  cat("❌ ERROR: ANOVA values don't match slide!\n")
  errors_found <- errors_found + 1
} else {
  cat("✓ ANOVA values correct\n")
}
cat("\n")

# ============================================================================
# SLIDE: Tukey's HSD (lines 998-1017)
# ============================================================================
cat("TEST 7: Tukey's HSD Post-Hoc Test\n")
cat(paste(rep("-", 70), collapse=""), "\n")

tukey_result <- TukeyHSD(model)
print(tukey_result)

cat("\nVerifying Tukey differences from slide:\n")
cat("Medium-Low: Expected 7.2, Got", tukey_result$dose["Medium-Low", "diff"], "\n")
cat("High-Low: Expected 17.2, Got", tukey_result$dose["High-Low", "diff"], "\n")
cat("High-Medium: Expected 10.0, Got", tukey_result$dose["High-Medium", "diff"], "\n")

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
# FINAL SUMMARY
# ============================================================================
cat(paste(rep("=", 70), collapse=""), "\n")
cat("VERIFICATION COMPLETE\n")
cat(paste(rep("=", 70), collapse=""), "\n")

if (errors_found == 0) {
  cat("✅ ALL SLIDES CALCULATIONS VERIFIED CORRECT!\n")
  cat("No errors found. All numerical values match R output.\n")
} else {
  cat("❌ ERRORS FOUND:", errors_found, "\n")
  cat("Some slide values do not match actual R calculations!\n")
}
cat(paste(rep("=", 70), collapse=""), "\n")
