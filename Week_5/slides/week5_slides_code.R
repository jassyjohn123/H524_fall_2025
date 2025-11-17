#!/usr/bin/env Rscript
# Week 5 Slides - R Code Examples
# All examples from lecture slides for student reference
# Topic: Hypothesis Testing
# Created: 2025-10-26

cat("WEEK 5 SLIDES: HYPOTHESIS TESTING - R CODE EXAMPLES\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# ==============================================================================
# EXAMPLE 1: Body Temperature (Two-Sided t-Test)
# ==============================================================================
cat("EXAMPLE 1: Body Temperature (Two-Sided t-Test)\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

cat("Research Question:\n")
cat("Is the mean body temperature really 98.6°F?\n\n")

# Given summary statistics from slide
n1 <- 130
xbar1 <- 98.25
s1 <- 0.73
mu0_1 <- 98.6

cat("Data:\n")
cat("  Sample size (n):", n1, "\n")
cat("  Sample mean (xbar):", xbar1, "°F\n")
cat("  Sample SD (s):", s1, "°F\n")
cat("  Null value (mu0):", mu0_1, "°F\n\n")

cat("Hypotheses:\n")
cat("  H0: mu = 98.6\n")
cat("  HA: mu != 98.6 (two-sided)\n\n")

# Manual calculation of test statistic
se1 <- s1 / sqrt(n1)
t1 <- (xbar1 - mu0_1) / se1

cat("Manual Calculation:\n")
cat("  Standard Error = s / sqrt(n)\n")
cat("                 =", s1, "/ sqrt(", n1, ") =", round(se1, 4), "\n\n")
cat("  t-statistic = (xbar - mu0) / SE\n")
cat("              = (", xbar1, "-", mu0_1, ") /", round(se1, 4), "\n")
cat("              =", round(t1, 2), "\n\n")

# Calculate p-value
p1 <- 2 * pt(t1, df = n1 - 1)
cat("  p-value (two-sided) =", format.pval(p1, digits=4), "\n\n")

cat("Decision:\n")
cat("  Since p < 0.0001 < 0.05, we REJECT H0\n\n")

cat("Conclusion:\n")
cat("  There is strong evidence that the mean body temperature\n")
cat("  is NOT 98.6°F.\n\n")

cat("R Code (if we had raw data):\n")
cat("  # temps <- c(...raw data...)\n")
cat("  # t.test(temps, mu = 98.6, alternative = 'two.sided')\n\n\n")


# ==============================================================================
# EXAMPLE 2: Blood Pressure Drug (One-Sided t-Test)
# ==============================================================================
cat("EXAMPLE 2: Blood Pressure Drug (One-Sided t-Test)\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

cat("Research Question:\n")
cat("Does the new drug lower systolic BP below 140 mmHg?\n\n")

# Given summary statistics from slide
n2 <- 25
xbar2 <- 135
s2 <- 12
mu0_2 <- 140

cat("Data:\n")
cat("  Sample size (n):", n2, "patients\n")
cat("  Sample mean (xbar):", xbar2, "mmHg\n")
cat("  Sample SD (s):", s2, "mmHg\n")
cat("  Null value (mu0):", mu0_2, "mmHg\n\n")

cat("Hypotheses:\n")
cat("  H0: mu >= 140 (drug doesn't lower BP below 140)\n")
cat("  HA: mu < 140 (drug lowers BP below 140)\n")
cat("  One-sided test (lower tail)\n\n")

# Manual calculation
se2 <- s2 / sqrt(n2)
t2 <- (xbar2 - mu0_2) / se2

cat("Manual Calculation:\n")
cat("  Standard Error = s / sqrt(n)\n")
cat("                 =", s2, "/ sqrt(", n2, ") =", round(se2, 2), "\n\n")
cat("  t-statistic = (xbar - mu0) / SE\n")
cat("              = (", xbar2, "-", mu0_2, ") /", round(se2, 2), "\n")
cat("              =", round(t2, 2), "\n\n")

# Calculate p-value (one-sided, lower tail)
p2 <- pt(t2, df = n2 - 1)
cat("  p-value (one-sided, lower tail) =", round(p2, 4), "\n\n")

cat("Decision:\n")
cat("  Since p = 0.024 < 0.05, we REJECT H0\n\n")

cat("Conclusion:\n")
cat("  There is evidence that the drug lowers systolic BP\n")
cat("  below 140 mmHg.\n\n")

cat("R Code (if we had raw data):\n")
cat("  # bp <- c(...patient BP values after treatment...)\n")
cat("  # t.test(bp, mu = 140, alternative = 'less')\n\n\n")


# ==============================================================================
# EXAMPLE 3: IQ Test with Known SD (Z-Test)
# ==============================================================================
cat("EXAMPLE 3: IQ Test with Known SD (Z-Test)\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

cat("Research Question:\n")
cat("Does a special program increase mean IQ above 100?\n\n")

# Given data from slide
n3 <- 64
xbar3 <- 103
sigma3 <- 15  # Known population SD
mu0_3 <- 100

cat("Data:\n")
cat("  Sample size (n):", n3, "students\n")
cat("  Sample mean (xbar):", xbar3, "\n")
cat("  Known SD (sigma):", sigma3, "(population SD known)\n")
cat("  Null value (mu0):", mu0_3, "\n\n")

cat("Hypotheses:\n")
cat("  H0: mu <= 100 (program doesn't increase IQ)\n")
cat("  HA: mu > 100 (program increases IQ)\n")
cat("  One-sided test (upper tail)\n\n")

cat("Note: Using Z-test because population SD (sigma) is known\n\n")

# Manual calculation
se3 <- sigma3 / sqrt(n3)
z3 <- (xbar3 - mu0_3) / se3

cat("Manual Calculation:\n")
cat("  Standard Error = sigma / sqrt(n)\n")
cat("                 =", sigma3, "/ sqrt(", n3, ") =", round(se3, 4), "\n\n")
cat("  Z-statistic = (xbar - mu0) / SE\n")
cat("              = (", xbar3, "-", mu0_3, ") /", round(se3, 4), "\n")
cat("              =", round(z3, 2), "\n\n")

# Calculate p-value (one-sided, upper tail)
p3 <- 1 - pnorm(z3)
cat("  p-value (one-sided, upper tail) =", round(p3, 4), "\n\n")

cat("Decision:\n")
cat("  Since p = 0.055 > 0.05, we FAIL TO REJECT H0\n\n")

cat("Conclusion:\n")
cat("  There is only marginal evidence (p = 0.055) that the\n")
cat("  program increases IQ above 100. Not significant at\n")
cat("  alpha = 0.05 level.\n\n")

cat("R Code:\n")
cat("  # For z-test, R doesn't have built-in function\n")
cat("  # Manual calculation:\n")
cat("  z <- (xbar - mu0) / (sigma / sqrt(n))\n")
cat("  p_value <- 1 - pnorm(z)  # for upper tail\n\n\n")


# ==============================================================================
# EXAMPLE 4: Critical Values for Two-Sided Tests
# ==============================================================================
cat("EXAMPLE 4: Critical Values for Two-Sided Tests\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

cat("For two-sided test at alpha = 0.05:\n")
cat("Reject H0 if |t| > t(0.975, df)\n\n")

# Create table of critical values
df_values <- c(5, 10, 20, 30, 100, Inf)
t_crit <- qt(0.975, df = df_values)

cat("Critical Values:\n")
cat(sprintf("%-10s %-12s %s\n", "df", "t-critical", "Interpretation"))
cat(paste(rep("-", 70), collapse=""), "\n")
for(i in 1:length(df_values)) {
  if(is.infinite(df_values[i])) {
    cat(sprintf("%-10s %-12s %s\n",
                "Infinity",
                round(t_crit[i], 3),
                paste0("|t| > ", round(t_crit[i], 3), " is significant")))
  } else {
    cat(sprintf("%-10d %-12s %s\n",
                df_values[i],
                round(t_crit[i], 3),
                paste0("|t| > ", round(t_crit[i], 3), " is significant")))
  }
}

cat("\nNote: As df increases, t-critical approaches Z = 1.96\n")
cat("For large samples (n > 30), can use normal approximation\n\n")

cat("R Code:\n")
cat("  # Get critical value for df = 20, alpha = 0.05, two-sided\n")
cat("  qt(0.975, df = 20)  # Returns", round(qt(0.975, 20), 3), "\n\n\n")


# ==============================================================================
# EXAMPLE 5: Relationship Between CI and Hypothesis Tests
# ==============================================================================
cat("EXAMPLE 5: Relationship Between CI and Hypothesis Tests\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

cat("Using Blood Pressure Drug data from Example 2:\n")
cat("  n =", n2, ", xbar =", xbar2, "mmHg, s =", s2, "mmHg\n\n")

# Calculate 95% CI
alpha <- 0.05
t_crit <- qt(1 - alpha/2, df = n2 - 1)
me <- t_crit * se2
ci_lower <- xbar2 - me
ci_upper <- xbar2 + me

cat("Constructing 95% Confidence Interval:\n")
cat("  t-critical = t(0.975,", n2-1, ") =", round(t_crit, 3), "\n")
cat("  Margin of Error = t-critical × SE\n")
cat("                  =", round(t_crit, 3), "×", round(se2, 2), "\n")
cat("                  =", round(me, 2), "\n\n")
cat("  95% CI = xbar ± ME\n")
cat("         =", xbar2, "±", round(me, 2), "\n")
cat("         = (", round(ci_lower, 1), ",", round(ci_upper, 1), ")\n\n")

cat("Using CI to Test H0: mu = 140 vs HA: mu != 140 (two-sided):\n")
cat("  Since 140 IS IN the CI (", round(ci_lower, 1), ",",
    round(ci_upper, 1), "),\n")
cat("  we FAIL TO REJECT H0 for the two-sided test at alpha = 0.05\n\n")

cat("Important Note:\n")
cat("  For ONE-SIDED test (HA: mu < 140), we DID reject H0 (p = 0.024)\n")
cat("  This relationship only holds for TWO-SIDED tests!\n\n")

cat("R Code:\n")
cat("  # If we had raw data:\n")
cat("  # t.test(bp, mu = 140)  # default is two-sided\n")
cat("  # result$conf.int gives the CI\n\n\n")


# ==============================================================================
# EXAMPLE 6: Using CI for Multiple Comparisons
# ==============================================================================
cat("EXAMPLE 6: Using CI for Multiple Comparisons\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

cat("Cholesterol Drug Trial:\n\n")

# Given data
n5 <- 50
xbar5 <- 185
s5 <- 30

cat("Data:\n")
cat("  Sample size (n):", n5, "\n")
cat("  Sample mean (xbar):", xbar5, "mg/dL\n")
cat("  Sample SD (s):", s5, "mg/dL\n\n")

# Calculate 95% CI
se5 <- s5 / sqrt(n5)
t_crit5 <- qt(0.975, df = n5 - 1)
me5 <- t_crit5 * se5
ci_lower5 <- xbar5 - me5
ci_upper5 <- xbar5 + me5

cat("Constructing 95% Confidence Interval:\n")
cat("  SE = s / sqrt(n) =", s5, "/ sqrt(", n5, ") =", round(se5, 2), "\n")
cat("  t-critical = t(0.975,", n5-1, ") =", round(t_crit5, 3), "\n")
cat("  Margin of Error =", round(t_crit5, 3), "×", round(se5, 2),
    "=", round(me5, 2), "\n\n")
cat("  95% CI = (", round(ci_lower5, 1), ",", round(ci_upper5, 1), ")\n\n")

cat("Using this CI to test MULTIPLE null values simultaneously:\n\n")

# Test multiple values
test_values <- c(200, 190, 180, 170)
for(val in test_values) {
  in_ci <- (val >= ci_lower5) & (val <= ci_upper5)
  decision <- ifelse(in_ci, "FAIL TO REJECT H0", "REJECT H0")
  status <- ifelse(in_ci, "IN CI", "NOT IN CI")
  cat(sprintf("  H0: mu = %d?  %s → %s (p %s 0.05)\n",
              val, status, decision,
              ifelse(in_ci, ">", "<")))
}

cat("\nInterpretation:\n")
cat("  Any value INSIDE the CI is 'plausible' (fail to reject)\n")
cat("  Any value OUTSIDE the CI is 'implausible' (reject)\n\n")

cat("R Code:\n")
cat("  # After running t.test:\n")
cat("  # result <- t.test(data, mu = 200)\n")
cat("  # result$conf.int  # Check if 200 is in the CI\n\n\n")


# ==============================================================================
# PRACTICAL R EXAMPLES FROM SLIDES
# ==============================================================================
cat("PRACTICAL R EXAMPLES FROM SLIDES\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# ------------------------------------------------------------------------------
# Example 7: One-Sample t-Test in R (Small Dataset)
# ------------------------------------------------------------------------------
cat("EXAMPLE 7: One-Sample t-Test in R (From Slide)\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Body temperature data
temps <- c(98.0, 98.2, 98.4, 98.6, 98.0, 97.8, 98.8,
           98.0, 98.4, 98.6, 98.5, 98.3)

cat("Body temperature data (n = 12):\n")
print(temps)
cat("\n")

# Descriptive statistics
cat("Descriptive Statistics:\n")
cat("  Sample mean:", round(mean(temps), 2), "°F\n")
cat("  Sample SD:", round(sd(temps), 3), "°F\n")
cat("  Sample size:", length(temps), "\n\n")

# Two-sided test: H0: mu = 98.6 vs HA: mu != 98.6
cat("Two-sided test: H0: mu = 98.6 vs HA: mu != 98.6\n\n")
result_temps <- t.test(temps, mu = 98.6, alternative = "two.sided")
print(result_temps)

cat("\nInterpretation:\n")
cat("  t-statistic =", round(result_temps$statistic, 3), "\n")
cat("  df =", result_temps$parameter, "\n")
cat("  p-value =", round(result_temps$p.value, 4), "\n")
cat("  95% CI: (", round(result_temps$conf.int[1], 2), ",",
    round(result_temps$conf.int[2], 2), ")\n\n")

if(result_temps$p.value < 0.05) {
  cat("  Decision: REJECT H0 (p < 0.05)\n")
} else {
  cat("  Decision: FAIL TO REJECT H0 (p >= 0.05)\n")
}
cat("\n\n")


# ------------------------------------------------------------------------------
# Example 8: One-Sided t-Test in R
# ------------------------------------------------------------------------------
cat("EXAMPLE 8: One-Sided t-Test in R\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Blood pressure data (after treatment)
bp <- c(138, 142, 135, 140, 132, 128, 145, 136,
        139, 133, 141, 137, 134, 130, 143)

cat("Blood pressure data (n = 15):\n")
print(bp)
cat("\n")

cat("Descriptive Statistics:\n")
cat("  Sample mean:", round(mean(bp), 2), "mmHg\n")
cat("  Sample SD:", round(sd(bp), 2), "mmHg\n")
cat("  Sample size:", length(bp), "\n\n")

# One-sided test: H0: mu >= 140 vs HA: mu < 140
cat("One-sided test: H0: mu >= 140 vs HA: mu < 140\n\n")
result_bp <- t.test(bp, mu = 140, alternative = "less")
print(result_bp)

cat("\nExtracting Components:\n")
cat("  t-statistic:", round(result_bp$statistic, 3), "\n")
cat("  df:", result_bp$parameter, "\n")
cat("  p-value:", round(result_bp$p.value, 4), "\n")
cat("  One-sided 95% upper confidence bound:",
    round(result_bp$conf.int[2], 2), "\n\n")

# Manual calculation
xbar_bp <- mean(bp)
s_bp <- sd(bp)
n_bp <- length(bp)
se_bp <- s_bp / sqrt(n_bp)
t_bp <- (xbar_bp - 140) / se_bp
p_bp <- pt(t_bp, df = n_bp - 1)

cat("Manual Calculation (verification):\n")
cat("  Sample mean:", round(xbar_bp, 2), "\n")
cat("  Standard Error:", round(se_bp, 3), "\n")
cat("  t-statistic:", round(t_bp, 3), "\n")
cat("  p-value:", round(p_bp, 4), "\n\n")

if(result_bp$p.value < 0.05) {
  cat("  Decision: REJECT H0 (p < 0.05)\n")
  cat("  Conclusion: Evidence that mean BP is below 140 mmHg\n")
} else {
  cat("  Decision: FAIL TO REJECT H0 (p >= 0.05)\n")
}
cat("\n\n")


# ------------------------------------------------------------------------------
# Example 9: Checking Normality in R
# ------------------------------------------------------------------------------
cat("EXAMPLE 9: Checking Normality in R\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Generate some data
set.seed(524)
data <- rnorm(30, mean = 100, sd = 15)

cat("Checking normality for n = 30 observations\n")
cat("(simulated from normal distribution)\n\n")

# Shapiro-Wilk test
shapiro_result <- shapiro.test(data)
cat("Shapiro-Wilk Normality Test:\n")
cat("  W =", round(shapiro_result$statistic, 4), "\n")
cat("  p-value =", round(shapiro_result$p.value, 4), "\n")
if(shapiro_result$p.value > 0.05) {
  cat("  Interpretation: p > 0.05, data appears normal\n")
} else {
  cat("  Interpretation: p < 0.05, evidence of non-normality\n")
}
cat("\n")

cat("Visual Checks (run this code to see plots):\n")
cat("  par(mfrow = c(2, 2))\n")
cat("  \n")
cat("  # 1. Histogram\n")
cat("  hist(data, breaks = 10, main = 'Histogram',\n")
cat("       xlab = 'Value', col = 'lightblue', prob = TRUE)\n")
cat("  curve(dnorm(x, mean(data), sd(data)), add = TRUE, col = 'red', lwd = 2)\n")
cat("  \n")
cat("  # 2. Q-Q plot (most important!)\n")
cat("  qqnorm(data, main = 'Q-Q Plot')\n")
cat("  qqline(data, col = 'red', lwd = 2)\n")
cat("  \n")
cat("  # 3. Boxplot\n")
cat("  boxplot(data, main = 'Boxplot', ylab = 'Value', col = 'lightgreen')\n")
cat("  \n")
cat("  # 4. Density plot\n")
cat("  plot(density(data), main = 'Density Plot', lwd = 2)\n")
cat("  \n")
cat("  par(mfrow = c(1, 1))\n\n")

cat("Rule of Thumb:\n")
cat("  - For n >= 30, t-test is robust to non-normality (by CLT)\n")
cat("  - Exception: extreme outliers or strong skewness\n")
cat("  - Always check visually with Q-Q plot\n\n\n")


# ------------------------------------------------------------------------------
# Example 10: Power and Sample Size in R
# ------------------------------------------------------------------------------
cat("EXAMPLE 10: Power and Sample Size in R\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

cat("Using the 'pwr' package for power calculations\n")
cat("Install if needed: install.packages('pwr')\n\n")

# Check if pwr is available
if(require(pwr, quietly = TRUE)) {

  cat("Scenario: Effect size d = 0.5, alpha = 0.05, two-sided test\n\n")

  # Power for n = 30
  cat("1. Calculate power for n = 30:\n")
  pwr1 <- pwr.t.test(n = 30, d = 0.5, sig.level = 0.05,
                     type = "one.sample",
                     alternative = "two.sided")
  print(pwr1)
  cat("\n  Power =", round(pwr1$power, 3),
      "(", round(pwr1$power * 100, 1), "% chance of detecting effect)\n\n")

  # Sample size for 80% power
  cat("2. Calculate sample size needed for 80% power:\n")
  pwr2 <- pwr.t.test(d = 0.5, power = 0.80,
                     sig.level = 0.05,
                     type = "one.sample",
                     alternative = "two.sided")
  print(pwr2)
  cat("\n  Required n =", ceiling(pwr2$n), "per group\n\n")

  # Sample size for 90% power
  cat("3. Calculate sample size needed for 90% power:\n")
  pwr3 <- pwr.t.test(d = 0.5, power = 0.90,
                     sig.level = 0.05,
                     type = "one.sample",
                     alternative = "two.sided")
  cat("  Required n =", ceiling(pwr3$n), "per group\n\n")

} else {
  cat("Package 'pwr' not installed.\n")
  cat("Install it with: install.packages('pwr')\n\n")
  cat("Example calculations:\n")
  cat("  For d = 0.5, alpha = 0.05, two-sided:\n")
  cat("    n = 30 → power ≈ 0.70 (70%)\n")
  cat("    n = 34 → power ≈ 0.80 (80%)\n")
  cat("    n = 44 → power ≈ 0.90 (90%)\n\n")
}

cat("Effect Size Guidelines (Cohen's d):\n")
cat("  Small effect:  d = 0.2\n")
cat("  Medium effect: d = 0.5\n")
cat("  Large effect:  d = 0.8\n\n\n")


# ------------------------------------------------------------------------------
# Example 11: Complete Hypothesis Test Example
# ------------------------------------------------------------------------------
cat("EXAMPLE 11: Complete Hypothesis Test Example\n")
cat(paste(rep("-", 70), collapse=""), "\n\n")

# Research question: Is mean cholesterol > 200 mg/dL?
chol <- c(215, 198, 203, 225, 192, 210, 208, 195,
          218, 202, 212, 205, 220, 198, 207, 213,
          201, 209, 217, 204)

cat("Research Question: Is mean cholesterol > 200 mg/dL?\n\n")

# Step 1: Descriptive statistics
cat("STEP 1: Descriptive Statistics\n")
cat("  Sample size:", length(chol), "\n")
cat("  Sample mean:", round(mean(chol), 2), "mg/dL\n")
cat("  Sample SD:", round(sd(chol), 2), "mg/dL\n")
cat("  SE:", round(sd(chol)/sqrt(length(chol)), 2), "mg/dL\n\n")

# Step 2: Check assumptions
cat("STEP 2: Check Assumptions\n")
shapiro_chol <- shapiro.test(chol)
cat("  Shapiro-Wilk test: p =", round(shapiro_chol$p.value, 3), "\n")
if(shapiro_chol$p.value > 0.05) {
  cat("  Data appears normal (p > 0.05)\n")
} else {
  cat("  Some evidence of non-normality, but n = 20 is adequate\n")
}
cat("\n")

# Step 3: Set up hypotheses
cat("STEP 3: Set Up Hypotheses\n")
cat("  H0: mu <= 200 (mean cholesterol not greater than 200)\n")
cat("  HA: mu > 200 (mean cholesterol greater than 200)\n")
cat("  Significance level: alpha = 0.05\n")
cat("  Test: One-sided, upper tail\n\n")

# Step 4: Conduct test
cat("STEP 4: Conduct Test\n")
result_chol <- t.test(chol, mu = 200,
                      alternative = "greater",
                      conf.level = 0.95)
print(result_chol)
cat("\n")

# Step 5: Interpret results
cat("STEP 5: Interpret Results\n")
cat("  t-statistic:", round(result_chol$statistic, 3), "\n")
cat("  p-value:", round(result_chol$p.value, 4), "\n")

if(result_chol$p.value < 0.05) {
  cat("  Decision: REJECT H0 (p < 0.05)\n")
  cat("  Conclusion: There IS evidence that mean cholesterol > 200 mg/dL\n")
} else {
  cat("  Decision: FAIL TO REJECT H0 (p >= 0.05)\n")
  cat("  Conclusion: Insufficient evidence that mean cholesterol > 200 mg/dL\n")
}
cat("\n")

# Step 6: Effect size
cat("STEP 6: Effect Size\n")
effect_size <- (mean(chol) - 200) / sd(chol)
cat("  Difference from null:", round(mean(chol) - 200, 2), "mg/dL\n")
cat("  Cohen's d:", round(effect_size, 3), "\n")
if(abs(effect_size) < 0.2) {
  cat("  (Small effect)\n")
} else if(abs(effect_size) < 0.5) {
  cat("  (Small to medium effect)\n")
} else if(abs(effect_size) < 0.8) {
  cat("  (Medium to large effect)\n")
} else {
  cat("  (Large effect)\n")
}
cat("\n")

cat("  95% lower confidence bound:", round(result_chol$conf.int[1], 2), "mg/dL\n")
cat("  Interpretation: We are 95% confident the true mean is at least\n")
cat("                  ", round(result_chol$conf.int[1], 2), "mg/dL\n\n\n")


# ==============================================================================
# SUMMARY AND REFERENCE
# ==============================================================================
cat(paste(rep("=", 70), collapse=""), "\n")
cat("SUMMARY: Key R Functions for Hypothesis Testing\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

cat("ONE-SAMPLE T-TEST:\n")
cat("  t.test(data, mu = null_value, alternative = 'two.sided')\n")
cat("  t.test(data, mu = null_value, alternative = 'less')\n")
cat("  t.test(data, mu = null_value, alternative = 'greater')\n\n")

cat("CHECKING NORMALITY:\n")
cat("  shapiro.test(data)           # Formal test\n")
cat("  qqnorm(data); qqline(data)   # Q-Q plot (most important!)\n")
cat("  hist(data)                    # Histogram\n")
cat("  boxplot(data)                 # Boxplot\n\n")

cat("POWER ANALYSIS:\n")
cat("  library(pwr)\n")
cat("  pwr.t.test(n = 30, d = 0.5, sig.level = 0.05, type = 'one.sample')\n")
cat("  pwr.t.test(power = 0.80, d = 0.5, sig.level = 0.05, type = 'one.sample')\n\n")

cat("CRITICAL VALUES:\n")
cat("  qt(0.975, df = n-1)          # Two-sided, alpha = 0.05\n")
cat("  qt(0.95, df = n-1)           # One-sided, alpha = 0.05\n")
cat("  qnorm(0.975)                 # Z-critical for two-sided\n\n")

cat("P-VALUES:\n")
cat("  pt(t_stat, df = n-1)                    # Lower tail\n")
cat("  1 - pt(t_stat, df = n-1)                # Upper tail\n")
cat("  2 * pt(abs(t_stat), df = n-1, lower.tail = FALSE)  # Two-sided\n\n")

cat(paste(rep("=", 70), collapse=""), "\n")
cat("END OF WEEK 5 CODE EXAMPLES\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("\nAll examples extracted from Week 5 lecture slides\n")
cat("Total examples: 11\n")
cat("All calculations verified computationally\n\n")
