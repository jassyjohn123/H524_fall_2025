#!/usr/bin/env Rscript
# Verification script for Week 5 Hypothesis Testing Worksheet
# All computational problems verified using R

cat(paste(rep("=", 70), collapse=""), "\n")
cat("WEEK 5 HYPOTHESIS TESTING WORKSHEET - VERIFIED ANSWERS\n")
cat(paste(rep("=", 70), collapse=""), "\n\n")

# ============================================================================
# PROBLEM 1: One-Sample t-test (Two-Sided)
# ============================================================================
cat("PROBLEM 1: One-Sample t-test (Two-Sided)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Given: n=25, xbar=98.4, s=0.8, H0: mu=98.6, HA: mu≠98.6\n\n")

n1 <- 25
xbar1 <- 98.4
s1 <- 0.8
mu0_1 <- 98.6
alpha1 <- 0.05

# Part A: SE
se1 <- s1 / sqrt(n1)
cat("Part A - Standard Error:\n")
cat("  SE = s / sqrt(n) = ", s1, " / sqrt(", n1, ") = ", round(se1, 4), "\n\n", sep="")

# Part B: t-statistic
t_stat1 <- (xbar1 - mu0_1) / se1
cat("Part B - t-statistic:\n")
cat("  t = (xbar - mu0) / SE = (", xbar1, " - ", mu0_1, ") / ", round(se1, 4), "\n", sep="")
cat("  t = ", round(t_stat1, 4), "\n\n", sep="")

# Part C: p-value (two-sided)
df1 <- n1 - 1
p_value1 <- 2 * pt(t_stat1, df=df1)  # multiply by 2 for two-sided
cat("Part C - p-value (two-sided, df=", df1, "):\n", sep="")
cat("  p-value = 2 * P(T < ", round(t_stat1, 4), ") = ", round(p_value1, 4), "\n\n", sep="")

# Part D: Decision
decision1 <- ifelse(p_value1 < alpha1, "Reject H0", "Fail to reject H0")
cat("Part D - Decision (alpha=", alpha1, "):\n", sep="")
cat("  ", decision1, " (p-value ", ifelse(p_value1 < alpha1, "<", ">="), " alpha)\n\n", sep="")


# ============================================================================
# PROBLEM 2: One-Sample t-test (One-Sided)
# ============================================================================
cat("\n", paste(rep("=", 70), collapse=""), "\n", sep="")
cat("PROBLEM 2: One-Sample t-test (One-Sided)\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Given: n=40, xbar=285, s=48, H0: mu=260, HA: mu>260\n\n")

n2 <- 40
xbar2 <- 285
s2 <- 48
mu0_2 <- 260
alpha2 <- 0.05

# Part A: SE
se2 <- s2 / sqrt(n2)
cat("Part A - Standard Error:\n")
cat("  SE = ", s2, " / sqrt(", n2, ") = ", round(se2, 4), "\n\n", sep="")

# Part B: t-statistic
t_stat2 <- (xbar2 - mu0_2) / se2
cat("Part B - t-statistic:\n")
cat("  t = (", xbar2, " - ", mu0_2, ") / ", round(se2, 4), " = ", round(t_stat2, 4), "\n\n", sep="")

# Part C: p-value (one-sided, upper tail)
df2 <- n2 - 1
p_value2 <- 1 - pt(t_stat2, df=df2)  # upper tail
cat("Part C - p-value (one-sided upper tail, df=", df2, "):\n", sep="")
cat("  p-value = P(T > ", round(t_stat2, 4), ") = ", round(p_value2, 4), "\n\n", sep="")

# Part D: Decision
decision2 <- ifelse(p_value2 < alpha2, "Reject H0", "Fail to reject H0")
cat("Part D - Decision (alpha=", alpha2, "):\n", sep="")
cat("  ", decision2, "\n\n", sep="")


# ============================================================================
# PROBLEM 3: Critical Value Approach
# ============================================================================
cat("\n", paste(rep("=", 70), collapse=""), "\n", sep="")
cat("PROBLEM 3: Critical Value Approach\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Using data from Problem 2: n=40, xbar=285, s=48, t=", round(t_stat2, 4), "\n\n", sep="")

# Part A: Critical value (one-sided, alpha=0.05)
df3 <- df2
t_crit3 <- qt(1 - alpha2, df=df3)  # upper tail critical value
cat("Part A - Critical value (one-sided, alpha=", alpha2, ", df=", df3, "):\n", sep="")
cat("  t_critical = ", round(t_crit3, 4), "\n\n", sep="")

# Part B: Decision using critical value
decision3 <- ifelse(t_stat2 > t_crit3, "Reject H0", "Fail to reject H0")
cat("Part B - Decision using critical value:\n")
cat("  t_stat = ", round(t_stat2, 4), " vs t_crit = ", round(t_crit3, 4), "\n", sep="")
cat("  ", decision3, " (t_stat ", ifelse(t_stat2 > t_crit3, ">", "<="), " t_crit)\n\n", sep="")

# Part C: Compare methods
cat("Part C - Comparison:\n")
cat("  p-value method: ", decision2, "\n", sep="")
cat("  Critical value method: ", decision3, "\n", sep="")
cat("  Both methods give the same conclusion!\n\n")

# ============================================================================
# PROBLEM 4: Type I and Type II Errors
# ============================================================================
cat("\n", paste(rep("=", 70), collapse=""), "\n", sep="")
cat("PROBLEM 4: Type I and Type II Errors\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Testing H0: New treatment is NOT more effective than standard\n")
cat("         HA: New treatment IS more effective than standard\n\n")

cat("Part A - Type I Error:\n")
cat("  Definition: Reject H0 when H0 is actually true\n")
cat("  In context: Conclude new treatment is more effective when it's NOT\n")
cat("  Consequence: Adopt ineffective treatment, waste resources\n\n")

cat("Part B - Type II Error:\n")
cat("  Definition: Fail to reject H0 when HA is actually true\n")
cat("  In context: Conclude new treatment is NOT more effective when it IS\n")
cat("  Consequence: Miss opportunity to use better treatment, harm patients\n\n")

cat("Part C - Which error is more serious?\n")
cat("  Depends on context! Usually Type II is worse in medical research\n")
cat("  Type II: Patients don't get better treatment (harm)\n")
cat("  Type I: Waste money but investigate further (less harm)\n\n")

# ============================================================================
# PROBLEM 5: Power and Sample Size
# ============================================================================
cat("\n", paste(rep("=", 70), collapse=""), "\n", sep="")
cat("PROBLEM 5: Power and Sample Size\n")
cat(paste(rep("-", 70), collapse=""), "\n")

cat("Part A - Effect of increasing alpha:\n")
cat("  Larger alpha (e.g., 0.10 vs 0.05):\n")
cat("    → Easier to reject H0 (less stringent threshold)\n")
cat("    → P(Type I Error) INCREASES\n")
cat("    → P(Type II Error) DECREASES\n")
cat("    → Statistical power INCREASES\n\n")

cat("Part B - Effect of increasing sample size:\n")
cat("  Larger n:\n")
cat("    → SE decreases (SE = s/sqrt(n))\n")
cat("    → t-statistic gets larger (more extreme)\n")
cat("    → p-values get smaller\n")
cat("    → Easier to detect real effects\n")
cat("    → P(Type II Error) DECREASES\n")
cat("    → Statistical power INCREASES\n")
cat("    → P(Type I Error) UNCHANGED (stays at alpha)\n\n")

# Example calculation: Compare SE for different sample sizes
n_small <- 20
n_large <- 80
s_example <- 10

se_small <- s_example / sqrt(n_small)
se_large <- s_example / sqrt(n_large)

cat("Part B - Numerical Example:\n")
cat("  If s = ", s_example, ":\n", sep="")
cat("    n = ", n_small, " → SE = ", round(se_small, 4), "\n", sep="")
cat("    n = ", n_large, " → SE = ", round(se_large, 4), "\n", sep="")
cat("  Quadrupling n cuts SE in half!\n\n")

# ============================================================================
# PROBLEM 6: Comprehensive Integration Problem
# ============================================================================
cat("\n", paste(rep("=", 70), collapse=""), "\n", sep="")
cat("PROBLEM 6: Comprehensive Integration Problem\n")
cat(paste(rep("-", 70), collapse=""), "\n")
cat("Given: n=50, xbar=7.8 hours, s=1.2 hours\n")
cat("Test: H0: mu=8 vs HA: mu<8 at alpha=0.01\n\n")

n6 <- 50
xbar6 <- 7.8
s6 <- 1.2
mu0_6 <- 8
alpha6 <- 0.01

# Part A: State hypotheses (already stated above)
cat("Part A - Hypotheses:\n")
cat("  H0: mu = 8 hours (drug does NOT reduce sleep time)\n")
cat("  HA: mu < 8 hours (drug DOES reduce sleep time)\n")
cat("  This is a one-sided (lower tail) test\n\n")

# Part B: Calculate SE
se6 <- s6 / sqrt(n6)
cat("Part B - Standard Error:\n")
cat("  SE = ", s6, " / sqrt(", n6, ") = ", round(se6, 4), "\n\n", sep="")

# Part C: Calculate t-statistic
t_stat6 <- (xbar6 - mu0_6) / se6
cat("Part C - t-statistic:\n")
cat("  t = (", xbar6, " - ", mu0_6, ") / ", round(se6, 4), " = ", round(t_stat6, 4), "\n\n", sep="")

# Part D: p-value (one-sided, lower tail)
df6 <- n6 - 1
p_value6 <- pt(t_stat6, df=df6)  # lower tail
cat("Part D - p-value (one-sided lower tail, df=", df6, "):\n", sep="")
cat("  p-value = P(T < ", round(t_stat6, 4), ") = ", round(p_value6, 4), "\n\n", sep="")

# Part E: Decision
decision6 <- ifelse(p_value6 < alpha6, "Reject H0", "Fail to reject H0")
cat("Part E - Decision (alpha=", alpha6, "):\n", sep="")
cat("  ", decision6, "\n", sep="")
cat("  p-value (", round(p_value6, 4), ") ", ifelse(p_value6 < alpha6, "<", ">="), " alpha (", alpha6, ")\n\n", sep="")

# Part F: Interpretation
cat("Part F - Interpretation:\n")
if (p_value6 < alpha6) {
  cat("  There IS sufficient evidence at the 0.01 level to conclude that\n")
  cat("  the new drug reduces mean sleep time below 8 hours.\n\n")
} else {
  cat("  There is NOT sufficient evidence at the 0.01 level to conclude that\n")
  cat("  the new drug reduces mean sleep time below 8 hours.\n\n")
}

# Part G: Critical value approach
t_crit6 <- qt(alpha6, df=df6)  # lower tail critical value
cat("Part G - Critical Value Approach:\n")
cat("  t_critical = ", round(t_crit6, 4), " (lower tail, alpha=", alpha6, ")\n", sep="")
cat("  t_stat = ", round(t_stat6, 4), "\n", sep="")
cat("  Decision: ", ifelse(t_stat6 < t_crit6, "Reject H0", "Fail to reject H0"), "\n", sep="")
cat("  (t_stat ", ifelse(t_stat6 < t_crit6, "<", ">="), " t_crit)\n\n", sep="")


# ============================================================================
# SUMMARY
# ============================================================================
cat("\n", paste(rep("=", 70), collapse=""), "\n", sep="")
cat("ALL CALCULATIONS VERIFIED\n")
cat(paste(rep("=", 70), collapse=""), "\n")
cat("\nKey values for answer key:\n")
cat("  Problem 1: t = ", round(t_stat1, 4), ", p = ", round(p_value1, 4), " (two-sided)\n", sep="")
cat("  Problem 2: t = ", round(t_stat2, 4), ", p = ", round(p_value2, 4), " (one-sided)\n", sep="")
cat("  Problem 3: t_crit = ", round(t_crit3, 4), "\n", sep="")
cat("  Problem 6: t = ", round(t_stat6, 4), ", p = ", round(p_value6, 4), " (one-sided)\n", sep="")
cat("            t_crit = ", round(t_crit6, 4), "\n", sep="")
cat("\n")
